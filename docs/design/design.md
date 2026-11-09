# KosDekat Design System — Token Reference

> Always read this file first. For component specs see [design-components.md](design-components.md). For accessibility and do's/don'ts see [design-guidelines.md](design-guidelines.md).

KosDekat memakai Material 3 di Flutter: satu warna seed diturunkan menjadi `ColorScheme` terang dan gelap lewat `ColorScheme.fromSeed`. Font utama **Plus Jakarta Sans**, satuan spasi dasar **4dp**, platform **Android ponsel** (layout compact).

> **Status token: USULAN.** Shot Dribbble "Papa Kost – Mobile Rental Apartment" belum bisa dibuka dari sesi ini, jadi tidak ada nilai yang diambil dari shot tersebut. Semua nilai bertanda **(inferred)** adalah titik awal yang konsisten dengan Material 3. Setelah tim melihat shot, cukup ganti **warna seed**, **font**, dan **radius**. Seluruh token warna akan menyesuaikan sendiri.

---

## Ringkasan token yang perlu diisi tim

| Token | Nilai usulan | Ganti dengan (dari shot) |
|---|---|---|
| Warna seed | `#1F6FEB` (inferred) | `#______` |
| Font | Plus Jakarta Sans (inferred) | ______ |
| Radius kartu | 16dp (inferred) | ______ |
| Radius tombol | Full / stadium (inferred) | ______ |
| Gaya kartu daftar | Gambar atas 16:9, badge tipe kiri atas, hati kanan atas (inferred) | ______ |
| Gaya NavigationBar | M3 standar, indikator pil (inferred) | ______ |
| Header tab Cari | Sapaan + judul besar + ringkasan area horizontal (inferred) | ______ |

---

## Colors

Semua warna di bawah **dihitung** dari seed `#1F6FEB` dengan algoritma Material 3 *tonal spot* spesifikasi 2021 (memakai pustaka `materialyoucolor`), yaitu varian bawaan `ColorScheme.fromSeed`. Hasil di perangkat bisa berbeda tipis menurut versi Flutter, jadi jangan menyalin hex ini ke widget. Widget selalu membaca `Theme.of(context).colorScheme`.

> Varian *tonal spot* sengaja meredam saturasi, sehingga primary tampak lebih kalem (`#465D91`) daripada seed. Bila tim ingin warna merek yang lebih tajam seperti di shot, pakai `dynamicSchemeVariant: DynamicSchemeVariant.fidelity` (tersedia di Flutter versi baru; cek dulu dengan `flutter --version`).

### Accent — Primary

| Role | Light | Dark | Usage |
|------|-------|------|-------|
| primary | `#465D91` | `#AFC6FF` | Tombol utama (Kirim Ulasan, Coba lagi), segmen terpilih, ikon aktif |
| onPrimary | `#FFFFFF` | `#142F60` | Teks/ikon di atas primary |
| primaryContainer | `#D9E2FF` | `#2D4578` | Badge tipe **Putra**, FAB "Tulis Ulasan", indikator NavigationBar |
| onPrimaryContainer | `#2D4578` | `#D9E2FF` | Teks di atas primaryContainer |
| inversePrimary | `#AFC6FF` | `#465D91` | Aksi di dalam SnackBar |

### Accent — Secondary & Tertiary

| Role | Light | Dark | Usage |
|------|-------|------|-------|
| secondary | `#575E71` | `#BFC6DC` | Ikon info sekunder (lokasi, jarak) |
| onSecondary | `#FFFFFF` | `#293042` | Teks di atas secondary |
| secondaryContainer | `#DBE2F9` | `#404759` | Badge tipe **Campur**, ChoiceChip terpilih, kartu ringkasan area |
| onSecondaryContainer | `#404759` | `#DBE2F9` | Teks di atas secondaryContainer |
| tertiary | `#725573` | `#DFBBDE` | Aksen pendukung (inferred) |
| onTertiary | `#FFFFFF` | `#412742` | Teks di atas tertiary |
| tertiaryContainer | `#FDD7FB` | `#593E5A` | Badge tipe **Putri** |
| onTertiaryContainer | `#593E5A` | `#FDD7FB` | Teks di atas tertiaryContainer |

### Surface & Neutral

