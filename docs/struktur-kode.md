# Peta File ke Tiket Jira

Dokumen ini menjawab tiga pertanyaan: **file apa saja yang dibuat**, **siapa yang mengerjakannya**, dan **poin UTS mana yang dipenuhinya**. Gunakan nama file persis seperti di tabel agar tidak ada file ganda dan tabel README mudah diisi.

Kembali ke [README utama](../README.md).

---

## 1. Aplikasi Flutter (`app/`)

### 1.1 `lib/`

| File | Isi | Poin UTS | Tiket | PIC |
|---|---|---|---|---|
| `main.dart` | `KosDekatApp` (MaterialApp), `theme`, `darkTheme`, `home: HalamanUtama(...)` | P06 | SCRUM-27, SCRUM-33 | A4, A5 |
| `model/kos.dart` | Kelas `Kos` 8 field, `fromJson`, `toJson`, konversi DateTime | P04 model, P07 JSON | SCRUM-17 | A2 |
| `model/ulasan.dart` | Kelas `Ulasan` (kosId, namaKos, rating, komentar, tanggal) | Form tambah | SCRUM-18 | A2 |
| `model/ringkasan_area.dart` | Kelas `RingkasanArea` (area, jumlahKos, hargaRataRata) | Endpoint khas | SCRUM-19 | A2 |
| `service/kos_service.dart` | `KosService` dengan `http.Client` disuntikkan; `ambilDaftarKos`, `ambilKos`, `ambilRingkasanArea`, (`kirimUlasan`) | P07 http + dart-define | SCRUM-19, SCRUM-42 | A2, A1 |
| `halaman/halaman_utama.dart` | StatefulWidget pemilik state: tab, Future kos, id favorit, daftar ulasan; NavigationBar + IndexedStack | P03 Stateful, P04 navigasi | SCRUM-27 | A4 |
| `halaman/tab_cari.dart` | Header, ringkasan area, SegmentedButton tipe, ChoiceChip urutan, FutureBuilder, ListView.builder, RefreshIndicator | P07 FutureBuilder, P04 list, fitur khas 1–2 | SCRUM-22, 23, 24, 40 | A3 |
| `halaman/tab_favorit.dart` | Daftar kos favorit + empty state | Tab tema | SCRUM-31 | A4 |
| `halaman/tab_profil.dart` | Avatar, ringkasan, "Ulasan saya", switch mode gelap (opsional) | Tab tema, P05 data muncul | SCRUM-32 | A4 |
| `halaman/halaman_detail_kos.dart` | Detail via konstruktor, daftar ulasan, FAB "Tulis ulasan", `await` + `mounted` + SnackBar | P05 detail, form, mounted | SCRUM-28, SCRUM-30 | A4 |
| `halaman/halaman_form_ulasan.dart` | TextField nama kos & komentar, bintang 1–5, FilledButton, validasi, `Navigator.pop(context, ulasan)` | P03 TextField + dispose, form tambah | SCRUM-29 | A4 |
| `widget/kartu_kos.dart` | StatelessWidget `KartuKos`: Stack (gambar, badge, hati), Column, Row + Expanded, Hero | P04 kartu, P03 Stateless | SCRUM-21, SCRUM-41 | A3 |
| `widget/ringkasan_area.dart` | Baris kartu area horizontal dari `GET /area` | Endpoint khas dipakai | SCRUM-26 | A3 |
| `tema/tema_kosdekat.dart` | Seed, `ColorScheme.fromSeed` terang/gelap, `fontFamily`, `ThemeExtension` warna bintang | P06 tema, font | SCRUM-33, SCRUM-34 | A5 |
| `util/format_rupiah.dart` | `formatRupiah(int)` → `Rp1.250.000/bln` | Fitur khas 3 | SCRUM-25 | A3 |

Widget kecil lain (badge tipe, bintang, empty state) **boleh** dibuat di `widget/` bila dipakai lebih dari satu halaman. Catat di tabel ini bila menambah file.

