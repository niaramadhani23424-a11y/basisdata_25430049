 Dokumen Kebutuhan Data - Klinik Nia Sehat

 1. Latar belakang dan aktivitas organisasi

 Klinik Nia Sehat adalah klinik fiktif yang melayani pemeriksaan kesehatan untuk masyarakat. Kegiatan utama di klinik ini adalah pendaftaran pasien, pemeriksaan pasien oleh dokter, pencatatan hasil pemeriksaan, pemberian resep obat, pembayaran, dan pengelolaan data obat.
 Pasien yang datang terlebih dahulu melakukan pendaftaran. Setelah itu pasien menunggu untuk diperiksa oleh dokter. Dokter mencatat hasil pemeriksaan dan jika diperlukan akan memberikan resep obat. Petugas kemudian mencatat obat yang diberikan kepada pasien.
 Klinik juga perlu menyimpan data pasien, dokter, kunjungan, pemeriksaan, obat, dan pembayaran. Data tersebut nantinya dapat digunakan untuk melihat riwayat pemeriksaan pasien, mengetahui obat yang digunakan, dan membuat laporan kegiatan klinik.

 2. Aktor dan proses bisnis
 | Kode  | Proses bisnis | Aktor | Pemicu |
 | PB-01 | Mendaftarkan Pasien | Petugas Pendaftaran | Pasien datang ke Klinik |
 | PB-02 | Mencatat Kunjungan pasien | Petugas Pendaftaran | Pasien melakukan pemeriksaan |
 | PB-03 | Melakukan pemeriksaan pasien | Dokter | Pasien masuk ke ruang pemeriksaan |
 | PB-04 | Memberikan obat berdasarkan resep | Dokter | Pemberian resep |
 | PB-05 | Mencatat pembayaran | Kasir | Pasien selesai mendapatkan layanan | 

 3. Dokumen Sumber Yang dianalisis
 Dokumen yang digunakan sebagai sumber data adalah:

- Formulir pendaftaran pasien
- Kartu atau data identitas pasien
- Catatan pemeriksaan pasien
- Resep obat
- Bukti pembayaran
 Dari dokumen tersebut dapat diketahui data yang perlu disimpan, seperti identitas pasien, data dokter, tanggal kunjungan, keluhan, hasil pemeriksaan, obat, dan biaya pelayanan.

4. Entitas kandidat dan elemen data
| Entitas kandidat | Elemen data utama | Sumber |
| Pasien | ID pasien, NIK, nama, tanggal lahir, alamat, nomor HP | Formulir pendaftaran |
| Dokter | ID Dokter, nama dokter, Spesialis, nomor hp | Data Dokter | 
| Kunjungan | ID kunjungan, tanggal, pasien, dokter, keluhan | Catatan Kunjungan |
| Pemeriksaan | ID pemeriksaan, ID kunjungan, hasil pemeriksaan, diagnosis | Catatan Pemeriksaan |
| Obat | ID obat, nama obat, jenis obat, stok, harga | Data Obat |
| Resep | ID obat, nama obat, jenis obat, stok, harga | Resep Obat |
| Detail resep | ID obat, nama obat, jenis obat, stok, harga | Resep Obat |
| Pembayaran |ID pembayaran, ID kunjungan, tanggal, total biaya, status pembayaran| Bukti Pembayaran | 

5. Aturan Bisnis
| Kode | Aturan bisnis | 
| AB-01 | Setiap pasien harus memiliki ID pasien yang berbeda | 
| AB-02 | Satu pasien dapat melakukan lebih dari satu kunjungan ke klinik |
| AB-03 | Setiap kunjungan ditandatangani satu dokter | 
| AB-04 | Hasil pemeriksaan dicatat berdasarkan kunjungan pasien |
| AB-05 | Obat yang diberikan kepada pasien harus berdasarkan resep dari dokter |
| AB-06 | Stok obat tidak boleh bernilai negatif | 

6. Kebutuhan Informasi 
| Kode | Kebutuhan informasi | Data yang diperlukan |
| KI-01 | Menampilkan riwayat kunjungan pasien | Pasien, kunjungan, dokter, pemeriksaan |
| KI-02 | Menampilkan hasil kunjungan pasien | Pasien, kunjungan, pemeriksaan |
| KI-03 | Menampilkan daftar obat dan stok obat | Obat |
| KI-04 | Menampilkan laporan pembayaran pasien | Pasien, kunjungan, pembayaran | 

7. Matriks CRUD 
 | Proses | Pasien | Dokter | Kunjungan | Pemeriksaan | Obat | Resep | Pembayaran |
 | PB-01 | C | R |   |   |   |   |  |
 | PB-02 | R | R | C |   |   |   |  |
 | PB-03 | R | R | R | C |   | C |  | 
 | PB-04 | R |   | R | R, U | R, C |  |
 | PB-05 | R |   | R |   |   |   | C |
 Keterangan:

- C = membuat data
- R = membaca data
- U = mengubah data
- D = menghapus data

