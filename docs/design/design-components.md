# KosDekat Components

> Full specifications for all 28 components. Grouped by workflow.
> For tokens see [design.md](design.md). For rules & accessibility see [design-guidelines.md](design-guidelines.md).

Setiap komponen mencantumkan halaman tempat ia dipakai dan poin UTS yang dipenuhinya, agar mudah dicatat di tabel README. Ukuran bertanda **(inferred)** adalah usulan yang belum diambil dari shot Dribbble.

---

## Actions

### Filled Button

**Types:** Filled (aksi utama satu-satunya di layar).
Tinggi 40dp, area sentuh 48dp. Label: Label Large 14sp/500. Sentence case. Bentuk stadium (Full).
**Dipakai:** "Kirim ulasan" (Form Ulasan), "Coba lagi" (keadaan gagal tab Cari). **Poin:** P03 tombol M3.

| Property | Value |
|---|---|
| Container | `primary` |
| Label | `onPrimary` |
| Lebar | Form: penuh selebar layar dikurangi margin 16dp; keadaan gagal: menyesuaikan isi |
| Contrast | 6.49:1 (light), 7.69:1 (dark) |
| States | Rest, Pressed, Focus, Disabled |
| Touch target | 48x48dp min |

**Do:** Satu FilledButton per layar; awali label dengan kata kerja.
**Don't:** Menonaktifkan tombol tanpa penjelasan; memakai tanda seru.

---

### Outlined Button

**Types:** Outlined (aksi sekunder).
Tinggi 40dp. Border 1dp `outline`. Label `primary`.
**Dipakai:** "Batal" di Form Ulasan (inferred), alternatif "Muat ulang ringkasan area". **Poin:** P03 tombol M3.

| Property | Value |
|---|---|
| Border | 1dp `outline` (4.24:1 light) |
| Label | `primary` |
| States | Rest, Pressed, Focus, Disabled |
| Touch target | 48x48dp min |

**Do:** Letakkan di sebelah kiri FilledButton bila berdampingan.
**Don't:** Menjadikannya aksi utama.

---

### Icon Button

**Types:** Standard (tanpa latar), Filled tonal (latar bulat di atas foto).
Ikon 24dp, area sentuh 48dp. Wajib `tooltip`.
**Dipakai:** Hati favorit di KartuKos dan AppBar Detail, bintang rating di Form Ulasan, tombol kembali. **Poin:** P03 tombol M3.

| Property | Value |
|---|---|
| Favorit (tidak aktif) | `Icons.favorite_border`, warna `onSurfaceVariant` |
| Favorit (aktif) | `Icons.favorite`, warna `primary` (inferred) |
| Latar di atas foto | Lingkaran 40dp `surface` alpha 0.85 |
| Tooltip | "Tambah ke favorit" / "Hapus dari favorit" |
| States | Rest, Pressed, Selected, Focus |
| Touch target | 48x48dp min |

**Do:** Ganti ikon (outline ke terisi) sekaligus warna saat aktif.
**Don't:** Meletakkan ikon hati tanpa latar di atas foto terang.

---

### Floating Action Button (Extended)

**Types:** Extended FAB dengan ikon + label.
Tinggi 56dp, radius 16dp, elevasi level 3. Ikon `rate_review_outlined` 24dp + label "Tulis ulasan".
**Dipakai:** Halaman Detail, kanan bawah. **Poin:** P03 tombol M3, pemicu P05 form.

| Property | Value |
|---|---|
| Container | `primaryContainer` |
| Konten | `onPrimaryContainer` |
| Posisi | `FloatingActionButtonLocation.endFloat`, margin 16dp |
| States | Rest, Pressed, Focus |

**Do:** Satu FAB per layar; untuk aksi paling penting di halaman.
**Don't:** Menampilkan FAB di tab Cari (aksi tambah ulasan ada di Detail).

---

## Input

### Segmented Button — Tipe Kos

**Types:** Single-select, tiga segmen: Putra · Putri · Campur. `emptySelectionAllowed: true` (tanpa pilihan = semua kos).
Tinggi 40dp, bentuk stadium, ikon centang pada segmen terpilih (bawaan M3).
**Dipakai:** Tab Cari, di atas daftar. **Poin:** Fitur khas 1, P03 pilihan.

| Property | Value |
|---|---|
| Segmen terpilih | Latar `secondaryContainer`, teks `onSecondaryContainer` |
| Segmen lain | Latar transparan, teks `onSurface`, border `outline` |
| Ikon (opsional) | `male`, `female`, `people` 18dp |
| Lebar | Penuh selebar layar dikurangi margin 16dp |
| States | Rest, Selected, Pressed, Focus |

**Do:** Ubah tampilan lewat `setState` tanpa memanggil server.
**Don't:** Memakai lebih dari 5 segmen.

