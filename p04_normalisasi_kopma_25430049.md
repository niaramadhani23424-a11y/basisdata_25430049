# D. Langkah Percobaan
## D.1 Dari UNF ke 1NF
NOTA_UNF (no_nota_penjualan, tgl_penjualan, kode_petugas, nama_petugas, 
no_anggota, nama_anggota,
          { kode_barang, nama_barang, qty_detail_penjualan, 
harga_satuan_detail_penjualan, subtotal_detail_penjualan },
          jumlah_penjualan, diskon_penjualan, total_penjualan)
## bentuk INF 
NOTA_1NF (no_nota_penjualan, kode_barang, tgl_penjualan, kode_petugas, 
nama_petugas, no_anggota,
          nama_anggota, nama_barang, qty_detail_penjualan, 
harga_satuan_detail_penjualan, subtotal_detail_penjualan, 
jumlah_penjualan, diskon_penjualan, total_penjualan)

# D.2 Menuliskan Dependensi Fungsional
FD1: no_nota_penjualan -> tgl_penjualan, kode_petugas, no_anggota 
(AB-01)
FD2: kode_petugas      -> nama_petugas
FD3: no_anggota        -> nama_anggota 
(AB-05)
FD4: kode_barang       -> nama_barang
FD5: (no_nota_penjualan, kode_barang)
                       -> qty_detail_penjualan, 
harga_satuan_detail_penjualan (AB-04)
FD6: qty_detail_penjualan, harga_satuan_detail_penjualan
                       -> subtotal_detail_penjualan 

# D.3 Menuju 2NF dan 3NF
## Bentuk 2NF
PENJUALAN no_nota_penjualan (PK), tgl_penjualan, kode_petugas (FK), no_anggota (FK), bayar_penjualan
DETAIL_PENJUALAN no_nota_penjualan (PK, FK), kode_barang (PK, FK), qty_detail_penjualan, harga_satuan_detail_penjualan
BARANG kode_barang (PK), nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang
PETUGAS kode_petugas (PK), nama_petugas, peran_petugas
ANGGOTA no_anggota (PK), nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota
## Bentuk 3NF
PENJUALAN (no_nota_penjualan (PK), tgl_penjualan, kode_petugas (FK), no_anggota (FK), bayar_penjualan)
DETAIL_PENJUALAN (no_nota_penjualan (PK, FK), kode_barang (PK, FK), qty_detail_penjualan, harga_satuan_detail_penjualan)
BARANG (kode_barang (PK), nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang)
PETUGAS (kode_petugas (PK), nama_petugas, peran_petugas)
ANGGOTA (no_anggota (PK), nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota)

# D.4 Mencocokkan dengan Skema Kanonik
## Membandingkan dengan Skema Kanonik
| No. | Nama Tabel | Kunci Primer (PK) | Kunci Unik | Kunci Tamu (FK) |
|---:|---|---|---|---|
| 1 | Petugas | `id_petugas` | `kode_petugas` | - |
| 2 | Anggota | `id_anggota` | `no_anggota`, `nim_anggota` | - |
| 3 | Barang | `id_barang` | `kode_barang` | - |
| 4 | Pemasok | `id_pemasok` | - | - |
| 5 | Penjualan | `id_penjualan` | `no_nota_penjualan` | `id_petugas`, `id_anggota` |
| 6 | Detail Penjualan | `id_penjualan`, `id_barang` | - | `id_penjualan`, `id_barang` |
| 7 | Pembelian | `id_pembelian` | - | `id_pemasok` |
| 8 | Detail Pembelian | `id_pembelian`, `id_barang` | - | `id_pembelian`, `id_barang` |
## Pemeriksaan BCNF
| Nama Tabel | Hasil Pemeriksaan |
|---|---|
| Petugas | Memenuhi BCNF karena `id_petugas` dan `kode_petugas` menjadi penentu yang merupakan kunci kandidat. |
| Anggota | Memenuhi BCNF karena `id_anggota`, `no_anggota`, dan `nim_anggota` menjadi kunci kandidat. |
| Barang | Memenuhi BCNF karena `id_barang` dan `kode_barang` menjadi kunci kandidat. |
| Pemasok | Memenuhi BCNF karena `id_pemasok` menjadi kunci kandidat. |
| Penjualan | Memenuhi BCNF karena `id_penjualan` dan `no_nota_penjualan` menjadi kunci kandidat. |
| Detail Penjualan | Memenuhi BCNF karena gabungan `id_penjualan` dan `id_barang` menjadi kunci kandidat. |
| Pembelian | Memenuhi BCNF karena `id_pembelian` menjadi kunci kandidat. |
| Detail Pembelian | Memenuhi BCNF karena gabungan `id_pembelian` dan `id_barang` menjadi kunci kandidat. |

