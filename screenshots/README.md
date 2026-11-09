# Tangkapan Layar

Minimal **4** tangkapan layar dari emulator atau HP Android (ketentuan P01–P02). Nama file harus persis seperti tabel karena dirujuk README utama.

| File | Isi |
|---|---|
| `01_cari.png` | Tab Cari: ringkasan area, SegmentedButton, urutan, kartu dengan harga Rupiah |
| `02_detail.png` | Halaman detail kos + daftar ulasan |
| `03_form_ulasan.png` | Form ulasan dengan bintang terisi |
| `04_favorit.png` | Tab Favorit berisi kos |
| `05_profil.png` | Tab Profil dengan "Ulasan saya" |
| `06_gagal.png` | Keadaan gagal + tombol Coba lagi (server dimatikan) |
| `07_gelap.png` | Tampilan mode gelap |

Cara mengambil dari emulator:

```bash
adb exec-out screencap -p > screenshots/01_cari.png
```

Ambil dari build terakhir (setelah tema, font, dan ikon final). Kecilkan ukuran bila lebih dari 500 KB.
