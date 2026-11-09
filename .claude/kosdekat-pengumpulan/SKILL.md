---
name: kosdekat-pengumpulan
description: Checklist akhir dan langkah pengumpulan UTS KosDekat ke LMS (uji dari clone baru, APK debug, zip bersih, video demo 3–5 menit, commit tiap anggota). Pakai saat menyiapkan rilis atau menjelang batas Kamis 12 November 2026 pukul 23.59 WIB.
---

# Pengumpulan UTS KosDekat

Batas: **Kamis, 12 November 2026 pukul 23.59 WIB** (target internal pukul 20.00). Satu anggota mengunggah ke LMS (Tugas UTS, section Pertemuan 8) atas nama kelompok.

## 1. Gerbang mutu (pengurangan nilai)

| Cek | Perintah | Lulus bila | Risiko bila gagal |
|---|---|---|---|
| Analyze | `cd app && flutter analyze` | `No issues found!` | −10 (error) |
| Test | `flutter test` | `All tests passed!` | Poin P05 |
| Jalan dari README | Clone ke folder baru, ikuti README kata demi kata | Data tampil di emulator | −20 |
| Orisinalitas | `grep -rni temuin app/lib server/` | Kosong | Nilai 0 komponen terkait |

## 2. Berkas yang diunggah

1. **Tautan repo** GitHub. Repo publik, atau undang akun dosen. Cek dari jendela incognito.
2. **Zip repo** tanpa `build/`, `.dart_tool/`, `android/.gradle/`:
   ```bash
   bash scripts/zip_pengumpulan.sh   # menolak bila ada perubahan belum di-commit
   ```
3. **APK debug**:
   ```bash
   cd app && flutter build apk --debug
   # app/build/app/outputs/flutter-apk/app-debug.apk → ganti nama KosDekat_Kelompok06_debug.apk
   ```
4. **Video demo 3–5 menit** (YouTube unlisted atau Google Drive "siapa saja yang punya link").

## 3. Skrip video (7 adegan wajib PDF ditandai ★)

| No | Adegan |
|---|---|
| 1 | Pembukaan: Kelompok 06, KosDekat |
| 2 ★ | Server dinyalakan: `dart run bin/server.dart` |
| 3 ★ | Aplikasi memuat data |
| 4 | Fitur khas: SegmentedButton, urutan harga/jarak, harga Rupiah, ringkasan area |
| 5 ★ | Matikan server → keadaan gagal → nyalakan → **Coba lagi** → berhasil |
| 6 ★ | Halaman detail |
| 7 ★ | Form ulasan sampai data muncul di daftar (Detail dan Profil) |
| 8 ★ | Semua tab: Cari, Favorit, Profil (+ mode gelap) |
| 9 | Nilai tambah bila ada: pull-to-refresh, Hero, POST di log server |
| 10 ★ | Hasil `flutter test` |

Rekam emulator dan terminal berdampingan.

## 4. Checklist akhir

- Nama paket `id.ac.telkomuniversity.kosdekat`, label launcher "KosDekat"
- ≥ 4 screenshot di `screenshots/` dan tampil di README
- README: anggota (nama, NIM, tugas), cara menjalankan, tabel 28 poin dengan File:baris terisi, tautan video
- Setiap anggota punya commit (GitHub → Insights → Contributors)
- Workflow GitHub Actions hijau di `main`
- Semua tiket Jira wajib berstatus Done

Laporkan hasil sebagai daftar: butir, status, dan tindakan yang masih perlu dilakukan.