| Role | Light | Dark | Usage |
|------|-------|------|-------|
| surface | `#FAF8FF` | `#121318` | Latar halaman |
| onSurface | `#1A1B20` | `#E2E2E9` | Teks utama (nama kos, judul) |
| onSurfaceVariant | `#44464F` | `#C5C6D0` | Teks sekunder (area, tanggal), bintang kosong |
| surfaceContainerLowest | `#FFFFFF` | `#0C0E13` | Latar gambar placeholder |
| surfaceContainerLow | `#F3F3FA` | `#1A1B20` | Kartu kos |
| surfaceContainer | `#EEEDF4` | `#1E1F25` | NavigationBar |
| surfaceContainerHigh | `#E8E7EF` | `#282A2F` | Kolom teks (filled), bottom sheet |
| surfaceContainerHighest | `#E2E2E9` | `#33353A` | Latar empty state, skeleton |
| outline | `#757780` | `#8F9099` | Border OutlinedButton, TextField outlined |
| outlineVariant | `#C5C6D0` | `#44464F` | Divider, border kartu (opsional) |
| inverseSurface | `#2F3036` | `#E2E2E9` | Latar SnackBar |
| inverseOnSurface | `#F1F0F7` | `#2F3036` | Teks SnackBar |

### Semantic / Status

| Role | Light | Dark | Usage |
|------|-------|------|-------|
| error | `#BA1A1A` | `#FFB4AB` | Ikon dan teks keadaan gagal memuat |
| onError | `#FFFFFF` | `#690005` | Teks di atas error |
| errorContainer | `#FFDAD6` | `#93000A` | Latar kartu pesan gagal |
| onErrorContainer | `#93000A` | `#FFDAD6` | Teks di atas errorContainer |
| rating (bintang terisi) | `#B26A00` | `#FFC107` | Bintang rating. **Satu-satunya warna di luar ColorScheme** (lihat di bawah) |

**Warna bintang.** Amber standar (`#FFC107`) hanya 1,55:1 di latar terang, sehingga gagal syarat kontras 3:1. Mode terang memakai amber gelap `#B26A00` (4,24:1), mode gelap memakai `#FFC107` (11,38:1). Simpan di `ThemeExtension` (lihat Design Tokens) agar widget tetap membaca dari tema. Tetap catat sebagai **pengecualian 1 dari maksimal 3** di README.

---

## Typography

Font: **Plus Jakarta Sans** (lisensi SIL OFL), disimpan sebagai file di `assets/fonts/` (inferred). Fallback: `Roboto, "Noto Sans", sans-serif` (bawaan Android).

Skala mengikuti TextTheme Material 3 di Flutter. Yang diganti hanya `fontFamily`.

| Style | Size | Weight | Line Height | Spacing | Dipakai untuk |
|-------|------|--------|-------------|---------|---------------|
| Display Large | 57sp | 400 | 64sp | -0.25sp | Tidak dipakai |
| Display Medium | 45sp | 400 | 52sp | 0 | Tidak dipakai |
| Display Small | 36sp | 400 | 44sp | 0 | Tidak dipakai |
| Headline Large | 32sp | 400 | 40sp | 0 | Tidak dipakai |
| Headline Medium | 28sp | 600 (inferred) | 36sp | 0 | Judul tab Cari ("Cari kos dekat kampus") |
| Headline Small | 24sp | 600 (inferred) | 32sp | 0 | Nama kos di Detail |
| Title Large | 22sp | 600 (inferred) | 28sp | 0 | Judul AppBar |
| Title Medium | 16sp | 600 | 24sp | 0.15sp | Nama kos di kartu, judul bagian |
| Title Small | 14sp | 500 | 20sp | 0.1sp | Nama area di kartu ringkasan |
| Body Large | 16sp | 400 | 24sp | 0.5sp | Komentar ulasan, isi form |
| Body Medium | 14sp | 400 | 20sp | 0.25sp | Teks info kartu (area · jarak) |
| Body Small | 12sp | 400 | 16sp | 0.4sp | Tanggal, "Diperbarui 3 hari lalu" |
| Label Large | 14sp | 500 | 20sp | 0.1sp | Label tombol, segmen |
| Label Medium | 12sp | 500 | 16sp | 0.5sp | Label NavigationBar, badge tipe |
| Label Small | 11sp | 500 | 16sp | 0.5sp | Satuan harga "/bln" |

**Harga** memakai Title Medium 700 dengan warna `primary`, contoh `Rp1.250.000/bln` (inferred). Akhiran `/bln` memakai Label Small dengan warna `onSurfaceVariant`.

---

## Spacing

Satuan dasar **4dp**. Semua jarak adalah kelipatan 4.

