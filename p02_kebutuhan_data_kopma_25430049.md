 Dokumen Kebutuhan Data - Koperasi Mahasiswa Sejahtera (Kopma)

 1. Latar Belakang dan Aktivitas Organisasi

 Koperasi Mahasiswa Sejahtera atau Kopma merupakan koperasi yang berada di lingkungan kampus. Kopma menjual berbagai kebutuhan seperti alat tulis, makanan ringan, dan minuman. Pembelinya bisa berasal dari anggota koperasi maupun pembeli umum.
 Selain kegiatan penjualan, Kopma juga mempunyai kegiatan pendaftaran anggota, pengecekan stok barang, pemesanan barang kepada pemasok, dan penerimaan barang yang datang.
 Setiap awal bulan, ketua koperasi membutuhkan laporan untuk melihat kondisi penjualan dan stok. Laporan tersebut digunakan untuk mengetahui omzet, barang yang paling banyak terjual, stok yang mulai menipis, dan anggota yang paling aktif berbelanja.

 2. Aktor dan Proses Bisnis

 | Kode | Proses bisnis        | Aktor | Pemicu |
| PB-01 | Mendaftarkan anggota | Kasir | Mencatat data mahasiswa yang ingin menjadi anggota |
| PB-02 | Mencatat penjualan   | Kasir | Mencatat barang yang dibeli dan membuat nota |
| PB-03 | Memesan barang ke pemasok | Petugas Gudang | Memesan barang ketika stok di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas Gudang | Mencatat barang yang datang berdasarkan faktur |
| PB-05 | Menyusun laporan bulanan | Petugas Gudang | Melihat hasil penjualan, stok, dan aktivitas anggota |

 3. Dokumen Sumber yang Dianalisis

 Dokumen yang dianalisis adalah nota penjualan.

 Dari nota tersebut terdapat beberapa data yang diperlukan, seperti nomor nota, tanggal, waktu, kasir, anggota, barang, jumlah barang, dan harga saat transaksi.
 Nota juga mempunyai subtotal dan total. Namun, beberapa nilai tersebut dapat dihitung dari data yang sudah ada sehingga perlu dipertimbangkan apakah harus disimpan atau cukup dihitung saat dibutuhkan.

 4. Entitas Kandidat dan Elemen Data
 ## Before modifikasi
| Entitas kandidat | Elemen data utama | Sumber |
| Anggota | Nomor anggota, NIM, Nama, Program studi, Nomor HP, Status aktif, Poin royalitas | Formulir    pendaftaran |
| Barang | Kode barang, Nama barang, satuan, harga jual, Stok, Batas minimum stok | Daftar barang faktur |
| Penjualan | Nomor nota, Tanggal, Waktu, Kasir, Anggota, Total transaksi | Nota penjualan |
| Detail penjualan | Nomor nota, Kode barang, Jumlah barang, Harga satuan, Subtotal | Nota penjualan |
| Petugas | ID petugas, Nama petugas, Jabatan | Wawancara |
| Pemasok | ID pemasok, Nama pemasok, Alamat, Nomor telepon | Faktur Pemasok |
| Pembelian | Nomor pembelian, Tanggal pembelian, Pemasok, Petugas, Status Pembelian | Faktur pemasok |
| Detail pembelian | Nomor pembelian, Kode barang, Jumlah barang, Harga beli | Faktur pemasok |

 ### Hasil D.1 — Penandaan kunci dan atribut turunan

| Entitas kandidat | Elemen data utama | Status |
|---|---|---|
| anggota | **id_anggota (PK)**, no_anggota (AK), npm_anggota (AK), nama_anggota, prodi_anggota, no_wa_anggota, status_anggota, poin_loyalitas | no_anggota dan npm_anggota merupakan kunci alternatif karena keduanya unik. |
| barang | **id_barang (PK)**, kode_barang (AK), nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang | kode_barang merupakan kunci alternatif. |
| penjualan | **id_penjualan (PK)**, no_nota_penjualan (AK), tgl_penjualan, id_petugas (FK), id_anggota (FK, opsional), bayar_penjualan | no_nota_penjualan merupakan kunci alternatif. total merupakan atribut turunan. |
| detail_penjualan | **id_penjualan (PK, FK)**, **id_barang (PK, FK)**, qty_detail_penjualan, harga_satuan_detail_penjualan | PK komposit terdiri dari id_penjualan dan id_barang. subtotal merupakan atribut turunan. |

**Keterangan:**
- PK = Primary Key / kunci primer.
- AK = Alternate Key / kunci alternatif.
- FK = Foreign Key / kunci tamu.
- `subtotal` diturunkan dari `qty × harga_satuan`.
- `total` diturunkan dari penjumlahan subtotal dalam satu nota.
- `poin_loyalitas` berkaitan dengan anggota dan akan dibahas lebih lanjut pada latihan Modul 3 untuk menentukan apakah cukup sebagai atribut anggota atau membutuhkan entitas riwayat poin.

### Pemecahan entitas pembelian

Sesuai langkah D.1, entitas kandidat **“Pembelian dan detailnya”** dipecah menjadi dua entitas:

