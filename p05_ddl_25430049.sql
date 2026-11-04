CREATE DATABASE IF NOT EXISTS klinik_049
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE klinik_049;

-- Reset tabel agar skrip dapat dijalankan ulang.
-- Urutan penghapusan dimulai dari tabel anak.

DROP TABLE IF EXISTS detail_pembayaran;
DROP TABLE IF EXISTS detail_resep;
DROP TABLE IF EXISTS pembayaran;
DROP TABLE IF EXISTS resep;
DROP TABLE IF EXISTS pemeriksaan;
DROP TABLE IF EXISTS kunjungan;
DROP TABLE IF EXISTS obat;
DROP TABLE IF EXISTS petugas;
DROP TABLE IF EXISTS dokter;
DROP TABLE IF EXISTS pasien;


-- =========================================
-- 1. TABEL PASIEN
-- =========================================

CREATE TABLE pasien (
    id_pasien INT NOT NULL AUTO_INCREMENT,
    no_pasien VARCHAR(10) NOT NULL,
    nama_pasien VARCHAR(100) NOT NULL,
    tgl_lahir_pasien DATE NULL,
    jk_pasien ENUM('L','P') NULL,
    alamat_pasien VARCHAR(200) NULL,
    no_hp_pasien VARCHAR(15) NULL,

    PRIMARY KEY (id_pasien),
    UNIQUE KEY uq_pasien_no (no_pasien)

    -- AB-05: nomor pasien harus unik.
) ENGINE=InnoDB;


-- =========================================
-- 2. TABEL DOKTER
-- =========================================

CREATE TABLE dokter (
    id_dokter INT NOT NULL AUTO_INCREMENT,
    kode_dokter VARCHAR(10) NOT NULL,
    nama_dokter VARCHAR(100) NOT NULL,
    spesialisasi_dokter VARCHAR(100) NULL,
    no_hp_dokter VARCHAR(15) NULL,

    PRIMARY KEY (id_dokter),
    UNIQUE KEY uq_dokter_kode (kode_dokter)

    -- AB-05: kode dokter harus unik.
) ENGINE=InnoDB;


-- =========================================
-- 3. TABEL PETUGAS
-- =========================================

CREATE TABLE petugas (
    id_petugas INT NOT NULL AUTO_INCREMENT,
    kode_petugas VARCHAR(10) NOT NULL,
    nama_petugas VARCHAR(100) NOT NULL,
    peran_petugas ENUM('admin','kasir','perawat')
        NOT NULL,

    PRIMARY KEY (id_petugas),
    UNIQUE KEY uq_petugas_kode (kode_petugas)

    -- AB-05: kode petugas harus unik.
) ENGINE=InnoDB;


-- =========================================
-- 4. TABEL OBAT
-- =========================================

CREATE TABLE obat (
    id_obat INT NOT NULL AUTO_INCREMENT,
    kode_obat VARCHAR(10) NOT NULL,
    nama_obat VARCHAR(100) NOT NULL,
    satuan_obat VARCHAR(20) NOT NULL,
    harga_obat DECIMAL(12,2) NOT NULL DEFAULT 0,
    stok_obat INT NOT NULL DEFAULT 0,

    PRIMARY KEY (id_obat),
    UNIQUE KEY uq_obat_kode (kode_obat),

    CONSTRAINT ck_obat_harga
        CHECK (harga_obat >= 0),

    CONSTRAINT ck_obat_stok
        CHECK (stok_obat >= 0)

    -- AB-XX: harga dan stok tidak boleh negatif.
) ENGINE=InnoDB;


-- =========================================
-- 5. TABEL KUNJUNGAN
-- =========================================

CREATE TABLE kunjungan (
    id_kunjungan INT NOT NULL AUTO_INCREMENT,
    no_kunjungan VARCHAR(10) NOT NULL,
    id_pasien INT NOT NULL,
    id_dokter INT NOT NULL,
    id_petugas INT NOT NULL,
    tanggal_kunjungan DATETIME NOT NULL,
    keluhan VARCHAR(500) NULL,

    PRIMARY KEY (id_kunjungan),
    UNIQUE KEY uq_kunjungan_no (no_kunjungan),

    CONSTRAINT fk_kunjungan_pasien
        FOREIGN KEY (id_pasien)
        REFERENCES pasien (id_pasien),

    CONSTRAINT fk_kunjungan_dokter
        FOREIGN KEY (id_dokter)
        REFERENCES dokter (id_dokter),

    CONSTRAINT fk_kunjungan_petugas
        FOREIGN KEY (id_petugas)
        REFERENCES petugas (id_petugas)

    -- AB-XX: kunjungan harus terhubung ke pasien,
    -- dokter, dan petugas yang tercatat.
) ENGINE=InnoDB;


