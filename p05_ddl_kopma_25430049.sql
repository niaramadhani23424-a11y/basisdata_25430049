DROP TABLE IF EXISTS detail_pembelian;
DROP TABLE IF EXISTS pembelian;
DROP TABLE IF EXISTS detail_penjualan;
DROP TABLE IF EXISTS penjualan;
DROP TABLE IF EXISTS pemasok;
DROP TABLE IF EXISTS barang;
DROP TABLE IF EXISTS anggota;
DROP TABLE IF EXISTS petugas;

USE KOPMA_25430049 
CREATE TABLE petugas (
  id_petugas    SMALLINT                       NOT NULL AUTO_INCREMENT,
  kode_petugas  CHAR(3)                        NOT NULL,
  nama_petugas  VARCHAR(100)                   NOT NULL,
  peran_petugas ENUM('kasir','gudang','ketua') NOT NULL,
  PRIMARY KEY (id_petugas),
  UNIQUE KEY uq_petugas_kode (kode_petugas)
) ENGINE=InnoDB;
CREATE TABLE barang (
  id_barang         INT                             NOT NULL 
AUTO_INCREMENT,
  kode_barang       VARCHAR(10)                     NOT NULL,
  nama_barang       VARCHAR(100)                    NOT NULL,
  kategori_barang   ENUM('ATK','makanan','minuman') NOT NULL,
  harga_jual_barang DECIMAL(12,2)                   NOT NULL,
  stok_barang       INT                             NOT NULL DEFAULT 0,
  stok_min_barang   INT                             NOT NULL DEFAULT 5,
  PRIMARY KEY (id_barang),
  UNIQUE KEY uq_barang_kode (kode_barang),
  CONSTRAINT ck_barang_stok  CHECK (stok_barang >= 0),
  CONSTRAINT ck_barang_harga CHECK (harga_jual_barang >= 0)
) ENGINE=InnoDB;
CREATE TABLE anggota (
    id_anggota INT NOT NULL AUTO_INCREMENT,
    no_anggota VARCHAR(10) NOT NULL,
    nim_anggota VARCHAR(15) NOT NULL,
    nama_anggota VARCHAR(100) NOT NULL,
    prodi_anggota VARCHAR(100) NOT NULL,
    no_hp_anggota VARCHAR(15),
    status_anggota ENUM('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
    tgl_daftar_anggota DATE NOT NULL,
    poin_loyalitas INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_anggota),
    UNIQUE KEY uq_anggota_no (no_anggota),
    UNIQUE KEY uq_anggota_nim (nim_anggota),
    CONSTRAINT ck_anggota_poin CHECK (poin_loyalitas >= 0)
) ENGINE=InnoDB;
CREATE TABLE pemasok (
    id_pemasok INT NOT NULL AUTO_INCREMENT,
    kode_pemasok VARCHAR(10) NOT NULL,
    nama_pemasok VARCHAR(100) NOT NULL,
    alamat_pemasok VARCHAR(200),
    no_hp_pemasok VARCHAR(15),
    PRIMARY KEY (id_pemasok),
    UNIQUE KEY uq_pemasok_kode (kode_pemasok)
) ENGINE=InnoDB;