| Token | Value | Dipakai untuk |
|---|---|---|
| space-1 | 4dp | Jarak ikon ke teks di baris info |
| space-2 | 8dp | Jarak antar-chip, antar-bintang |
| space-3 | 12dp | Padding dalam badge (horizontal), jarak antar-baris info |
| space-4 | 16dp | Margin layar, padding kartu, jarak antar-kartu |
| space-5 | 20dp | Jarak antar-bagian di Detail |
| space-6 | 24dp | Padding atas header tab Cari |
| space-8 | 32dp | Jarak ilustrasi empty state ke teks |

---

## Shape

| Token | Radius | Components |
|-------|--------|------------|
| None | 0dp | Gambar kos di Detail (full-bleed) |
| Extra Small | 4dp | Tooltip |
| Small | 8dp | Badge tipe kos, ChoiceChip, FilterChip, SnackBar |
| Medium | 12dp | TextField, kartu ringkasan area, sudut gambar kecil |
| Large | 16dp (inferred) | **KartuKos**, gambar di dalam kartu (sudut atas) |
| Extra Large | 28dp | Bottom sheet (sudut atas), Dialog |
| Full | 50% / stadium | FilledButton, OutlinedButton, SegmentedButton, indikator NavigationBar, IconButton favorit berlatar |

---

## Elevation

Material 3 menandai tingkat ketinggian terutama lewat **warna permukaan** (surfaceContainer*). Bayangan dipakai seperlunya.

| Level | dp | CSS Shadow (referensi web) | Usage |
|-------|-----|-----------|-------|
| 0 | 0 | none | Latar halaman, kartu kos (memakai `surfaceContainerLow`) |
| 1 | 1 | `0 1px 2px 0 rgb(0 0 0/.3), 0 1px 3px 1px rgb(0 0 0/.15)` | Kartu kos saat ditekan (inferred), tombol hati berlatar di atas gambar |
| 2 | 3 | `0 1px 2px 0 rgb(0 0 0/.3), 0 2px 6px 2px rgb(0 0 0/.15)` | NavigationBar, AppBar saat konten digulir |
| 3 | 6 | `0 1px 3px 0 rgb(0 0 0/.3), 0 4px 8px 3px rgb(0 0 0/.15)` | FAB "Tulis Ulasan", SnackBar |
| 4 | 8 | `0 2px 3px 0 rgb(0 0 0/.3), 0 6px 10px 4px rgb(0 0 0/.15)` | FAB saat ditekan |
| 5 | 12 | `0 4px 4px 0 rgb(0 0 0/.3), 0 8px 12px 6px rgb(0 0 0/.15)` | Tidak dipakai |

---

## Interaction States

Lapisan state memakai warna konten (mis. `onSurface` atau `primary`) dengan opasitas berikut.

| State | Layer Opacity | Notes |
|-------|-------------|-------|
| Enabled | 0% | Diam |
| Hover | 8% | Jarang di ponsel; tetap didukung bawaan Flutter |
| Focus | 10% | Navigasi keyboard atau D-pad |
| Pressed | 10% | Ketuk, dengan efek ripple |
| Dragged | 16% | Saat menarik pull-to-refresh |
| Disabled | 38% konten, 12% container | Tombol Kirim tidak boleh dinonaktifkan diam-diam; tampilkan SnackBar validasi |
| Selected | `secondaryContainer` sebagai latar | Segmen dan chip terpilih |

---

## Layout

KosDekat hanya menargetkan ponsel Android. Kelas lain dicatat agar layout tidak rusak saat diputar.

| Class | Width | Panes | Navigation |
|-------|-------|-------|------------|
| Compact | < 600dp | 1 | NavigationBar (3 tab) |
| Medium | 600–839dp | 1 | NavigationBar; kartu bisa 2 kolom (inferred) |
| Expanded | 840–1199dp | 1–2 | Di luar lingkup UTS |

| Aturan | Nilai |
|---|---|
| Margin layar | 16dp kiri-kanan |
| Jarak antar-kartu | 16dp |
| Rasio gambar kartu | 16:9 (inferred) |
| Tinggi gambar Detail | 240dp (inferred) |
| Tinggi NavigationBar | 80dp (bawaan M3) |
| Tinggi baris ringkasan area | 88dp, gulir horizontal (inferred) |

---

## Motion