---

### Choice Chip — Urutan

**Types:** Single-select, dua chip: "Termurah" dan "Terdekat".
Tinggi 32dp, radius 8dp. Ikon 18dp: `payments_outlined`, `near_me_outlined`.
**Dipakai:** Tab Cari, di bawah SegmentedButton. **Poin:** Fitur khas 2.

| Property | Value |
|---|---|
| Terpilih | Latar `secondaryContainer`, ikon centang |
| Tidak terpilih | Border `outline`, latar transparan |
| Jarak antar-chip | 8dp |
| States | Rest, Selected, Pressed, Focus |

**Do:** Selalu ada satu urutan aktif (default "Termurah", inferred).
**Don't:** Mencampur filter dan urutan dalam satu kelompok chip.

---

### Filter Chip — Kamar Mandi Dalam (opsional)

**Types:** Toggle, satu chip "Kamar mandi dalam" dengan ikon `bathtub_outlined`.
Spesifikasi sama dengan ChoiceChip. **Dipakai:** Tab Cari (inovasi B). Memakai field bool `kamarMandiDalam`.

**Do:** Gabungkan hasilnya dengan filter tipe dan urutan.
**Don't:** Menaruhnya di baris terpisah bila layar sempit; ikutkan di baris chip urutan.

---

### Text Field

**Types:** Outlined (inferred). Varian satu baris (nama kos, `readOnly`) dan multi-baris (komentar, `maxLines: 4`).
Tinggi minimal 56dp, radius 12dp, label mengambang. Teks Body Large 16sp.
**Dipakai:** Form Ulasan. **Poin:** P03 TextField + controller di-dispose.

| Property | Value |
|---|---|
| Border diam | 1dp `outline` |
| Border fokus | 2dp `primary` |
| Border error | 2dp `error`, teks bantu `error` |
| Label | "Nama kos", "Komentar" |
| Teks bantu | "Ceritakan kebersihan, keamanan, atau pemilik kos" (inferred) |
| Penghitung | 0/300 karakter (inferred) |
| States | Rest, Focus, Error, Read-only |

**Do:** Pakai `TextEditingController` dan dispose di `dispose()`.
**Don't:** Memakai placeholder sebagai pengganti label.

---

### Star Rating Input

**Types:** Komponen buatan sendiri: `Row` berisi 5 `IconButton`.
Ikon 36dp, area sentuh 48dp, total lebar 240dp. Di bawahnya teks "4 dari 5" Body Medium.
**Dipakai:** Form Ulasan. **Poin:** Fitur khas form ulasan (bintang yang bisa diketuk), P03 `setState`.

| Property | Value |
|---|---|
| Bintang terisi | `Icons.star_rounded`, warna `WarnaKosDekat.bintang` (`#B26A00` light, `#FFC107` dark) |
| Bintang kosong | `Icons.star_border_rounded`, warna `onSurfaceVariant` |
| Tooltip | "Beri 1 bintang" sampai "Beri 5 bintang" |
| Animasi | Skala 1.0 ke 1.15 ke 1.0, 100ms (opsional) |
| Nilai awal | 0 (belum memilih) |

**Do:** Ketuk bintang ke-n membuat bintang 1 sampai n menyala.
**Don't:** Memakai `Colors.amber` langsung di widget; ambil dari ThemeExtension.

---

### Switch — Mode Gelap (opsional)

**Types:** M3 Switch dengan ikon thumb.
**Dipakai:** Tab Profil, baris "Mode gelap". Memperlihatkan `darkTheme` saat demo.

| Property | Value |
|---|---|
| Aktif | Track `primary`, thumb `onPrimary` |
| Tidak aktif | Track `surfaceContainerHighest`, border `outline` |
| Touch target | 48dp |

---

## Navigation

### Navigation Bar

**Types:** M3 NavigationBar, 3 tujuan: Cari · Favorit · Profil, dengan label selalu tampil.
Tinggi 80dp, indikator pil 64×32dp. **Dipakai:** HalamanUtama + `IndexedStack`. **Poin:** P04.

| Property | Value |
|---|---|
| Container | `surfaceContainer` |
| Indikator aktif | `secondaryContainer` (bawaan M3) |
| Ikon aktif / tidak | Versi terisi / outline (`favorite` / `favorite_border`) |
| Label | Label Medium 12sp/500 |
| Badge (opsional) | Jumlah favorit di tab Favorit |

**Do:** Pertahankan keadaan tiap tab dengan `IndexedStack`.
**Don't:** Menambah tab keempat di luar ketentuan.

---

### Top App Bar

**Types:** Tab Cari: tanpa AppBar, diganti header besar (inferred). Detail: `SliverAppBar` dengan gambar 240dp yang menyusut saat digulir (inferred). Form: AppBar kecil "Tulis ulasan".