8. Kamus data awal 
| Elemen | Arti | Contoh | Aturan | Penanggung jawab |
| `id_pasien`| Nomor identitas pasien di klinik | PS001 | Harus unik | Petugas Pendaftaran |
| `nik_pasien`| Nomor identitas pasien | 1871234567890123 | Harus unik | petugas pendaftaran |
| `nama_pasien`| Nama lengkap pasien | Regina aulia wijayani | Tidak boleh kopsong | petugas pendaftaran |
| `no_hp_pasien`| No hp pasien | 085758595051 | Data pribadi | Petugas pendaftaran | 
| `id_dokter`| Nomor identitas dokter |  DR001 | Harus unik | admin klinik |
| `nama_dokter`| Nama dokter | Dr.Galeh | Tidak boleh kosong | admin klinik |
| `id_kunjungan`| Nomor kunjungan pasien | KJ001 | Harus unik | Petugas Pendaftaran |
| `tanggal_kunjungan`| Tanggal pasien datang | 01-oktober-2026 | Tidak boleh kosong | Petugas Pendaftaran |
| `keluhan`| Keluhan yang dirasakan pasien | Demam dan batuk | Dicatat saat pemeriksaan | Dokter |
| `diagnosis`| hasil diagnosis dokter | influenza | dicatat oleh dokter | Dokter |
| `id_obat`| Nomor identitas obat | OB001 | Harus unik | Petugas Apotek |
| `nama_obat`| Nama obat | paracetamol | tidak boleh kosong | petugas apotek |
| `stok_obat`| Jumlah obat yang tersedia | 50 |Tidak boleh negatif | Petugas Apotek |
| `jumlah_obat`| Jumlah obat yang diberikan | 10 |  Harus lebih dari 0 | Petugas Apotek |
| `id_pembayaran`| Nomor pembayaran | BY001 | Harus unik | Kasir |
| `total_biaya`| Total biaya yang harus dibayar | 75000 | Tidak boleh negatif | Kasir |
| `status_pembayaran`| Status pembayaran pasien | Lunas | Lunas atau Belum Lunas | Kasir |

9. Kebutuhan non-fungsional data

9.1 Volume
 Klinik perlu menyimpan data pasien dan kunjungan yang terus bertambah setiap hari. berdasarkan nilai p=5 perkiraan volume transaksi adalah 40 + (5 × 5) = 65 transaksi per hari. Database juga mampu menyimpan data pendaftaran, pemeriksaan, resep, obat, dan pembayaran tanpa mengganggu proses pelayanan. Dalam satu transaksi, batas maksimal item adalah P + 2 = 7 item.
9.2 Retensi 
 Data pasien dan riwayat kunjungan perlu disimpan dalam jangka panjang agar petugas dan dokter dapat melihat riwayat pemeriksaan pasien ketika dibutuhkan.
9.3 Privasi
 Data pasien merupakan data penting dan harus dijaga seperti, NIK, alamat, No hp, dan hasil pemeriksaan tidak boleh dilihat oleh semua pengguna akses data harus disesuaikan dengan tugas masing-masing, misalnya dokter dapat melihat data pemeriksaan pasien, sedangkan kasir hanya membutuhkan data yang berkaitan dengan pembayaran.
9.4 hak akses 
| Jenis data            | Pihak yang boleh mengakses     |
| --------------------- | ------------------------------ |
| Data identitas pasien | Petugas pendaftaran dan pasien |
| Riwayat pemeriksaan   | Dokter                         |
| Diagnosis             | Dokter                         |
| Data resep            | Dokter dan petugas apotek      |
| Data obat             | Petugas apotek                 |
| Data pembayaran       | Kasir                          |

10. Dokumen sumber fiktif dan pembedahanya.

10.1 Formulir pendaftaran pasien
No. Pasien       : PS001
NIK              : 1871234567890123
Nama             : Regina Aulia Wijayanti
Tanggal Lahir    : 10-05-2005
Jenis Kelamin    : P
Alamat           : Jl. Melati
No. HP           : 085758595051
Tanggal Daftar   : 05-10-2026

10.2 Nota pembayaran pasien 

              KLINIK NIA SEHAT
          Bukti Pembayaran Pasien
---------------------------------------
No. Pembayaran : BY001
Tanggal         : 05-10-2026
Nama Pasien     : Regina Aulia Wijayanti
No. Pasien      : PS001
Dokter          : Dr. Galeh
No. Kunjungan   : KJ001

Layanan:
Pemeriksaan Dokter       Rp50.000
Obat                     Rp25.000
---------------------------------------
Total Biaya              Rp75.000
Status Pembayaran        Lunas
---------------------------------------
           Terima kasih

10.3 Pembedahan dokumen 

| Data  | Keterangan |
| No pembayaran | digunakan sebagai identitas pembayaran dan harus unik |
| Tanggal | Menunjukan tanggal pembayaran dilakukan |
| Nama pasien | Menujukan pasien yang melakukan pembayaran |
| No pasien | Digunakan untuk menghubungkan pembayaran dengan data pasien |
| Dokter | Menunjukan dokter yang menangani pasien |
| No kunjungan | Digunakan untuk menghubungkan pembayaran dengan data kunjungan |
| Pemeriksaan dokter | Menunjukan biaya pemeriksaan pasien |
| Obat | Menujukan biaya obat yang diberikan kepada pasien |
| Total biaya | Menunjukan jumlah biaya yang harus dibayar pasien |
| Status pembayaran | Menunjukan apakah pembayaran sudah lunas atau belum |

 