---
name: kosdekat-tiket-jira
description: Menulis atau memperbarui tiket Jira project SCRUM untuk KosDekat dengan format deskripsi standar (tujuan, poin UTS, file, spesifikasi, kriteria selesai, baris README, ketergantungan) beserta label PIC dan area. Pakai saat membuat, memecah, atau merapikan tiket.
---

# Tiket Jira KosDekat

Project Jira: key **SCRUM**. Hierarki: Epic (SCRUM-1 s.d. 9) → Task. Satu task = satu hasil yang bisa diuji, idealnya selesai dalam ≤ 1 hari.

## Label wajib

| Jenis | Nilai |
|---|---|
| Semua tiket | `UTS` |
| PIC | `A1` Server & Rilis · `A2` Model, Service & QA · `A3` Tab Cari & Fitur Khas · `A4` Navigasi & Halaman · `A5` Setup, Tema & Dokumentasi · `Ketua` |
| Area | `BE` · `FE` · `QA` · `DOCS` · `SETUP` (boleh lebih dari satu) |

Label adalah daftar penuh: saat mengubah, kirim semua label, bukan hanya yang baru.

## Template deskripsi (markdown)

```markdown
## Tujuan
<satu kalimat hasil> **Poin: <P0x / Fitur Khas / Nilai Tambah>** (<kutip bunyi poin dari PDF UTS>).

## File
`app/lib/...` (sesuai docs/struktur-kode.md)

## Spesifikasi
- <kelas, method, field, format data, aturan>
- <potongan pola kode bila rawan salah>

## Kriteria selesai
- <hal yang bisa dicek, mis. output perintah atau perilaku di layar>
- `flutter analyze` bersih

## Baris README
`<Poin> | <File>:<baris> | <Keterangan>`

## Bergantung pada
SCRUM-xx
```

## Aturan menulis

- Kutip ketentuan dari PDF UTS apa adanya; tandai saran tambahan sebagai rekomendasi, bukan kewajiban.
- Jangan menaruh tabel di dalam daftar bernomor (tampilannya rusak di Jira). Taruh tabel di bagian sendiri.
- Hindari kotak centang `- [ ]` di deskripsi; pakai bullet biasa.
- Sebut tiket lain dengan key lengkap (`SCRUM-27`) agar tertaut otomatis.
- Tugas nilai tambah (POST, pull-to-refresh, Hero) selalu diberi catatan: dikerjakan setelah semua fitur wajib stabil di `main`.

## Konvensi Git yang dirujuk tiket

- Branch: `feat/SCRUM-<nomor>-<ringkas>`, `fix/...`, `docs/...`.
- Commit: `SCRUM-<nomor> <kalimat perintah>`.
- Setelah merge: pindahkan ke Done dan tempel File:baris di komentar tiket.
