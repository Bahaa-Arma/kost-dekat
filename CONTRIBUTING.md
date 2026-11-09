# Aturan Kerja Tim KosDekat

Kembali ke [README utama](README.md). Peta file dan konvensi penamaan ada di [docs/struktur-kode.md](docs/struktur-kode.md).

## 1. Alur satu tiket

```
Jira: To Do → In Progress → Review → Done
Git : main → feat/SCRUM-xx → Pull Request → review → merge ke main
```

1. Pindahkan tiket ke **In Progress** dan assign ke diri sendiri.
2. Perbarui `main`, lalu buat branch:
   ```bash
   git checkout main && git pull
   git checkout -b feat/SCRUM-15-endpoint-area
   ```
3. Kerjakan, commit kecil-kecil (lihat aturan commit).
4. Jalankan pemeriksaan (bagian 4), lalu push dan buka Pull Request.
5. Pindahkan tiket ke **Review**. Setelah merge, pindahkan ke **Done** dan tempel baris File:baris di komentar tiket.

## 2. Branch

| Jenis | Format | Contoh |
|---|---|---|
| Fitur baru | `feat/SCRUM-<nomor>-<ringkas>` | `feat/SCRUM-23-segmented-tipe` |
| Perbaikan | `fix/SCRUM-<nomor>-<ringkas>` | `fix/SCRUM-38-analyze-warning` |
| Dokumentasi | `docs/SCRUM-<nomor>-<ringkas>` | `docs/SCRUM-43-readme` |

- `main` selalu bisa dijalankan dan lolos `flutter analyze`. **Jangan push langsung ke `main`.**
- Satu branch untuk satu tiket. Hapus branch setelah merge.

## 3. Commit

- Selalu diawali key Jira: `SCRUM-15 tambah endpoint GET /area`.
- Kalimat perintah, bahasa Indonesia, tanpa titik di akhir.
- Satu commit = satu perubahan yang masuk akal. Hindari "update", "fix", atau "wip" tanpa keterangan.
- Commit dari akun GitHub masing-masing. **Riwayat commit adalah bukti kontribusi** (PDF UTS Bagian 8).

## 4. Pemeriksaan sebelum Pull Request

Aplikasi:
```bash
cd app
dart format lib test
flutter analyze      # wajib: No issues found!
flutter test         # wajib: All tests passed!
```

Server:
```bash
cd server
dart analyze
dart run bin/server.dart   # lalu uji dengan curl
```

Tampilan (bila mengubah UI):
```bash
grep -rn "Colors\." app/lib/    # tidak boleh ada Colors.xxx baru
```

## 5. Pull Request

- Judul: `SCRUM-<nomor> <ringkasan>`.
- Isi semua bagian template PR, termasuk **baris tabel README** (Poin | File:baris | Keterangan).
- Minimal satu anggota lain me-review. Reviewer menjalankan kode, bukan hanya membaca.
- Workflow **Cek KosDekat** di GitHub Actions harus hijau sebelum merge.

## 6. Aturan kode

- Nama kelas, halaman, data, dan endpoint khas KosDekat. **Jangan menyalin nama atau teks dari hands-on Temuin.**
- Warna widget dari `Theme.of(context).colorScheme`. `Colors.xxx` hanya untuk pengecualian yang tercatat di README (maksimal 3).
- Hindari API yang sudah deprecated (mis. `withOpacity`) agar `flutter analyze` tetap bersih.
- Setelah `await`, cek `if (!mounted) return;` (atau `context.mounted`) sebelum memakai `context`.
- Setiap `TextEditingController` di-dispose di `dispose()`.
- Future untuk FutureBuilder disimpan di State (`initState`), bukan dibuat di `build()`.
- `http.Client` disuntikkan lewat konstruktor agar bisa dites dengan MockClient.
- Setiap `IconButton` punya `tooltip`.

## 7. Konflik merge

1. `git checkout main && git pull`
2. `git checkout feat/SCRUM-xx && git merge main`
3. Selesaikan konflik, jalankan lagi `flutter analyze` dan `flutter test`, lalu commit.

Konflik paling sering terjadi di `pubspec.yaml` dan `halaman_utama.dart`. Koordinasikan di grup sebelum mengubah kedua file ini.
