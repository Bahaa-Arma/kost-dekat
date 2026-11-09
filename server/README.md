# Server KosDekat

REST API kecil berbasis Dart `shelf` + `shelf_router` untuk aplikasi KosDekat. Kembali ke [README utama](../README.md).

## Struktur

```
server/
├─ bin/server.dart     # Titik masuk: baca data, definisikan router, nyalakan server
├─ data/kos.json       # Data awal ≥ 12 kos (fiktif)
└─ pubspec.yaml        # Dependency: shelf, shelf_router
```

## Menjalankan

```bash
cd server              # wajib: server membaca data/kos.json relatif dari folder ini
dart pub get
dart run bin/server.dart
```

Server mendengarkan di **semua alamat IPv4** (`InternetAddress.anyIPv4`) port **8080**, sehingga bisa dijangkau emulator (`10.0.2.2`) dan HP di Wi-Fi yang sama.

## Endpoint

| Metode & jalur | Respons | Tiket |
|---|---|---|
| `GET /kos` | 200, daftar semua kos | SCRUM-14 |
| `GET /kos/<id>` | 200 satu kos, atau 404 `{"pesan": "Kos tidak ditemukan"}` | SCRUM-14 |
| `GET /area` | 200, `[{area, jumlahKos, hargaRataRata}]` urut nama area | SCRUM-15 |
| `POST /ulasan` (opsional) | 201 ulasan tersimpan, atau 400 bila tidak valid | SCRUM-42 |

Semua respons memakai header `Content-Type: application/json`.

## Aturan data `kos.json`

| Aturan | Nilai |
|---|---|
| Jumlah item | Minimal 12 (disarankan 14–16) |
| Area | Minimal 3 (Sukapura, Sukabirus, Bojongsoang, ...), minimal 2 kos per area |
| Tipe | Ketiganya ada: Putra, Putri, Campur |
| `id` | String: `"1"`, `"2"`, ... |
| `diperbarui` | ISO 8601: `"2026-10-28T09:00:00.000"` |
| Nama kos | Fiktif, diberi akhiran "(contoh)" |

Nama field harus sama persis dengan `fromJson` di `app/lib/model/kos.dart`.

## Uji cepat

```bash
curl -i http://localhost:8080/kos
curl -i http://localhost:8080/kos/1
curl -i http://localhost:8080/kos/999   # harus 404
curl -i http://localhost:8080/area
```
