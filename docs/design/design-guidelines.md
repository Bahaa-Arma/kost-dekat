# KosDekat Guidelines — Accessibility & Do's/Don'ts

> See [design.md](design.md) for token values. See [design-components.md](design-components.md) for component specs.

Pedoman ini menjaga dua hal sekaligus: aplikasi nyaman dipakai mahasiswa, dan aplikasi lolos ketentuan UTS (terutama **P06**: warna dari `colorScheme`, maksimal 3 pengecualian `Colors.xxx`, tema terang dan gelap). Nilai yang ditandai **(inferred)** adalah usulan dan belum diambil dari shot Dribbble.

---

## Accessibility

### Contrast Requirements

| Requirement | Ratio |
|---|---|
| Teks normal (< 18sp, atau < 14sp tebal) | minimal 4.5:1 |
| Teks besar (≥ 18sp, atau ≥ 14sp tebal) | minimal 3:1 |
| Ikon bermakna dan border komponen | minimal 3:1 |
| Teks dekoratif / nonaktif | tidak diwajibkan |

**Pasangan token yang sudah dicek (seed `#1F6FEB`, dihitung dengan rumus WCAG 2.x):**

| Pasangan | Light | Dark | Status |
|---|---|---|---|
| onPrimary di atas primary | 6.49:1 | 7.69:1 | Lulus teks normal |
| onSurface di atas surface | 16.32:1 | 14.39:1 | Lulus |
| onSurfaceVariant di atas surface | 8.92:1 | 10.92:1 | Lulus |
| onSurfaceVariant di atas surfaceContainerLow (kartu) | 8.51:1 | — | Lulus |
| onPrimaryContainer di atas primaryContainer (badge Putra) | 7.28:1 | — | Lulus |
| onSecondaryContainer di atas secondaryContainer (badge Campur) | 7.18:1 | — | Lulus |
| onTertiaryContainer di atas tertiaryContainer (badge Putri) | 7.20:1 | — | Lulus |
| primary (harga) di atas surfaceContainerLow | 5.88:1 | 9.66:1 | Lulus |
| outline di atas surface (border) | 4.24:1 | 5.85:1 | Lulus 3:1 |
| error di atas surface | 6.13:1 | 10.93:1 | Lulus |
| Bintang `#FFC107` di atas surface terang | **1.55:1** | 11.38:1 | **Gagal di mode terang** → pakai `#B26A00` (4.24:1) |

Bila warna seed diganti, hitung ulang tabel ini, misalnya dengan WebAIM Contrast Checker.

| Component | 3:1 Against |
|---|---|
| Bintang rating terisi | Latar form / kartu |
| Bintang kosong (`onSurfaceVariant`) | Latar form / kartu |
| Border TextField | Latar halaman |
| Indikator segmen terpilih | Latar segmen tidak terpilih |
| Ikon hati di atas foto | Lingkaran latar `surface` 80% di belakang ikon |
| Indikator NavigationBar | Latar NavigationBar |

### Touch Targets

| Aturan | Nilai |
|---|---|
| Area sentuh minimum | 48 × 48dp (bawaan `IconButton`, `FilledButton`) |
| Bintang rating | Ikon 36dp di dalam `IconButton` 48dp, jarak antar-bintang ≥ 0dp karena area sentuh sudah 48dp |
| Ikon hati di kartu | `IconButton` 48dp, posisi kanan atas dengan inset 8dp |
| Jarak antar-target | Minimal 8dp bila area sentuh < 48dp |
| Kepadatan | Jangan memakai `VisualDensity.compact` pada tombol utama |

### Keyboard Navigation

Jarang dipakai di ponsel, tetapi didukung bawaan Flutter (keyboard Bluetooth, emulator).

| Key | Action |
|---|---|
| Tab / Shift+Tab | Pindah fokus ke elemen berikut / sebelumnya |
| Enter / Space | Aktifkan tombol, segmen, chip, bintang |
| Panah kiri/kanan | Pindah antar-segmen di SegmentedButton |
| Esc / Back | Tutup form ulasan tanpa mengirim |

### Assistive Technology (TalkBack)

- Setiap `IconButton` wajib punya `tooltip`, karena tooltip dibacakan TalkBack. Contoh: "Tambah ke favorit", "Hapus dari favorit", "Beri 4 bintang".
- Kartu kos dibacakan sebagai satu kesatuan dengan `Semantics(label: ...)`. Contoh: "Kos Melati Indah, Putri, Sukapura, 0,8 kilometer, Rp1.250.000 per bulan".
- Gambar dekoratif memakai `excludeFromSemantics: true`; gambar kos memakai `semanticLabel` berisi nama kos.
- Rating dibacakan sebagai angka ("Rating 4 dari 5"), bukan jumlah ikon.
- Perubahan keadaan (gagal memuat, ulasan tersimpan) diumumkan lewat SnackBar, yang otomatis dibacakan.
- **Jangan menyampaikan makna hanya lewat warna.** Badge tipe selalu bertuliskan "Putra/Putri/Campur", dan rating selalu disertai angka.

---

## Gestures

| Gesture | Use |
|---|---|
| Tap | Buka detail dari kartu; pilih segmen/chip; ketuk bintang; tandai favorit |
| Double tap | Tidak dipakai (hindari favorit dengan ketuk dua kali karena tidak terlihat) |
| Long press | Tidak dipakai di versi UTS (inferred) |
| Scroll vertikal | Daftar kos, detail, daftar ulasan |
| Scroll horizontal | Baris ringkasan area di tab Cari |
| Swipe / tarik ke bawah | Pull-to-refresh di tab Cari (nilai tambah) |
| Drag | Tidak dipakai |
| Pinch | Tidak dipakai (gambar tidak bisa di-zoom di versi UTS) |
| Back (sistem) | Kembali dari Detail atau Form; form tertutup tanpa mengirim data |