### 1.2 `test/`

| File | Isi | Poin UTS | Tiket | PIC |
|---|---|---|---|---|
| `widget_test.dart` | Minimal 3 `testWidgets`: KartuKos, filter SegmentedButton, keadaan gagal, form ulasan | P05 test | SCRUM-37 | A2 |
| `kos_service_test.dart` | `MockClient`: respons berhasil dan gagal | P07 MockClient | SCRUM-20 | A2 |
| `format_rupiah_test.dart` | Unit test 5 kasus harga | Fitur khas 3 | SCRUM-25 | A3 |

> Hapus test counter bawaan `flutter create` saat `main.dart` sudah diganti, karena test itu pasti gagal.

### 1.3 `assets/`

| Folder | Isi | Didaftarkan di `pubspec.yaml` | Tiket | PIC |
|---|---|---|---|---|
| `assets/fonts/` | `.ttf` Regular, SemiBold, Bold + `OFL.txt` | `flutter: fonts:` | SCRUM-34 | A5 |
| `assets/icon/` | `ikon_kosdekat.png` 1024×1024 | `flutter_launcher_icons: image_path:` | SCRUM-35 | A1 |
| `assets/images/` | Ilustrasi kos, empty state, logo (< 300 KB per file) | `flutter: assets: - assets/images/` | SCRUM-35 | A1 |

### 1.4 File Android

| File | Perubahan | Tiket | PIC |
|---|---|---|---|
| `android/app/build.gradle(.kts)` | `applicationId` = `id.ac.telkomuniversity.kosdekat` (otomatis dari skrip) | SCRUM-10 | A5 |
| `android/app/src/main/AndroidManifest.xml` | Label "KosDekat", izin INTERNET, `usesCleartextTraffic` (otomatis dari skrip, wajib dicek) | SCRUM-11 | A5 |

---

## 2. Server (`server/`)

| File | Isi | Poin UTS | Tiket | PIC |
|---|---|---|---|---|
| `pubspec.yaml` | Dependency `shelf`, `shelf_router` | P07 | SCRUM-14 | A1 |
| `data/kos.json` | ≥ 12 kos fiktif, ≥ 3 area, 3 tipe | P07 data | SCRUM-13 | A1 |
| `bin/server.dart` | Router, `GET /kos`, `GET /kos/<id>`, `GET /area`, bind `anyIPv4:8080`, (`POST /ulasan`) | P07 endpoint | SCRUM-14, 15, 16, 42 | A1 |

---

## 3. Dokumentasi dan pengumpulan

| File / folder | Isi | Tiket | PIC |
|---|---|---|---|
| `README.md` | Anggota, cara menjalankan, screenshot, tabel pemenuhan fitur | SCRUM-43 | A5 |
| `screenshots/` | `01_cari.png` s.d. `07_gelap.png` | SCRUM-44 | A5 |
| `docs/design/` | Design system | — | A5 |
| `scripts/zip_pengumpulan.sh` | Zip untuk LMS | SCRUM-46 | Ketua |

---

## 4. Konvensi penamaan

| Jenis | Aturan | Contoh |
|---|---|---|
| Nama file Dart | `snake_case`, bahasa Indonesia | `halaman_detail_kos.dart` |
| Kelas | `PascalCase`, bahasa Indonesia, khas KosDekat | `HalamanDetailKos`, `KartuKos` |
| Variabel dan method | `camelCase` | `ambilDaftarKos()`, `_idFavorit` |
| Field privat State | Diawali `_` | `_rating`, `_komentarController` |
| Aset | `snake_case` | `ikon_kosdekat.png`, `kamar_contoh_1.png` |
| Screenshot | `NN_nama.png` | `03_form_ulasan.png` |

Jangan memakai nama kelas, halaman, data, atau endpoint dari hands-on Temuin.
