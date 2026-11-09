# KosDekat — Info Kos Sekitar Telkom University

Aplikasi Flutter untuk membantu mahasiswa menemukan kos di sekitar Telkom University: Sukapura, Sukabirus, Bojongsoang, Cikoneng, Dayeuhkolot, dan area sekitar.

## Identitas kelompok
- Nama kelompok: **[Isi nama kelompok]**
- Tema: **KosDekat — pencarian kos sekitar Telkom University**
- Anggota:
  | Nama | NIM | Tugas |
  |---|---|---|
  | [Nama anggota 1] | [NIM] | [Tugas] |
  | [Nama anggota 2] | [NIM] | [Tugas] |
  | [Nama anggota 3] | [NIM] | [Tugas] |

## Struktur repository
```text
KosDekat/
├── app/
│   ├── lib/
│   ├── test/
│   ├── assets/
│   └── pubspec.yaml
├── server/
│   ├── bin/server.dart
│   ├── data/kos.json
│   └── pubspec.yaml
├── screenshots/
└── README.md
```

## Persiapan
- Flutter SDK dan Android Studio / Android SDK.
- Dart SDK (mengikuti versi Flutter).
- Perangkat Android atau emulator.
- Aktifkan USB debugging jika menggunakan HP fisik.

## Cara menjalankan server API
Buka terminal pertama dari folder repository:

```bash
cd server
dart pub get
dart run bin/server.dart
```

Server berjalan pada port `8080`. Endpoint:
| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/kos` | Mengambil seluruh daftar kos (12 data awal) |
| GET | `/kos/<id>` | Mengambil detail kos berdasarkan ID |
| GET | `/area` | Daftar area dan harga rata-rata kos |
| GET | `/health` | Pemeriksaan status server |

Contoh akses endpoint:
- `http://localhost:8080/kos`
- `http://localhost:8080/kos/k01`
- `http://localhost:8080/area`

## Cara menjalankan aplikasi Flutter
Buka terminal kedua:

```bash
cd app
flutter create --platforms=android --org id.ac.telkomuniversity .
flutter pub get
dart run flutter_launcher_icons
flutter run --dart-define=API_URL=http://10.0.2.2:8080
```

`10.0.2.2` adalah alamat khusus emulator Android untuk mengakses `localhost` komputer. Jika memakai HP fisik, ganti alamat tersebut dengan IP lokal komputer yang menjalankan server, misalnya:

```bash
flutter run --dart-define=API_URL=http://192.168.1.10:8080
```

Pastikan HP dan komputer berada pada jaringan Wi-Fi yang sama. Setelah `flutter create`, pastikan file `android/app/src/main/AndroidManifest.xml` memuat permission berikut tepat di bawah tag `<manifest>`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Pengujian dan analisis
Jalankan dari folder `app`:

```bash
flutter analyze
flutter test
```

Target pemeriksaan: tidak ada error/warning dari `flutter analyze` dan seluruh test lulus. Jalankan juga pada emulator atau perangkat Android.

## Tangkapan layar perangkat
Simpan minimal empat screenshot asli dari emulator/HP ke folder `screenshots/` dengan nama berikut (atau sesuaikan tautan di bawah):
1. `screenshots/01-cari.png` — halaman Cari, daftar kos dan filter.
2. `screenshots/02-detail.png` — halaman detail salah satu kos.
3. `screenshots/03-favorit.png` — halaman Favorit.
4. `screenshots/04-ulasan.png` — form tambah ulasan dengan rating bintang.

Screenshot harus diambil dari aplikasi yang berjalan pada perangkat, bukan mockup desain. Folder ini disiapkan untuk menampung hasil tangkapan layar.

## Tabel pemenuhan fitur

| Poin | File:baris (cek nomor baris aktual dengan editor) | Keterangan |
|---|---|---|
| P01 | `app/pubspec.yaml`; `app/android/app/src/main/AndroidManifest.xml` (dibuat oleh `flutter create`) | Identitas aplikasi KosDekat; package org `id.ac.telkomuniversity`; label launcher KosDekat. Jalankan pada emulator/HP dan lampirkan screenshot. |
| P02 | `app/assets/kosdekat_logo.png`; `README.md` | Ikon aplikasi disiapkan melalui `flutter_launcher_icons`; screenshot perangkat disimpan di `screenshots/`. |
| P03 | `app/lib/screens/home_page.dart`; `app/lib/screens/add_review_page.dart` | StatefulWidget, TextField + controller, SegmentedButton, FilledButton, IconButton, SnackBar, rating bintang interaktif; StatelessWidget ada pada kartu/detail/profil. |
| P04 | `app/lib/models/kos.dart`; `app/lib/widgets/kos_card.dart`; `app/lib/screens/home_page.dart` | Model memiliki 8 field termasuk bool dan DateTime; kartu memakai Row, Column, Expanded; daftar ListView.builder; NavigationBar 3 tab dan IndexedStack. |
| P05 | `app/lib/screens/kos_detail_page.dart`; `app/lib/screens/add_review_page.dart`; `app/lib/screens/home_page.dart`; `app/test/` | Detail menerima model lewat konstruktor; form mengembalikan Map lewat Navigator.pop; hasil diterima setelah await dan dicek mounted; minimal 3 widget test dan 1 test MockClient tersedia. |
| P06 | `app/lib/tema/tema_kosdekat.dart:5`; `app/lib/main.dart:22` | P06 ColorScheme.fromSeed + darkTheme \| lib/tema/tema_kosdekat.dart:5 \| Seed #14695C (referensi Papa Kost). ThemeData dengan ColorScheme.fromSeed (terang & gelap), font Google Fonts Plus Jakarta Sans, cardTheme, filledButtonTheme, navigationBarTheme, switch mode gelap di profil. |
| P07 | `server/bin/server.dart`; `server/data/kos.json`; `app/lib/services/api_service.dart`; `app/lib/models/kos.dart`; `app/lib/screens/home_page.dart`; `app/test/api_service_test.dart` | Shelf API dengan GET `/kos`, `/kos/<id>`, `/area`; 12 data JSON; API_URL via dart-define; fromJson/toJson; FutureBuilder tiga keadaan dan tombol Coba lagi; MockClient test. |

## Catatan implementasi
- Form ulasan menyimpan ulasan ke state aplikasi (sementara/in-memory), belum ke server/database.
- Endpoint `/area` menghitung jumlah kos dan rata-rata harga bulanan per area dari file JSON.
- Data kos adalah data contoh untuk keperluan demonstrasi. Verifikasi alamat, harga, fasilitas, dan ketersediaan langsung kepada pemilik kos sebelum digunakan sebagai informasi aktual.
- Baris pada tabel pemenuhan fitur perlu diverifikasi kembali menggunakan editor setelah file dibuka, karena nomor baris dapat berubah jika kode diedit.