-- =========================================
-- 6. TABEL PEMERIKSAAN
-- =========================================

CREATE TABLE pemeriksaan (
    id_pemeriksaan INT NOT NULL AUTO_INCREMENT,
    id_kunjungan INT NOT NULL,
    diagnosis VARCHAR(500) NULL,
    tindakan VARCHAR(500) NULL,
    biaya_pemeriksaan DECIMAL(12,2) NOT NULL DEFAULT 0,

    PRIMARY KEY (id_pemeriksaan),

    CONSTRAINT fk_pemeriksaan_kunjungan
        FOREIGN KEY (id_kunjungan)
        REFERENCES kunjungan (id_kunjungan),

    CONSTRAINT ck_pemeriksaan_biaya
        CHECK (biaya_pemeriksaan >= 0)

    -- AB-XX: biaya pemeriksaan tidak boleh negatif.
) ENGINE=InnoDB;


-- =========================================
-- 7. TABEL RESEP
-- =========================================

CREATE TABLE resep (
    id_resep INT NOT NULL AUTO_INCREMENT,
    id_kunjungan INT NOT NULL,
    tanggal_resep DATETIME NOT NULL,
    catatan_resep VARCHAR(500) NULL,

    PRIMARY KEY (id_resep),

    CONSTRAINT fk_resep_kunjungan
        FOREIGN KEY (id_kunjungan)
        REFERENCES kunjungan (id_kunjungan)
) ENGINE=InnoDB;


-- =========================================
-- 8. TABEL DETAIL_RESEP
-- =========================================

CREATE TABLE detail_resep (
    id_resep INT NOT NULL,
    id_obat INT NOT NULL,
    jumlah_obat INT NOT NULL,
    aturan_pakai VARCHAR(200) NOT NULL,

    PRIMARY KEY (id_resep, id_obat),

    CONSTRAINT fk_detail_resep_resep
        FOREIGN KEY (id_resep)
        REFERENCES resep (id_resep)
        ON DELETE CASCADE,

    CONSTRAINT fk_detail_resep_obat
        FOREIGN KEY (id_obat)
        REFERENCES obat (id_obat),

    CONSTRAINT ck_detail_resep_jumlah
        CHECK (jumlah_obat > 0)

    -- AB-XX: jumlah obat per item harus lebih dari nol.
) ENGINE=InnoDB;


-- =========================================
-- 9. TABEL PEMBAYARAN
-- =========================================

CREATE TABLE pembayaran (
    no_pembayaran VARCHAR(12) NOT NULL,
    id_kunjungan INT NOT NULL,
    tanggal_bayar DATETIME NOT NULL,
    status_pembayaran ENUM('Belum Lunas','Lunas')
        NOT NULL DEFAULT 'Belum Lunas',

    PRIMARY KEY (no_pembayaran),
    UNIQUE KEY uq_pembayaran_kunjungan (id_kunjungan),

    CONSTRAINT fk_pembayaran_kunjungan
        FOREIGN KEY (id_kunjungan)
        REFERENCES kunjungan (id_kunjungan)

    -- Satu kunjungan memiliki paling banyak satu
    -- catatan pembayaran pada rancangan ini.
) ENGINE=InnoDB;


-- =========================================
-- 10. TABEL DETAIL_PEMBAYARAN
-- =========================================

CREATE TABLE detail_pembayaran (
    no_pembayaran VARCHAR(12) NOT NULL,
    no_baris SMALLINT NOT NULL,
    jenis_biaya VARCHAR(50) NOT NULL,
    keterangan_biaya VARCHAR(200) NULL,
    jumlah_biaya DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (no_pembayaran, no_baris),

    CONSTRAINT fk_detail_pembayaran_pembayaran
        FOREIGN KEY (no_pembayaran)
        REFERENCES pembayaran (no_pembayaran)
        ON DELETE CASCADE,

    CONSTRAINT ck_detail_pembayaran_jumlah
        CHECK (jumlah_biaya >= 0)

    -- AB-XX: jumlah biaya per baris tidak boleh negatif.
) ENGINE=InnoDB;


-- =========================================
-- PEMERIKSAAN HASIL
-- =========================================

SHOW TABLES;

SHOW CREATE TABLE pasien;
SHOW CREATE TABLE kunjungan;
SHOW CREATE TABLE pembayaran;
SHOW CREATE TABLE detail_pembayaran;