---

## Content Design

| Aturan | Contoh benar | Contoh salah |
|---|---|---|
| Bahasa Indonesia baku yang ramah, sapaan "kamu" (inferred) | "Belum ada kos favorit. Ketuk ikon hati di tab Cari." | "Data kosong." |
| Huruf kapital di awal kalimat saja (sentence case) | "Tulis ulasan" | "Tulis Ulasan Kos Ini" |
| Label tombol 1 sampai 3 kata, kata kerja di depan | "Coba lagi", "Kirim ulasan" | "Klik di sini untuk mencoba" |
| Format harga konsisten | "Rp1.250.000/bln" | "Rp 1,250,000 per bulan", "1.25jt" |
| Format jarak | "0,8 km" (koma desimal) | "0.8km" |
| Tanggal relatif untuk kesegaran data | "Diperbarui 3 hari lalu" | "2026-11-06T09:00:00" |
| Pesan gagal: apa yang terjadi + apa yang bisa dilakukan | "Tidak dapat terhubung ke server. Pastikan server menyala, lalu coba lagi." | "Error: SocketException" |
| Panjang baris teks | Maksimal sekitar 60 karakter per baris di layar ponsel | Paragraf penuh selebar layar tanpa jeda |
| Tanpa tanda seru beruntun dan tanpa emoji di UI | "Ulasan tersimpan" | "Ulasan tersimpan!!! 🎉" |
| Data contoh ditandai | "Kos Melati Indah (contoh)" | Nama kos nyata dengan harga karangan |

---

## Do's and Don'ts

### Color

- **Do** ambil semua warna widget dari `Theme.of(context).colorScheme`.
- **Do** simpan satu-satunya hex (seed) di file tema, dan warna bintang di `ThemeExtension`.
- **Do** bedakan tipe kos dengan container yang berbeda (Putra = primaryContainer, Putri = tertiaryContainer, Campur = secondaryContainer) **dan** labelnya.
- **Don't** menulis `Colors.blue`, `Colors.white`, `Colors.grey` di widget. Pengecualian maksimal 3, dan semuanya harus tercatat di README.
- **Don't** memakai `withOpacity` (usang di Flutter baru). Pakai `withValues(alpha: ...)` bila tersedia.
- **Don't** mengandalkan warna saja untuk menyampaikan status.

### Shape

- **Do** pakai radius 16dp untuk kartu kos dan 12dp untuk TextField serta kartu area (inferred).
- **Do** samakan radius gambar dengan sudut atas kartu agar gambar tidak "menonjol".
- **Don't** mencampur tombol kotak dan tombol stadium dalam satu layar.

### Elevation

- **Do** bedakan lapisan dengan `surfaceContainer*`, bukan bayangan tebal.
- **Do** beri latar bulat `surface` di belakang ikon hati yang berada di atas foto.
- **Don't** memberi bayangan di setiap kartu sehingga daftar terlihat ramai.

### Interaction

- **Do** beri umpan balik untuk setiap aksi penting: SnackBar untuk favorit, ulasan tersimpan, dan validasi gagal.
- **Do** biarkan tombol "Kirim ulasan" tetap aktif, lalu jelaskan lewat SnackBar bila isian belum lengkap.
- **Don't** memanggil server ulang saat pengguna hanya mengganti filter atau urutan.
- **Don't** memakai `context` setelah `await` tanpa memeriksa `mounted`.

### Layout

- **Do** pakai margin 16dp dan jarak antar-kartu 16dp secara konsisten.
- **Do** letakkan filter tipe dan urutan tepat di atas daftar, dalam jangkauan ibu jari.
- **Don't** menaruh lebih dari dua baris kontrol filter di atas daftar.

### Typography

- **Do** pakai satu keluarga font (Plus Jakarta Sans) dengan variasi berat, bukan banyak font.
- **Do** tonjolkan harga dengan Title Medium 700 berwarna primary.
- **Don't** memakai ukuran teks di bawah 11sp.
- **Don't** memakai `google_fonts` bila membuat widget test gagal; pakai file font di assets.

### Motion

- **Do** pakai Hero untuk gambar dari kartu ke Detail, dengan tag berbeda per tab.
- **Do** jaga durasi animasi 100 sampai 400ms.
- **Don't** menganimasikan daftar setiap kali data dimuat ulang.

### Components

- **Do** pakai jenis tombol yang disebut ketentuan: FilledButton, OutlinedButton, IconButton, FloatingActionButton.
- **Do** pakai `SegmentedButton` untuk tipe kos (fitur khas) dan `ChoiceChip` untuk urutan.
- **Don't** memakai `ElevatedButton` untuk "Coba lagi" agar tidak menimbulkan keraguan penilai.
- **Don't** menyalin nama kelas, teks, atau tata letak dari hands-on Temuin.

---

## Checklist sebelum merge (UI)

| Cek | Cara |
|---|---|
| Tidak ada `Colors.` baru di widget | `grep -rn "Colors\." app/lib/` |
| Tampilan benar di mode gelap | Ubah tema emulator ke gelap |
| Semua IconButton punya tooltip | `grep -rn "IconButton(" app/lib/`, cek tiap hasil |
| Teks panjang tidak overflow | Isi nama kos 60 karakter di data uji |
| Area sentuh minimal 48dp | Flutter DevTools, Inspector |
| Analyze bersih | `flutter analyze` |