| Property | Value |
|---|---|
| Judul | Title Large 22sp |
| Latar saat digulir | `surfaceContainer` |
| Aksi Detail | IconButton favorit |

---

### Header Tab Cari

**Types:** Komponen buatan sendiri (inferred, menyesuaikan shot).
Padding atas 24dp, margin 16dp. Baris 1: sapaan Body Medium "Halo, Mahasiswa Tel-U" warna `onSurfaceVariant`. Baris 2: Headline Medium "Cari kos dekat kampus".

**Do:** Ganti gaya ini sesuai header di shot (token "Gaya header/pencarian halaman Cari").
**Don't:** Menambah kolom pencarian bila tidak dikerjakan; kolom kosong yang tidak berfungsi membingungkan.

---

## Containment

### Kartu Kos (KartuKos)

**Types:** Kartu vertikal, gambar di atas (inferred).
Radius 16dp, latar `surfaceContainerLow`, elevasi 0, padding konten 16dp, margin bawah 16dp.
**Dipakai:** Tab Cari dan tab Favorit. **Poin:** P04 kartu (Row, Column, Expanded, Stack), P03 StatelessWidget.

| Bagian | Spesifikasi | Widget |
|---|---|---|
| Gambar | Rasio 16:9, sudut atas 16dp, aset lokal | `Stack` |
| Badge tipe | Kiri atas, inset 12dp | `Positioned` |
| Tombol favorit | Kanan atas, inset 8dp | `Positioned` + `IconButton` |
| Nama kos | Title Medium, maks. 1 baris + ellipsis | `Column` |
| Baris info | Ikon 20dp + "Sukapura · 0,8 km" Body Medium `onSurfaceVariant` | `Row` |
| Fasilitas | Ikon kamar mandi + "KM dalam" bila `true` | `Row` |
| Harga | "Rp1.250.000" Title Medium 700 `primary` + "/bln" Label Small | `Row` + `Expanded` (teks kiri mengisi, harga kanan) |
| Rating (opsional) | Bintang 16dp + "4,5 (3)" | `Row` |

**Do:** Seluruh kartu dapat diketuk untuk membuka Detail; gambar dibungkus `Hero`.
**Don't:** Menampilkan lebih dari 3 baris informasi di bawah nama.

---

### Kartu Ringkasan Area

**Types:** Kartu kecil di baris gulir horizontal (data dari `GET /area`).
Lebar 160dp, tinggi 88dp, radius 12dp, latar `secondaryContainer`, padding 12dp, jarak antar-kartu 12dp.
**Dipakai:** Tab Cari, di bawah header. **Poin:** endpoint khas dipakai di aplikasi.

| Baris | Isi | Style |
|---|---|---|
| 1 | Nama area | Title Small, `onSecondaryContainer` |
| 2 | "rata-rata" | Body Small |
| 3 | "Rp1.320.000/bln · 5 kos" | Label Large |

**Do:** Sembunyikan baris ini bila `/area` gagal; keadaan gagal utama tetap di daftar.
**Don't:** Memakai warna berbeda untuk tiap area.

---

### Divider

**Types:** Full-width 1dp `outlineVariant`.
**Dipakai:** Pemisah bagian di Detail (info, fasilitas, ulasan) dan antar-item ulasan di Profil.

---

## Data Display

### Badge Tipe Kos

**Types:** Label kecil berlatar container berbeda per tipe.
Tinggi 24dp, radius 8dp, padding horizontal 12dp, teks Label Medium 12sp/500.

| Tipe | Latar | Teks | Contrast (light) |
|---|---|---|---|
| Putra | `primaryContainer` | `onPrimaryContainer` | 7.28:1 |
| Putri | `tertiaryContainer` | `onTertiaryContainer` | 7.20:1 |
| Campur | `secondaryContainer` | `onSecondaryContainer` | 7.18:1 |

**Do:** Selalu tulis labelnya; warna hanya penguat.
**Don't:** Memakai `Colors.pink` atau `Colors.blue` untuk tipe.

---

### Info Row

**Types:** Ikon 20dp `secondary` + teks Body Medium. Jarak ikon ke teks 4dp, antar-baris 12dp.
**Dipakai:** Detail: area, jarak + "±10 menit jalan kaki", kamar mandi dalam, "Diperbarui 3 hari lalu" (inovasi C dan D).

---

### Price Text

**Types:** Teks harga hasil `formatRupiah()`. Contoh persis: **"Rp1.250.000/bln"**.
Angka Title Medium 700 `primary`; di Detail Headline Small 700. **Poin:** Fitur khas 3.

**Do:** Selalu lewat satu fungsi `formatRupiah` yang sudah diuji.
**Don't:** Memformat manual di tiap widget.

---

### Rating Display

