---
name: kosdekat-audit-uts
description: Audit repo KosDekat terhadap 28 poin fitur wajib UTS PAB (P01–P07), fitur khas Proyek 5, dan tabel README. Pakai saat diminta mengecek kesiapan UTS, mengisi File:baris README, atau sebelum merge/pengumpulan.
---

# Audit Kepatuhan UTS KosDekat

Tujuan: memastikan setiap poin Bagian 3 dan Bagian 5 dokumen UTS P08 benar-benar ada di kode `main`, lalu menuliskan File:baris yang tepat di README. Sumber ketentuan satu-satunya adalah PDF UTS. Jangan menambah syarat yang tidak ada di PDF.

## Langkah

1. **Perbarui kode**: `git checkout main && git pull`.
2. **Jalankan pemeriksaan otomatis** dan simpan hasilnya:
   ```bash
   cd app && flutter pub get && flutter analyze && flutter test
   cd ../server && dart pub get && dart analyze
   ```
   `flutter analyze` wajib `No issues found!` (error = −10; warning menggugurkan P01–P02).
3. **Cari bukti setiap poin** dengan grep (jalankan dari `app/`):

| Poin | Perintah bukti | Lulus bila |
|---|---|---|
| P01 nama paket | `grep -rn applicationId android/app/build.gradle*` | `id.ac.telkomuniversity.kosdekat` |
| P01 label | `grep -n android:label android/app/src/main/AndroidManifest.xml` | `KosDekat` |
| P02 screenshot | `ls ../screenshots/*.png \| wc -l` | ≥ 4 |
| P03 Stateless/Stateful | `grep -rn "extends Stateless\|extends Stateful" lib/` | keduanya ada, `setState` mengubah tampilan |
| P03 TextField + dispose | `grep -rn "TextEditingController\|\.dispose()" lib/` | setiap controller di-dispose |
| P03 tombol M3 | `grep -rn "FilledButton\|OutlinedButton\|IconButton\|FloatingActionButton" lib/` | ≥ 2 jenis |
| P03 pilihan | `grep -rn "SegmentedButton\|ChoiceChip\|FilterChip" lib/` | ada |
| P03 SnackBar | `grep -rn "showSnackBar" lib/` | ada |
| P04 model | buka `lib/model/kos.dart` | ≥ 6 field, ada DateTime dan bool |
| P04 kartu | buka `lib/widget/kartu_kos.dart` | memakai Row, Column, Expanded, Stack |
| P04 list | `grep -rn "ListView.builder\|GridView.builder" lib/` | ada |
| P04 navigasi | `grep -rn "NavigationBar\|IndexedStack" lib/` | ≥ 3 destinasi + IndexedStack |
| P05 detail | `grep -rn "Navigator.push" lib/` | objek `Kos` dikirim lewat konstruktor |
| P05 form | `grep -rn "Navigator.pop(context," lib/` + `await Navigator.push` | data muncul di daftar |
| P05 mounted | `grep -rn "mounted" lib/` | dicek setelah setiap `await` yang memakai context |
| P05 test | `grep -rn "testWidgets" test/ \| wc -l` | ≥ 3, terpisah dari test MockClient |
| P06 tema | `grep -rn "fromSeed\|darkTheme" lib/` | keduanya ada |
| P06 warna | `grep -rn "Colors\." lib/` | ≤ 3 baris, semuanya tercatat di README |
| P06 font | `grep -n "fonts:\|google_fonts" pubspec.yaml` | ada |
| P06 ikon | `grep -n "flutter_launcher_icons" pubspec.yaml` | ada |
| P06 aset | `grep -n "assets:" pubspec.yaml` | ≥ 1 gambar |
| P07 server | `ls ../server/bin/server.dart ../server/data/kos.json` | ada, `shelf_router` dipakai |
| P07 data | `python3 -c "import json;print(len(json.load(open('../server/data/kos.json'))))"` | ≥ 12 |
| P07 endpoint | `grep -n "router\.\(get\|post\)" ../server/bin/server.dart` | `/kos`, `/kos/<id>`, `/area` |
| P07 http + define | `grep -rn "package:http\|fromEnvironment('API_URL'" lib/` | keduanya ada |
| P07 JSON | `grep -rn "fromJson\|toJson\|DateTime.parse\|toIso8601String" lib/model/` | ada |
| P07 FutureBuilder | `grep -rn "FutureBuilder\|Coba lagi" lib/` | 3 keadaan + tombol Coba lagi |
| P07 MockClient | `grep -rn "MockClient" test/` | ada |

4. **Fitur khas Proyek 5**: SegmentedButton Putra/Putri/Campur, urutan harga atau jarak, format persis `Rp1.250.000/bln`, endpoint `GET /area`, tab Cari · Favorit · Profil, form ulasan (nama kos, rating 1–5 bintang diketuk, komentar).
5. **Larangan**: pastikan tidak ada nama kelas, teks, data, atau endpoint dari hands-on Temuin (`grep -rni temuin lib/ ../server/`).
6. **Perbarui README**: ganti setiap `_:_` di tabel bagian 10 dengan nomor baris asli (`grep -n`). Nomor baris dicek ulang setelah merge terakhir.

## Format laporan

Tulis hasil sebagai tabel: `Poin | Status (OK / KURANG / GAGAL) | File:baris | Catatan`. Urutkan yang GAGAL lebih dulu. Untuk setiap yang tidak OK, sebutkan tiket SCRUM terkait (lihat `docs/struktur-kode.md`) dan perbaikan paling kecil yang diperlukan. Jangan menyatakan lulus tanpa bukti grep atau hasil perintah.
