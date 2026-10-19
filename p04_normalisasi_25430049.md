# F. Tugas Mandiri: Milestone Proyek 4
## F2. Dokumen Sumber dan Bentuk UNF
BUKTI_PEMBAYARAN_UNF(no_pembayaran, tanggal_bayar, id_pasien, nama_pasien, id_kunjungan, id_dokter, nama_dokter, {rincian_biaya}, total_pembayaran, status_pembayaran)

Tanda {rincian_biaya} menunjukkan bahwa satu pembayaran dapat memiliki lebih dari satu rincian biaya.
## F3. Dependensi Fungsional
| Dependensi Fungsional | Keterangan |
|---|---|
| `no_pembayaran → tanggal_bayar, id_kunjungan, status_pembayaran` | Nomor pembayaran menentukan data utama pembayaran. |
| `id_kunjungan → id_pasien, id_dokter` | Nomor kunjungan menentukan pasien dan dokter yang menangani kunjungan tersebut. |
| `id_pasien → nama_pasien` | ID pasien menentukan nama pasien. |
| `id_dokter → nama_dokter` | ID dokter menentukan nama dokter. |
| `(no_pembayaran, no_baris) → jenis_biaya, keterangan, qty, harga_satuan` | Nomor pembayaran dan nomor baris menentukan rincian biaya. |
Dependensi ini mengikuti rancangan data klinik. Kode AB yang dirujuk perlu disesuaikan dengan daftar aturan bisnis AB-01 sampai AB-06 yang sudah dibuat pada Modul 2
## F4. Tahapan Normalisasi
### Bentuk UNF
BUKTI_PEMBAYARAN_UNF (no_pembayaran, tanggal_bayar, id_kunjungan, id_pasien, nama_pasien, id_dokter, nama_dokter, {jenis_biaya, keterangan, qty, harga_satuan}, total_pembayaran, status_pembayaran)
rincian pemeriksaan dokter dan obat masih berada dalam satu kelompok rincian pembayaran.
### Bentuk 1NF
PEMBAYARAN_1NF (no_pembayaran, no_baris, tanggal_bayar, id_kunjungan, id_pasien, nama_pasien, id_dokter, nama_dokter, jenis_biaya, keterangan, qty, harga_satuan, total_pembayaran, status_pembayaran)
kunci utama sementara adalah gabungan (no_pembayaran, no_baris) karena satu pembayaran dapat memiliki beberapa rinciann 
### Bentuk 2NF
PEMBAYARAN_2NF
no_pembayaran (PK),
tanggal_pembayaran,
no_kunjungan,
no_pasien,
nama_pasien,
id_dokter,
nama_dokter,
status_pembayaran
kunci utama : no_pembayaran 

DETAIL_PEMBAYARAN 
no_pembayaran (PK, FK),
no_baris (PK),
jenis_biaya,
keterangan,
qty,
harga_satuan
kunci tamu : no_pembayaran yang merujuk ke tabel PEMBAYARAN.

### Bentuk 3NF 
PASIEN 
no_pasien (PK),
nama_pasien

DOKTER 
id_dokter (PK),
nama_dokter

KUNJUNGAN
no_kunjungan (PK),
no_pasien (FK),
id_dokter (FK)

PEMBAYARAN 
no_pembayaran (PK),
tanggal_pembayaran,
no_kunjungan (FK),
status_pembayaran

DETAIL_PEMBAYARAN 
no_pembayaran (PK, FK),
no_baris (PK),
jenis_biaya,
keterangan,
qty,
harga_satuan

### pemeriksaan BCNF
| Tabel               | Penentu utama                    | Hasil                                      |
|---------------------|----------------------------------|--------------------------------------------|
| PASIEN              | `id_pasien`                      | Memenuhi BCNF                              |
| DOKTER              | `id_dokter`                      | Memenuhi BCNF                              |
| KUNJUNGAN           | `id_kunjungan`                   | Memenuhi BCNF                              |
| PEMBAYARAN          | `no_pembayaran`                  | Memenuhi BCNF                              |
| DETAIL_PEMBAYARAN   | `(no_pembayaran, no_baris)`      | Memenuhi BCNF berdasarkan dependensi yang ditetapkan |

# F5. Keputusan Penyimpanan Nilai Turunan
Nilai turunan adalah nilai yang dapat diperoleh dari perhitungan atribut lain.
Subtotal rincian biaya : dihitung dari qty x harga_satuan dan tidak disimpan secara terpisah pada tabel operasional agar tidak terjadi ketidak sesuain nilai.
Total pembayaran : dihitung dari penjumlahan seluruh subtotal rincian biaya. total dapat dihitung ketika dibutuhkan sehingga tidak perlu disimpan berulang pada setiap rincian.
Harga satuan : tetap disimpan pada detail_pembayaran karena nharga layanan atau obat dapat berubah. Harga pada transaksi lama harus tetap sesuai dengan harga ketika pembayaran dilakukan.
Status pembayaran : disimpan karena menunjukkan keadaan pembayaran, misalnya lunas atau belum lunas dan bukan sekedar hasil penjumlahan biaya.

