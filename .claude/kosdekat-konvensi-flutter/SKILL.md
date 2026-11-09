---
name: kosdekat-konvensi-flutter
description: Aturan menulis atau mereview kode Flutter dan server Dart KosDekat (penamaan, struktur folder, warna dari colorScheme, mounted, dispose, MockClient, data JSON). Pakai setiap kali membuat, mengubah, atau mereview file di app/ atau server/.
---

# Konvensi Kode KosDekat

Ikuti aturan ini agar kode lolos `flutter analyze`, mudah dinilai sesuai ketentuan UTS, dan konsisten antaranggota. Peta file lengkap ada di `docs/struktur-kode.md`. Token desain ada di `docs/design/design.md`.

## Struktur dan penamaan

| Jenis | Aturan | Contoh |
|---|---|---|
| File Dart | `snake_case`, bahasa Indonesia | `halaman_detail_kos.dart` |
| Kelas | `PascalCase`, khas KosDekat | `HalamanDetailKos`, `KartuKos`, `KosService` |
| Method/variabel | `camelCase` | `ambilDaftarKos()`, `_idFavorit` |
| Folder `lib/` | `model/`, `service/`, `halaman/`, `widget/`, `tema/`, `util/` | — |

Jangan memakai nama, teks, data, atau endpoint dari hands-on Temuin. Itu dihitung tidak mengerjakan.

## Aturan wajib

1. **Warna** hanya dari `Theme.of(context).colorScheme`. `Colors.xxx` maksimal 3 di seluruh `lib/` dan dicatat di README. Warna bintang rating diambil dari `ThemeExtension WarnaKosDekat`.
2. **Async**: setelah setiap `await` yang diikuti pemakaian `context`, tulis `if (!mounted) return;` (di State) atau `if (!context.mounted) return;`.
3. **Controller**: setiap `TextEditingController` di-dispose di `dispose()` sebelum `super.dispose()`.
4. **FutureBuilder**: Future dibuat di `initState` atau saat muat ulang lewat `setState`, **tidak pernah di `build()`**. Tangani tiga keadaan: memuat, gagal (tombol **"Coba lagi"** memakai FilledButton/OutlinedButton), berhasil.
5. **HTTP**: semua panggilan lewat `KosService`. `http.Client` disuntikkan lewat konstruktor. Alamat dari `const String.fromEnvironment('API_URL', defaultValue: 'http://10.0.2.2:8080')`. Tambahkan `.timeout(const Duration(seconds: 8))`.
6. **State bersama** (Future kos, id favorit, daftar ulasan) dimiliki `HalamanUtama`, dioper ke tab lewat konstruktor dan callback. Tab dibungkus `IndexedStack`.
7. **Navigasi**: Detail menerima objek `Kos` utuh lewat konstruktor. Form ulasan mengembalikan data dengan `Navigator.pop(context, ulasan)` dan diterima dengan `await Navigator.push<Ulasan>(...)`.
8. **Harga** selalu lewat `formatRupiah(int)` yang menghasilkan persis `Rp1.250.000/bln`. Jangan memakai `intl` untuk ini.
9. **Hero** (bila dikerjakan): tag berbeda per tab, `cari-<id>` dan `favorit-<id>`.
10. **API usang**: jangan memakai `withOpacity`; pakai `withValues(alpha: ...)` bila versi Flutter mendukung. Cek dengan `flutter analyze`.
11. **Aksesibilitas**: setiap `IconButton` punya `tooltip`; area sentuh minimal 48dp.

## Model dan JSON

- `Kos`: `id` (String), `nama`, `area`, `tipe` (Putra/Putri/Campur), `hargaBulanan` (int), `kamarMandiDalam` (bool), `jarakKm` (double), `diperbarui` (DateTime).
- `fromJson`: `DateTime.parse(...)`, `(json['jarakKm'] as num).toDouble()`. `toJson`: `toIso8601String()`.
- Nama field di `server/data/kos.json` harus sama persis dengan model.

## Server

- `shelf` + `shelf_router`; serve di `InternetAddress.anyIPv4` port 8080; `logRequests()` di Pipeline.
- Respons selalu `Content-Type: application/json`. `GET /kos/<id>` yang tidak ada → 404 `{"pesan": "Kos tidak ditemukan"}`.
- `GET /area` → `[{area, jumlahKos, hargaRataRata}]`, rata-rata dibulatkan `.round()`, urut nama area.

## Test

- Minimal 3 `testWidgets` (terpisah dari test MockClient). Test tidak boleh memanggil server sungguhan; suntikkan `KosService(client: MockClient(...))`.
- Hapus test counter bawaan `flutter create`.

## Sebelum menyerahkan kode

```bash
dart format lib test && flutter analyze && flutter test
grep -rn "Colors\." lib/
```
Sertakan satu baris tabel README: `Poin | File:baris | Keterangan`.