**Types:** Bintang 16dp terisi/kosong + angka rata-rata + jumlah ulasan: "4,5 (3 ulasan)".
**Dipakai:** Kartu (opsional) dan Detail (inovasi E). Warna bintang dari `WarnaKosDekat.bintang`.

---

### Ulasan List Item

**Types:** Item daftar 3 baris.
Padding 16dp. Baris 1: nama kos (Title Small) + tanggal di kanan (Body Small `onSurfaceVariant`). Baris 2: Rating Display. Baris 3: komentar Body Medium, maks. 4 baris + "Selengkapnya" (inferred).
**Dipakai:** Detail (ulasan kos ini) dan tab Profil ("Ulasan saya"). **Poin:** P05 data form langsung muncul di daftar.

---

### Avatar

**Types:** `CircleAvatar` 64dp, latar `primaryContainer`, inisial Title Large `onPrimaryContainer`, atau aset lokal.
**Dipakai:** Header tab Profil.

---

### Gambar Kos & Ilustrasi

**Types:** `Image.asset` dari `assets/images/`.

| Pemakaian | Ukuran | Bentuk |
|---|---|---|
| Kartu | 16:9 | Sudut atas 16dp |
| Detail | Lebar penuh, tinggi 240dp | Tanpa sudut |
| Empty state | 160dp (inferred) | Bebas |

**Do:** Pakai gambar buatan sendiri atau berlisensi bebas, dan catat sumbernya di README.
**Don't:** Memakai foto dari shot Dribbble atau foto kos nyata tanpa izin.

---

## Feedback

### Progress Indicator

**Types:** `CircularProgressIndicator` 40dp, warna `primary`, di tengah area daftar, dengan teks "Memuat daftar kos..." Body Medium di bawahnya.
**Dipakai:** Keadaan memuat FutureBuilder. **Poin:** P07 tiga keadaan.

---

### Error State

**Types:** Blok tengah: ikon `wifi_off_rounded` 48dp `error`, judul Title Medium "Tidak dapat terhubung ke server", teks Body Medium `onSurfaceVariant` "Pastikan server menyala, lalu coba lagi.", lalu FilledButton "Coba lagi".
**Dipakai:** Keadaan gagal FutureBuilder. **Poin:** P07 (tombol Coba lagi), adegan video wajib.

| Property | Value |
|---|---|
| Jarak ikon ke judul | 16dp |
| Jarak teks ke tombol | 24dp |
| Pull-to-refresh | Tetap bisa ditarik (bungkus dalam ListView) |

---

### Empty State

**Types:** Ilustrasi aset + judul Title Medium + teks bantu Body Medium.

| Tempat | Teks |
|---|---|
| Hasil filter kosong | "Belum ada kos untuk pilihan ini" |
| Favorit kosong | "Belum ada kos favorit. Ketuk ikon hati di tab Cari." |
| Ulasan kosong | "Belum ada ulasan. Buka detail kos lalu tulis ulasan." |

---

### Snackbar

**Types:** M3 SnackBar mengambang, radius 8dp (inferred), latar `inverseSurface`, teks `inverseOnSurface`, aksi `inversePrimary`. Durasi 4 detik.
**Dipakai:** "Ulasan tersimpan", "Ditambahkan ke Favorit", "Beri bintang dan komentar dulu", "Gagal mengirim, ulasan disimpan di perangkat". **Poin:** P03 SnackBar.

**Do:** Satu pesan singkat, paling banyak 2 baris; tambahkan aksi "Batalkan" untuk hapus favorit (opsional).
**Don't:** Menumpuk beberapa SnackBar; panggil `hideCurrentSnackBar()` dulu.

---

### Pull-to-Refresh Indicator

**Types:** `RefreshIndicator` M3, warna `primary`, latar `surfaceContainerHigh`.
**Dipakai:** Tab Cari (nilai tambah +2). Daftar memakai `AlwaysScrollableScrollPhysics` agar keadaan kosong dan gagal tetap bisa ditarik.

---

## Ringkasan komponen per halaman

| Halaman | Komponen |
|---|---|
| Tab Cari | Header, Kartu Ringkasan Area, Segmented Button, Choice Chip, Filter Chip (opsional), Kartu Kos, Progress Indicator, Error State, Empty State, Pull-to-Refresh |
| Detail | Top App Bar (sliver), Gambar, Badge, Price Text, Info Row, Divider, Rating Display, Ulasan List Item, FAB Extended, Snackbar |
| Form Ulasan | Top App Bar, Text Field (2), Star Rating Input, Filled Button, Outlined Button, Snackbar |
| Tab Favorit | Kartu Kos, Empty State, Snackbar |
| Tab Profil | Avatar, Ulasan List Item, Divider, Switch (opsional), Empty State |
| Semua | Navigation Bar |