| Entitas | Atribut utama | Status |
|---|---|---|
| pembelian | **id_pembelian (PK)**, no_faktur_pembelian (AK), tgl_pembelian, id_pemasok (FK), status_pembelian | no_faktur_pembelian merupakan kunci alternatif. |
| detail_pembelian | **id_pembelian (PK, FK)**, **id_barang (PK, FK)**, qty_detail_pembelian, harga_beli_detail_pembelian | PK komposit terdiri dari id_pembelian dan id_barang. |

### Entitas yang digunakan setelah D.1

Hasil identifikasi D.1 menjadi:
1. `anggota`
2. `barang`
3. `petugas`
4. `penjualan`
5. `detail_penjualan`
6. `pemasok`
7. `pembelian`
8. `detail_pembelian`

 5. Aturan Bisnis

 AB-01 Setiap nota memiliki nomor unik dan minimal satu baris barang.
 AB-02 Penjualan boleh tanpa anggota (pembeli umum); jika ada, anggota harus berstatus aktif untuk memperoleh diskon 5%.
 AB-03 Stok barang tidak boleh negatif; penjualan ditolak bila qty melebihi stok tersedia.
 AB-04 Harga jual yang dipakai pada nota disimpan per baris dan tidak berubah meski harga barang kemudian naik.
 AB-05 NIM anggota unik; pencarian anggota dapat dilakukan lewat nomor anggota atau NIM.
 AB-06 Pesanan pembelian dibuat bila stok kurang dari batas minimum barang tersebut.
 AB-07 Setiap kelipatan Rp10.000 belanja mendapatkan 1 poin.
 AB-08 50 poin dapat ditukar dengan potongan Rp5.000.

 6. Kebutuhan Informasi

 KI-01 Omzet dan jumlah nota per hari dan per bulan 
 KI-02 Lima barang terlaris per bulan berdasarkan qty
 KI-03 Barang dengan stok di bawah batas minimum
 KI-04 Sepuluh anggota dengan belanja terbesar perbulan
 KI-05 Menampilkan daftar barang yang paling sering dibeli oleh anggota.

 7. Matriks CRUD
 
 | Proses | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian |
| PB-01 | C |   |   |   |   |   |
| PB-02 | R,u | R,u | C | C |   |   |
| PB-03 |   | R |   |   | R | C |
| PB-04 |   | U |   |   | R | U |
| PB-05 | R | R | R | R | R |  R|

 Keterangan:
 C = Create / membuat data
 R = Read / membaca data
 U = Update / mengubah data
 D = Delete / menghapus data

 8. Kamus Data Awal
 | Nama Data  | Arti              | Contoh       | Aturan              | Penanggung Jawab |
| `no_anggota`| Nomor anggota koperasi | A-0457  | Harus unik          | Ketua            |
| `nim_anggota`   | NIM anggota   | 2301010123   | Harus unik          | Ketua            |
| `nama_anggota`  | Nama anggot   | Andi         | Tidak boleh kosong  | Ketua            |
| `no_hp_anggota` | Nomor HP anggo| 081234567890 | Data pribadi        | Ketua            |
| `kode_barang`   | Kode barang   | ATK001       | Harus unik          | Gudang           |
| `nama_barang`   | Nama barang   | Pulpen       | Tidak boleh kosong  | Gudang           |
| `harga_satuan`  | Harga barang saat transaksi | 4000| Tidak boleh negatif |  kKasir            |
| `stok_barang`   | Jumlah stok barang| 35       | Tidak boleh negatif | Gudang           |
| `no_nota`       | Nomor nota penjualan| PJ-001 | Harus unik          | Kasir            |
| `jumlah_barang` | Jumlah barang yang dibeli | 2| Lebih dari 0        | Kasir            |

 9. Kebutuhan Non-Fungsional Data
 
 9.1 Volume
 Kopma diperkirakan melakukan sekitar 150 transaksi atau nota per hari. Database harus mampu menampung data tersebut dengan baik.

 9.2 Retensi
 Data transaksi harus disimpan paling lama 5 tahun karena masih bisa digunakan ketika diperlukan untuk melakukan transaksi lama.

 9.3 Privasi
 Data pribadi orang, nomor telepon tidak boleh dilihat oleh semua pengguna data tersebut perlu dibatasi sesuai dengan tugas masing-masing.

 10. Isu Kualitas Data yang Diantisipasi
 Masalah yang mungkin terjadi adalah : 
 - Data anggota ganda, misalnya satu orang terdaftar lebih dari satu kali.
 - NIM salah atau tidak sesuai, sehingga data anggota sulit dicari.
 - Stok menjadi minus karena jumlah barang yang terjual lebih banyak dari pafda stok yang tersedia.
 - Harga lama berubah, sehingga harga pada transaksi lama menjadi tidak sesuai.
 - Data barang tidak lengkap misalnya nama atau barang belum terisi.
 - Data nomor HP salah, sehingga sulit menghubungi anggota.

 Untuk mengurangi masalah tersebut, data perlu diberi aturan seperti NIM dan nomor anggota harus unik, stok tidak boleh negatif, dan harga saat transaksi harus tetap disimpan.