| Token | Easing (CSS) | Flutter |
|---|---|---|
| Emphasized | `cubic-bezier(0.2, 0, 0, 1)` (pendekatan CSS) | `Curves.easeInOutCubicEmphasized`: perpindahan halaman, Hero |
| Emphasized decelerate | `cubic-bezier(0.05, 0.7, 0.1, 1)` | `Easing.emphasizedDecelerate`: elemen masuk layar |
| Emphasized accelerate | `cubic-bezier(0.3, 0, 0.8, 0.15)` | `Easing.emphasizedAccelerate`: elemen keluar layar |
| Standard | `cubic-bezier(0.2, 0, 0, 1)` | `Easing.standard`: bintang menyala, chip terpilih |

> Kelas `Easing` dan `Durations` tersedia di Flutter versi baru. Bila `flutter analyze` menolak, pakai `Curves.easeOutCubic` dan `Duration(milliseconds: ...)`.

| Durasi | Nilai | Dipakai untuk |
|---|---|---|
| short2 | 100ms | Bintang menyala saat diketuk |
| short4 | 200ms | Pergantian segmen, ikon hati |
| medium2 | 300ms | Perpindahan halaman, animasi **Hero** kartu ke Detail |
| medium4 | 400ms | Daftar tersusun ulang setelah urutan berubah (opsional) |

**Transisi:** halaman memakai transisi bawaan `MaterialPageRoute`. Gambar kos memakai **Hero** dengan tag per tab (`cari-<id>`, `favorit-<id>`).

---

## Icons

Material Icons varian **rounded** (inferred). Contoh: `Icons.search_rounded`, `Icons.favorite_rounded`.

| Ukuran | Pakai |
|---|---|
| 18dp | Ikon di dalam chip dan badge |
| 20dp | Ikon baris info (lokasi, jarak, kamar mandi) |
| 24dp | Ikon standar: NavigationBar, AppBar, IconButton |
| 36dp | Bintang di form ulasan (area sentuh tetap 48dp) |
| 96dp | Ilustrasi empty state (aset lokal) |

| Makna | Ikon |
|---|---|
| Tab Cari | `search` |
| Tab Favorit | `favorite_border` / `favorite` (terpilih) |
| Tab Profil | `person_outline` / `person` (terpilih) |
| Area / lokasi | `location_on_outlined` |
| Jarak | `directions_walk` |
| Kamar mandi dalam | `bathtub_outlined` |
| Diperbarui | `update` |
| Rating | `star` / `star_border` |
| Gagal memuat | `wifi_off_rounded` |

---

## Design Tokens

**Konvensi nama:** `kd.<lapisan>.<kategori>.<nama>`, contohnya `kd.sys.color.primary`, `kd.sys.shape.large`, `kd.ref.font.brand`.

| Token | Flutter |
|---|---|
| `kd.ref.color.seed` | `const warnaSeed = Color(0xFF1F6FEB);` (satu-satunya hex di file tema) |
| `kd.sys.color.*` | `Theme.of(context).colorScheme.*` |
| `kd.sys.color.rating` | `Theme.of(context).extension<WarnaKosDekat>()!.bintang` |
| `kd.sys.typescale.*` | `Theme.of(context).textTheme.*` |
| `kd.sys.shape.large` | `BorderRadius.circular(16)` di `cardTheme` |
| `kd.ref.font.brand` | `fontFamily: 'PlusJakartaSans'` |

Contoh di `lib/tema/tema_kosdekat.dart` (sesuaikan nama dan versi Flutter):

```dart
const warnaSeed = Color(0xFF1F6FEB); // ganti dengan seed dari shot

@immutable
class WarnaKosDekat extends ThemeExtension<WarnaKosDekat> {
  const WarnaKosDekat({required this.bintang});
  final Color bintang;
  @override
  WarnaKosDekat copyWith({Color? bintang}) =>
      WarnaKosDekat(bintang: bintang ?? this.bintang);
  @override
  WarnaKosDekat lerp(WarnaKosDekat? other, double t) =>
      WarnaKosDekat(bintang: Color.lerp(bintang, other?.bintang, t)!);
}

ThemeData buatTema(Brightness brightness) {
  final skema = ColorScheme.fromSeed(seedColor: warnaSeed, brightness: brightness);
  return ThemeData(
    colorScheme: skema,
    fontFamily: 'PlusJakartaSans',
    cardTheme: const CardThemeData( // nama kelas berbeda di Flutter lama: CardTheme
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
    extensions: [
      WarnaKosDekat(
        bintang: brightness == Brightness.light
            ? const Color(0xFFB26A00)
            : const Color(0xFFFFC107),
      ),
    ],
  );
}
```

> Jalankan `flutter analyze` setelah menempel kode ini. Nama `CardThemeData` vs `CardTheme` bergantung pada versi Flutter tim.
