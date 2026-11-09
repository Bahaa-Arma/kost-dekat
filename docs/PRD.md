# PRD KosDekat — Aplikasi Info Kos Sekitar Telkom University

9 November 2026 · Kelompok 06 · Versi 1.0 (draf untuk ditinjau tim)

> Kembali ke [README utama](../README.md) · Indeks dokumen: [docs/README.md](README.md)

KosDekat adalah aplikasi Android (Flutter) dengan server REST API Dart yang membantu mahasiswa Telkom University menemukan, membandingkan, dan mengulas kos di Sukapura, Sukabirus, Bojongsoang, dan sekitarnya. Versi pertama ditargetkan selesai pada Kamis, 12 November 2026 pukul 23.59 WIB sebagai Proyek UTS Pengembangan Aplikasi Bergerak.

## Informasi Dokumen

| Atribut | Isi |
| --- | --- |
| Produk | KosDekat: info kos sekitar kampus |
| Konteks | UTS Pengembangan Aplikasi Bergerak, Pertemuan 8 |
| Tim | Kelompok 06, Proyek 5, 5 anggota |
| Platform | Android, frontend Flutter (Dart), backend Dart shelf + shelf\_router, REST API (HTTP + JSON) |
| Versi dokumen | 1.0 (draf untuk ditinjau tim) |
| Repositori | [PAB-Kost-Dekat/kost-dekat](https://github.com/PAB-Kost-Dekat/kost-dekat) |
| Manajemen tugas | Jira project SCRUM (9 epic, 40 task) |
| Batas pengumpulan | Kamis, 12 November 2026 pukul 23.59 WIB |

## Ringkasan Eksekutif

Informasi kos di sekitar Telkom University masih tersebar di grup chat, media sosial, dan papan iklan. Harga, jarak, dan tanggal pembaruannya pun sering tidak jelas. Akibatnya mahasiswa sulit membandingkan pilihan secara cepat dan adil.

KosDekat menyatukan data kos dalam satu daftar yang bisa difilter berdasarkan tipe (Putra, Putri, Campur), diurutkan berdasarkan harga atau jarak, dan menampilkan harga dalam format Rupiah yang konsisten. Pengguna juga bisa menyimpan favorit dan menulis ulasan berbintang. Server menyediakan ringkasan harga rata-rata per area.

PRD ini menerjemahkan ketentuan UTS (fitur wajib P01 sampai P07 dan fitur khas KosDekat) menjadi kebutuhan produk yang bisa diuji. Setiap kebutuhan diberi ID agar bisa dilacak ke tiket Jira, tabel README, dan kriteria penerimaan.

## Daftar Isi

1. [Analisis Kebutuhan](#1-analisis-kebutuhan)
2. [Problem Statement](#2-problem-statement)
3. [Business Objectives](#3-business-objectives)
4. [Stakeholder Requirements](#4-stakeholder-requirements)
5. [Functional Requirements](#5-functional-requirements)
6. [Non-Functional Requirements](#6-non-functional-requirements)
7. [User Stories](#7-user-stories)
8. [Acceptance Criteria](#8-acceptance-criteria)
9. [Scope dan Out of Scope](#9-scope-dan-out-of-scope)
10. [Risiko, Asumsi, dan Pertanyaan Terbuka](#10-risiko-asumsi-dan-pertanyaan-terbuka)

## 1. Analisis Kebutuhan

Analisis menghasilkan 28 kebutuhan wajib umum, 7 kebutuhan khas tema, dan 3 kebutuhan nilai tambah, ditambah 6 keputusan atas bagian ketentuan yang ambigu. Semua kebutuhan di bab berikutnya berasal dari daftar ini.

### 1.1 Sumber kebutuhan

| No | Sumber | Peran dalam PRD | Status |
| --- | --- | --- | --- |
| 1 | Dokumen UTS P08 (Bagian 1 sampai 8) | Satu-satunya sumber ketentuan dosen; menang bila bertentangan | Dibaca penuh |
| 2 | Rangkuman materi PAB P03 sampai P07 | Acuan pola kode | Belum dilampirkan, perlu diverifikasi |
| 3 | Referensi visual Dribbble "Papa Kost" | Acuan gaya visual saja | Token desain belum diisi tim |
| 4 | Masalah nyata pencarian kos di sekitar kampus | Dasar problem statement dan user story | Didukung data publik (bab 2) |

### 1.2 Metode

1. **Dekomposisi dokumen.** Setiap butir Bagian 3 (fitur wajib) dan Bagian 5 (Proyek 5 KosDekat) dipecah menjadi satu kebutuhan yang bisa diuji.
2. **Klasifikasi.** Kebutuhan dibagi menjadi fungsional (FR) dan non-fungsional (NFR), lalu diberi prioritas MoSCoW: Must (wajib dinilai), Should (rekomendasi yang menurunkan risiko), Could (nilai tambah).
3. **Pemetaan pemangku kepentingan.** Setiap kebutuhan dikaitkan dengan pihak yang memintanya atau merasakannya.
4. **Penelusuran (traceability).** Setiap FR dan NFR diberi ID dan dipetakan ke tiket Jira dan baris tabel README.

### 1.3 Ringkasan klasifikasi

| Kelompok | Jumlah butir | Bobot nilai | Prioritas |
| --- | --- | --- | --- |
| P01 sampai P02: proyek, perangkat, analyze bersih | 4 | 10% | Must |
| P03: widget dasar, input, interaksi | 5 | 15% | Must |
| P04: model, layout, navigasi bawah | 4 | 15% | Must |
| P05: detail, form, async, test | 4 | 15% | Must |
| P06: tema, font, ikon, aset | 5 | 10% | Must |
| P07: server, HTTP, JSON, FutureBuilder, MockClient | 6 | 20% | Must |
| Fitur khas KosDekat (Bagian 5) | 7 | 10% | Must |
| README, tangkapan layar, video | 4 | 5% | Must |
| Nilai tambah: POST, pull-to-refresh, Hero | 3 | maks. +10 | Could |

### 1.4 Ambiguitas dan keputusan tim

| No | Ambiguitas dalam ketentuan | Keputusan | Alasan |
| --- | --- | --- | --- |
| A1 | Model Kos tidak punya rating dan komentar, padahal form tambah berupa ulasan | Buat model terpisah `Ulasan` (kosId, namaKos, rating, komentar, tanggal) | Model Kos tetap persis sesuai Bagian 5; ulasan tetap bisa ditampilkan di daftar |
| A2 | Bagian 3 meminta 3 widget test, Bagian 4 menulis 3 widget test + 1 test MockClient | Buat minimal 3 widget test dan 1 test MockClient terpisah | Memenuhi kedua bacaan |
| A3 | "Data langsung muncul di daftar" tidak menyebut daftar yang mana | Ulasan baru tampil di halaman Detail dan tab Profil | Terlihat jelas di video demo |
| A4 | Daftar tombol Material 3 diawali kata "misalnya" | Pakai FilledButton, IconButton, dan FloatingActionButton | Jenis yang disebut PDF, tidak menimbulkan keraguan penilai |
| A5 | Batas 3 pengecualian `Colors.xxx` tidak menjelaskan apakah `Colors.transparent` ikut dihitung | Semua `Colors.xxx` dihitung | Aman pada tafsiran paling ketat |
| A6 | Aplikasi tidak diwajibkan memanggil `GET /kos/<id>` | Detail menerima objek lewat konstruktor; `GET /area` tetap dipakai di aplikasi | Mengikuti bunyi PDF dan menunjukkan endpoint khas berfungsi |

## 2. Problem Statement

Mahasiswa Telkom University yang perlu tinggal di sekitar kampus belum punya satu tempat untuk membandingkan kos berdasarkan tipe, harga, jarak, dan kesegaran informasi. Akibatnya keputusan sewa diambil dengan data yang tidak lengkap dan sulit dibandingkan.

### 2.1 Konteks

- Kampus utama Telkom University berada di Jl. Telekomunikasi, Sukapura, Kecamatan Dayeuhkolot, Kabupaten Bandung ([Telkom University](https://telkomuniversity.ac.id/visit)). Permukiman kos mahasiswa terkonsentrasi di desa sekitarnya, seperti Sukapura, Sukabirus, dan Bojongsoang.
- Kampus ini memiliki asrama yang wajib ditempati mahasiswa tahun pertama ([Gramedia](https://www.gramedia.com/pendidikan/universitas/universitas-telkom)). Setelah tahun pertama, mahasiswa yang tidak tinggal bersama keluarga umumnya harus mencari tempat tinggal sendiri.
- Jumlah mahasiswanya besar. Sambutan rektor pada wisuda Agustus 2020 menyebut *student body* sebanyak 28.789 mahasiswa dalam 7 fakultas ([Buku Wisuda Tel-U, 2020](https://wisudawan.telkomuniversity.ac.id/wp-content/uploads/2024/08/wisuda-per-II-III-REVISI.pdf)). Angka terbaru belum ditemukan dari sumber resmi, jadi angka ini dipakai sebagai gambaran skala, bukan data saat ini.
- Kebutuhan ini sudah diakui di lingkungan kampus. Salah satunya terlihat dari usulan aplikasi Tekos di portal inovasi Telkom University untuk mencari kos, kontrakan, dan layanan di sekitar kampus ([BTP Telkom University](https://btp.telkomuniversity.ac.id/landing/ip/HCAP2908232801)).

### 2.2 Masalah yang dijawab

| No | Masalah | Dampak bagi mahasiswa | Jawaban KosDekat |
| --- | --- | --- | --- |
| M1 | Informasi kos tersebar di banyak kanal dengan format berbeda | Waktu habis untuk mengumpulkan dan menyalin data | Satu daftar kos dengan format seragam (FR-02) |
| M2 | Sulit memilah kos sesuai tipe penghuni | Banyak kos yang dilihat ternyata tidak sesuai (mis. kos putra bagi mahasiswi) | Filter Putra / Putri / Campur (FR-04) |
| M3 | Harga dan jarak sulit dibandingkan | Pilihan diambil tanpa membandingkan biaya dan waktu tempuh | Urutan termurah atau terdekat, harga Rupiah seragam (FR-05, FR-06) |
| M4 | Tidak jelas kapan informasi terakhir diperbarui | Mahasiswa datang ke kos yang harganya sudah berubah atau kamarnya penuh | Tanggal pembaruan tampil di detail (FR-08) |
| M5 | Tidak ada gambaran harga wajar per area | Sulit menilai apakah sebuah harga mahal atau murah | Ringkasan harga rata-rata per area dari `GET /area` (FR-07) |
| M6 | Pengalaman penghuni sulit ditemukan | Kualitas kos hanya diketahui setelah menyewa | Ulasan berbintang dan komentar (FR-10, FR-11) |
| M7 | Kandidat kos mudah terlupa saat membandingkan | Mahasiswa mencatat kandidat secara manual | Daftar favorit (FR-12) |

### 2.3 Batasan pernyataan masalah

Masalah M1 sampai M7 adalah hipotesis tim yang disusun dari konteks di atas dan pengalaman mahasiswa. Hipotesis ini belum divalidasi dengan survei. Untuk UTS, validasinya cukup lewat demo fungsi. Bila proyek dilanjutkan, langkah pertama adalah survei singkat ke mahasiswa tingkat 2 ke atas (lihat Pertanyaan Terbuka).

## 3. Business Objectives

Tujuan utama versi ini adalah lulus seluruh komponen penilaian UTS tanpa pengurangan, sambil membuktikan bahwa KosDekat benar-benar menjawab masalah M1 sampai M7. Tujuan disusun dalam format OKR agar setiap tujuan punya ukuran yang bisa dicek.

### 3.1 Tujuan dan hasil kunci (versi UTS)

| ID | Objective | Key result | Target | Cara ukur |
| --- | --- | --- | --- | --- |
| BO-1 | Memenuhi seluruh ketentuan UTS | Butir Bagian 3 yang terpenuhi dan tercatat di README | 28 dari 28 | Audit tiket SCRUM-49 |
| BO-1 |  | Fitur khas KosDekat yang terpenuhi | 7 dari 7 | Audit tiket SCRUM-49 |
| BO-2 | Tidak terkena pengurangan nilai | Hasil `flutter analyze` | 0 issue (error, warning, info) | Terminal dan GitHub Actions |
| BO-2 |  | Proyek berjalan dari clone baru hanya dengan README | Berhasil di percobaan pertama | Tiket SCRUM-39 |
| BO-2 |  | Kode, data, dan endpoint yang mirip Temuin | 0 | Review kode sebelum merge |
| BO-3 | Menambah nilai di luar fitur wajib | Nilai tambah yang selesai | Minimal +5 dari maks. +10 | Tabel nilai tambah README |
| BO-4 | Menjaga mutu kode | Test yang lulus | 100% (minimal 3 widget test + 1 test MockClient) | `flutter test` |
| BO-5 | Kontribusi merata | Anggota yang punya commit bermakna | 5 dari 5 | GitHub Insights, Contributors |
| BO-6 | Pengumpulan tepat waktu | Berkas LMS lengkap (repo, zip, APK, video) | Terkirim paling lambat Kamis 12 November 2026 pukul 20.00 WIB | Status LMS |

### 3.2 Ukuran keberhasilan produk saat demo

Karena belum ada pengguna sungguhan, keberhasilan produk diukur lewat skenario tugas saat demo.

| ID | Skenario tugas | Target |
| --- | --- | --- |
| PM-1 | Menemukan kos Putri termurah dari layar awal | Paling banyak 2 ketukan setelah data tampil |
| PM-2 | Membandingkan harga rata-rata tiga area | Terlihat di layar Cari tanpa berpindah halaman |
| PM-3 | Menulis ulasan dan melihatnya muncul | Ulasan tampil di Detail dan Profil tanpa memuat ulang aplikasi |
| PM-4 | Pulih saat server mati lalu hidup kembali | Data tampil lagi setelah satu ketukan "Coba lagi" |

### 3.3 Arah jika proyek dilanjutkan

Bila dikembangkan setelah UTS, keberhasilan dapat diukur dengan kerangka HEART. Contohnya kepuasan pengguna (Happiness), jumlah pencarian per minggu (Engagement), dan persentase pengguna yang menyelesaikan pencarian kos (Task Success). Target angka belum ditetapkan karena belum ada data pengguna.

## 4. Stakeholder Requirements

Ada empat pemangku kepentingan. Dosen menentukan apa yang wajib, mahasiswa pencari kos menentukan apa yang berguna, tim pengembang menentukan apa yang realistis dalam 4 hari, dan pemilik kos hanya terdampak tidak langsung di versi ini.

### 4.1 Daftar pemangku kepentingan

| Pemangku kepentingan | Peran | Kepentingan utama | Pengaruh |
| --- | --- | --- | --- |
| Dosen PAB | Penilai dan pemilik ketentuan | Seluruh materi P01 sampai P07 terbukti dipakai, aplikasi bisa dijalankan | Tinggi |
| Mahasiswa pencari kos | Pengguna akhir | Cepat menemukan kos yang sesuai tipe, anggaran, dan jarak | Tinggi |
| Tim Kelompok 06 (A1 sampai A5) | Pengembang, penguji, dokumentasi | Lingkup jelas, pembagian kerja adil, tidak ada pekerjaan ulang | Sedang |
| Pemilik kos | Pihak yang datanya ditampilkan | Informasi kosnya tidak salah atau menyesatkan | Rendah (versi ini memakai data fiktif) |

### 4.2 Kebutuhan per pemangku kepentingan

| ID | Pemangku kepentingan | Kebutuhan | Dipenuhi oleh |
| --- | --- | --- | --- |
| SR-01 | Dosen | Proyek dibuat dengan `--org id.ac.telkomuniversity`, nama launcher "KosDekat", berjalan di Android | NFR-01, NFR-02 |
| SR-02 | Dosen | Setiap butir Bagian 3 dapat ditunjukkan File:baris di README | NFR-09 |
| SR-03 | Dosen | Server Dart shelf dengan 3 endpoint GET termasuk `GET /area` | FR-09 |
| SR-04 | Dosen | `flutter analyze` bersih dan `flutter test` lulus | NFR-03, NFR-04 |
| SR-05 | Dosen | Video 3 sampai 5 menit memperlihatkan alur wajib, termasuk gagal lalu berhasil setelah "Coba lagi" | FR-01, NFR-10 |
| SR-06 | Dosen | Tidak menyalin Temuin atau kelompok lain | NFR-08 |
| SR-07 | Mahasiswa | Melihat semua kos dengan harga, jarak, tipe, dan fasilitas kamar mandi dalam satu daftar | FR-02 |
| SR-08 | Mahasiswa | Menyaring kos sesuai tipe penghuni | FR-04 |
| SR-09 | Mahasiswa | Mengurutkan kos dari yang termurah atau terdekat | FR-05 |
| SR-10 | Mahasiswa | Membaca harga dalam format Rupiah yang lazim | FR-06 |
| SR-11 | Mahasiswa | Mengetahui harga wajar di tiap area | FR-07 |
| SR-12 | Mahasiswa | Mengetahui seberapa baru informasi kos | FR-08 |
| SR-13 | Mahasiswa | Membaca dan menulis ulasan berbintang | FR-10, FR-11 |
| SR-14 | Mahasiswa | Menyimpan kandidat kos untuk dibandingkan nanti | FR-12 |
| SR-15 | Mahasiswa | Tetap tahu apa yang terjadi saat koneksi gagal | FR-01 |
| SR-16 | Tim | Lingkup yang bisa selesai dalam 4 hari kerja | Bab 9 |
| SR-17 | Tim | Kode bisa dites tanpa server sungguhan | NFR-05 |
| SR-18 | Tim | Kontribusi setiap anggota tercatat | NFR-11 |
| SR-19 | Pemilik kos | Data contoh tidak memakai nama kos nyata dengan harga karangan | NFR-12 |

### 4.3 Persona pengguna

**Persona utama: Dinda, mahasiswi semester 3.** Ia baru keluar dari asrama dan mencari kos putri di bawah Rp1.300.000 per bulan, maksimal 1 km dari kampus. Ia ingin membandingkan beberapa kandidat sebelum survei langsung bersama orang tuanya.

**Persona kedua: Raka, mahasiswa semester 5.** Kontrak kosnya habis bulan depan dan ia ingin pindah ke kos dengan kamar mandi dalam. Ia sering membaca pengalaman penghuni lain sebelum memutuskan.

Kedua persona adalah contoh rekaan untuk memandu desain, bukan hasil wawancara.

## 5. Functional Requirements

KosDekat punya 14 kebutuhan fungsional wajib (Must) dan 3 kebutuhan nilai tambah (Could). Kolom "Poin UTS" menunjukkan butir ketentuan yang dipenuhi, dan kolom "Jira" menunjukkan tiket pengerjaannya.

### 5.1 Daftar kebutuhan fungsional

| ID | Kebutuhan | Poin UTS | Prioritas | Jira |
| --- | --- | --- | --- | --- |
| FR-01 | Sistem memuat daftar kos dari server dan menampilkan tiga keadaan: memuat, gagal dengan tombol "Coba lagi", dan berhasil | P07 FutureBuilder | Must | SCRUM-22 |
| FR-02 | Sistem menampilkan setiap kos dalam kartu berisi gambar, nama, area, jarak, tipe, harga, dan penanda kamar mandi dalam | P04 kartu, ListView.builder | Must | SCRUM-21, SCRUM-22 |
| FR-03 | Sistem menyediakan navigasi bawah dengan tab Cari, Favorit, dan Profil yang mempertahankan keadaan tiap tab | P04 NavigationBar + IndexedStack | Must | SCRUM-27 |
| FR-04 | Pengguna dapat menyaring kos berdasarkan tipe Putra, Putri, atau Campur | Fitur khas 1, P03 pilihan | Must | SCRUM-23 |
| FR-05 | Pengguna dapat mengurutkan kos berdasarkan harga termurah atau jarak terdekat | Fitur khas 2 | Must | SCRUM-24 |
| FR-06 | Sistem menampilkan harga dalam format Rupiah, contoh "Rp1.250.000/bln" | Fitur khas 3 | Must | SCRUM-25 |
| FR-07 | Sistem menampilkan ringkasan area beserta harga rata-rata dan jumlah kos dari `GET /area` | Endpoint khas | Must | SCRUM-26 |
| FR-08 | Pengguna dapat membuka halaman detail yang menerima objek kos lewat konstruktor dan menampilkan seluruh atribut, termasuk tanggal pembaruan | P05 detail | Must | SCRUM-28 |
| FR-09 | Server menyediakan `GET /kos`, `GET /kos/<id>` (404 bila tidak ada), dan `GET /area` dari data awal minimal 12 kos | P07 server, 3 GET | Must | SCRUM-13 sampai SCRUM-16 |
| FR-10 | Pengguna dapat mengisi form ulasan berisi nama kos, rating 1 sampai 5 lewat bintang yang bisa diketuk, dan komentar, dengan validasi isian | Form tambah, P03 TextField | Must | SCRUM-29 |
| FR-11 | Ulasan yang dikirim dikembalikan ke halaman sebelumnya dan langsung muncul di daftar ulasan Detail dan Profil, disertai SnackBar | P05 pop + await + mounted, P03 SnackBar | Must | SCRUM-30 |
| FR-12 | Pengguna dapat menandai dan menghapus kos favorit, lalu melihatnya di tab Favorit | Tab tema | Must | SCRUM-31 |
| FR-13 | Tab Profil menampilkan ringkasan pengguna, jumlah favorit, dan daftar ulasan yang pernah ditulis | Tab tema | Must | SCRUM-32 |
| FR-14 | Aplikasi membaca alamat server dari `--dart-define=API_URL` | P07 http + dart-define | Must | SCRUM-19 |
| FR-15 | Ulasan dikirim ke server lewat `POST /ulasan`, dengan penanganan gagal kirim | Nilai tambah +5 | Could | SCRUM-42 |
| FR-16 | Pengguna dapat memuat ulang daftar dengan menarik layar ke bawah, termasuk saat daftar kosong atau gagal | Nilai tambah +2 | Could | SCRUM-40 |
| FR-17 | Gambar kos beranimasi Hero dari kartu ke halaman detail | Nilai tambah +3 | Could | SCRUM-41 |

### 5.2 Data yang dikelola

| Entitas | Atribut | Sumber | Disimpan di |
| --- | --- | --- | --- |
| Kos | id (String), nama, area, tipe (Putra/Putri/Campur), hargaBulanan (int), kamarMandiDalam (bool), jarakKm (double), diperbarui (DateTime) | Bagian 5 PDF | `server/data/kos.json`, minimal 12 item |
| Ulasan | kosId, namaKos, rating (int 1 sampai 5), komentar, tanggal (DateTime) | Keputusan A1 | Memori aplikasi (State), opsional server lewat POST |
| RingkasanArea | area, jumlahKos (int), hargaRataRata (int, dibulatkan) | Dihitung server | Respons `GET /area` |
| Favorit | kumpulan id kos | Aksi pengguna | Memori aplikasi (State) |

### 5.3 Antarmuka API

| Metode dan jalur | Respons berhasil | Respons gagal | Wajib |
| --- | --- | --- | --- |
| `GET /kos` | 200, array objek Kos | 500 bila data gagal dibaca | Ya |
| `GET /kos/<id>` | 200, satu objek Kos | 404, `{"pesan": "Kos tidak ditemukan"}` | Ya |
| `GET /area` | 200, array `{area, jumlahKos, hargaRataRata}` urut nama area | 500 | Ya (endpoint khas) |
| `POST /ulasan` | 201, objek ulasan tersimpan | 400 bila rating di luar 1 sampai 5 atau komentar kosong | Tidak (nilai tambah) |

Semua respons memakai `Content-Type: application/json`, dan tanggal dikirim dalam format ISO 8601.

## 6. Non-Functional Requirements

Sebagian besar kebutuhan non-fungsional KosDekat berasal langsung dari ketentuan UTS. Tiga di antaranya menentukan apakah nilai dipotong: analyze bersih (NFR-03), aplikasi bisa dijalankan dari README (NFR-02, NFR-09), dan orisinalitas (NFR-08).

| ID | Kategori | Kebutuhan | Ukuran lulus | Sumber |
| --- | --- | --- | --- | --- |
| NFR-01 | Identitas | Nama paket `id.ac.telkomuniversity.kosdekat` dan label launcher "KosDekat" | `applicationId` dan `android:label` sesuai | P01 sampai P02 |
| NFR-02 | Kompatibilitas | Aplikasi berjalan di emulator dan HP Android; server dapat dijangkau dari keduanya | Data tampil lewat `10.0.2.2`, IP LAN, dan `adb reverse`; server bind `anyIPv4`; HTTP cleartext diizinkan | P01 sampai P02, P07 |
| NFR-03 | Kualitas kode | Analisis statis bersih | `flutter analyze` menampilkan "No issues found!"; `dart analyze` server bersih | P01 sampai P02, pengurangan −10 |
| NFR-04 | Pengujian | Ada test otomatis yang lulus | Minimal 3 widget test dan 1 test MockClient; `flutter test` 100% lulus | P05, P07 |
| NFR-05 | Keterujian | Layanan HTTP dapat diganti tiruan | `http.Client` disuntikkan lewat konstruktor; test berjalan tanpa server | P07 MockClient |
| NFR-06 | Responsivitas | Pengguna selalu tahu status data | Indikator memuat langsung tampil; keadaan gagal muncul paling lama 8 detik setelah server tidak menjawab; filter dan urutan tidak memanggil server ulang | P07, rekomendasi |
| NFR-07 | Tampilan dan aksesibilitas | Tema Material 3 yang konsisten di mode terang dan gelap | `ColorScheme.fromSeed` + `darkTheme`; warna dari `colorScheme` dengan paling banyak 3 `Colors.xxx`; font kustom; ikon launcher sendiri; minimal 1 aset gambar; teks panjang tidak overflow; area sentuh tombol minimal 48 dp | P06, pedoman Material |
| NFR-08 | Orisinalitas | Nama kelas, model, halaman, data, dan endpoint khas KosDekat | Tidak ada nama atau teks dari Temuin; aset buatan sendiri atau berlisensi bebas | Bagian 1, pengurangan nilai 0 |
| NFR-09 | Dokumentasi | README lengkap dan dapat diikuti | Memuat anggota, cara menjalankan, minimal 4 tangkapan layar, tabel 28 butir dengan File:baris | Bagian 6, pengurangan −20 |
| NFR-10 | Demonstrasi | Video demo memperlihatkan alur wajib | Durasi 3 sampai 5 menit, memuat 7 adegan wajib Bagian 8 | Bagian 8 |
| NFR-11 | Kolaborasi | Riwayat kerja dapat ditelusuri | Setiap anggota punya commit; commit diawali key Jira; `main` hanya berubah lewat PR | Bagian 8 |
| NFR-12 | Etika data | Tidak menyesatkan dan tidak mengumpulkan data pribadi | Data kos fiktif dan ditandai sebagai contoh; aplikasi tidak meminta login maupun data pribadi | Rekomendasi |
| NFR-13 | Interoperabilitas | Format data konsisten antara server dan aplikasi | JSON dengan nama field yang sama; tanggal ISO 8601; `id` bertipe String | P07 fromJson/toJson |

## 7. User Stories

Ada 16 user story: 13 wajib dan 3 nilai tambah. Story US-01 sampai US-11 ditulis dari sudut pandang mahasiswa pencari kos, US-12 dan US-13 dari sudut pandang dosen dan tim, dan US-14 sampai US-16 adalah nilai tambah.

| ID | User story | FR terkait | Prioritas |
| --- | --- | --- | --- |
| US-01 | Sebagai mahasiswa pencari kos, saya ingin melihat daftar kos di sekitar kampus beserta harga, jarak, dan tipenya, agar saya punya gambaran pilihan dalam satu layar. | FR-01, FR-02, FR-09 | Must |
| US-02 | Sebagai mahasiswa, saya ingin diberi tahu saat data gagal dimuat dan bisa mencoba lagi, agar saya tidak bingung melihat layar kosong. | FR-01 | Must |
| US-03 | Sebagai mahasiswi, saya ingin hanya melihat kos Putri, agar saya tidak membuang waktu pada kos yang tidak bisa saya tempati. | FR-04 | Must |
| US-04 | Sebagai mahasiswa berbudget terbatas, saya ingin mengurutkan kos dari yang termurah atau terdekat, agar saya cepat menemukan pilihan yang paling sesuai. | FR-05 | Must |
| US-05 | Sebagai mahasiswa, saya ingin harga ditampilkan dalam format Rupiah per bulan, agar saya bisa membandingkan harga tanpa salah baca. | FR-06 | Must |
| US-06 | Sebagai mahasiswa yang baru mengenal daerah sekitar kampus, saya ingin melihat harga rata-rata tiap area, agar saya tahu area mana yang sesuai anggaran. | FR-07 | Must |
| US-07 | Sebagai mahasiswa, saya ingin membuka detail sebuah kos, termasuk fasilitas kamar mandi dan tanggal pembaruan informasinya, agar saya bisa menilai apakah informasinya masih bisa dipercaya. | FR-08 | Must |
| US-08 | Sebagai penghuni atau mantan penghuni kos, saya ingin memberi rating bintang dan komentar, agar pengalaman saya membantu mahasiswa lain. | FR-10 | Must |
| US-09 | Sebagai penulis ulasan, saya ingin ulasan saya langsung muncul setelah dikirim, agar saya yakin ulasan itu tersimpan. | FR-11 | Must |
| US-10 | Sebagai mahasiswa yang sedang membandingkan, saya ingin menandai kos sebagai favorit dan melihatnya di satu tab, agar kandidat saya tidak terlupa. | FR-12 | Must |
| US-11 | Sebagai pengguna, saya ingin melihat ulasan yang pernah saya tulis dan jumlah favorit di tab Profil, agar aktivitas saya mudah ditinjau. | FR-13 | Must |
| US-12 | Sebagai dosen penilai, saya ingin menjalankan server dan aplikasi hanya dengan perintah di README, agar saya bisa memeriksa setiap fitur tanpa bantuan tim. | FR-14, NFR-02, NFR-09 | Must |
| US-13 | Sebagai anggota tim, saya ingin menguji layanan API dan widget tanpa server sungguhan, agar test bisa dijalankan kapan saja dan hasilnya konsisten. | NFR-04, NFR-05 | Must |
| US-14 | Sebagai mahasiswa, saya ingin menarik daftar ke bawah untuk memuat ulang, agar saya mendapat data terbaru dengan gerakan yang biasa saya pakai. | FR-16 | Could |
| US-15 | Sebagai penulis ulasan, saya ingin ulasan saya tersimpan di server, agar ulasan itu tidak hilang saat aplikasi ditutup. | FR-15 | Could |
| US-16 | Sebagai mahasiswa, saya ingin perpindahan dari kartu ke detail terasa menyambung, agar saya tidak kehilangan konteks kos yang saya buka. | FR-17 | Could |

## 8. Acceptance Criteria

Sebuah story dianggap selesai bila semua kriterianya lulus dan buktinya bisa ditunjukkan lewat test otomatis, video demo, atau pemeriksaan langsung. Kriteria memakai format Given-When-Then.

| AC | Story | Given (kondisi) | When (aksi) | Then (hasil yang diharapkan) | Bukti |
| --- | --- | --- | --- | --- | --- |
| AC-01 | US-01 | Server menyala dengan minimal 12 kos | Aplikasi dibuka | Indikator memuat tampil, lalu daftar kartu kos tampil berisi nama, area, jarak, tipe, dan harga | Video adegan 3 |
| AC-02 | US-01 | Daftar tampil | Pengguna menggulir | Kartu dibangun dengan `ListView.builder` dan teks panjang tidak overflow | Pemeriksaan kode |
| AC-03 | US-02 | Server mati | Aplikasi memuat data | Paling lama 8 detik muncul pesan gagal dan tombol "Coba lagi" | Widget test, video adegan 5 |
| AC-04 | US-02 | Keadaan gagal tampil, server dinyalakan lagi | Pengguna mengetuk "Coba lagi" | Daftar kos tampil tanpa menutup aplikasi | Video adegan 5 |
| AC-05 | US-03 | Daftar berisi kos Putra, Putri, dan Campur | Pengguna memilih segmen "Putri" | Hanya kos Putri yang tampil, tanpa permintaan baru ke server | Widget test, log server |
| AC-06 | US-03 | Segmen "Putri" terpilih | Pengguna membatalkan pilihan atau memilih "Semua" | Semua kos tampil kembali | Pemeriksaan manual |
| AC-07 | US-04 | Daftar tampil | Pengguna memilih "Termurah" | Kartu pertama adalah kos dengan `hargaBulanan` terendah di antara hasil filter | Pemeriksaan manual |
| AC-08 | US-04 | Daftar tampil | Pengguna memilih "Terdekat" | Kartu pertama adalah kos dengan `jarakKm` terkecil; filter tipe tetap berlaku | Pemeriksaan manual |
| AC-09 | US-05 | Kos berharga 1250000 | Kartu atau detail ditampilkan | Harga tertulis persis "Rp1.250.000/bln" | Unit test format Rupiah |
| AC-10 | US-05 | Harga 950000, 1000, dan 500 | Fungsi format dipanggil | Hasilnya "Rp950.000/bln", "Rp1.000/bln", dan "Rp500/bln" | Unit test format Rupiah |
| AC-11 | US-06 | Server menyala | Tab Cari dibuka | Ringkasan tiap area tampil dengan jumlah kos dan harga rata-rata yang sama dengan respons `GET /area` | Bandingkan dengan `curl` |
| AC-12 | US-07 | Daftar tampil | Pengguna mengetuk sebuah kartu | Halaman detail terbuka dengan objek kos dari konstruktor dan menampilkan tipe, area, jarak, harga, kamar mandi dalam, serta "Diperbarui N hari lalu" | Pemeriksaan kode, video adegan 6 |
| AC-13 | US-08 | Form ulasan terbuka | Pengguna mengetuk bintang ke-4 | Empat bintang menyala dan rating bernilai 4 | Widget test |
| AC-14 | US-08 | Rating 0 atau komentar kosong | Pengguna mengetuk "Kirim Ulasan" | SnackBar validasi muncul dan form tetap terbuka | Widget test |
| AC-15 | US-08 | Form ulasan ditutup | Halaman dibuang dari memori | Semua `TextEditingController` di-dispose | Pemeriksaan kode |
| AC-16 | US-09 | Rating dan komentar terisi | Pengguna mengetuk "Kirim Ulasan" | Form tertutup lewat `Navigator.pop(context, ulasan)`, ulasan langsung tampil di Detail dan tab Profil, SnackBar "Ulasan tersimpan" muncul | Video adegan 7 |
| AC-17 | US-09 | Form terbuka | Pengguna menekan tombol kembali tanpa mengirim | Tidak ada ulasan baru dan tidak ada error | Pemeriksaan manual |
| AC-18 | US-09 | Detail menunggu hasil form | `await` selesai | `mounted` diperiksa sebelum `context` dipakai | Pemeriksaan kode |
| AC-19 | US-10 | Kos belum favorit | Pengguna mengetuk ikon hati | Ikon terisi, SnackBar muncul, kos tampil di tab Favorit | Video adegan 8 |
| AC-20 | US-10 | Belum ada favorit | Tab Favorit dibuka | Pesan kosong dan ilustrasi tampil | Pemeriksaan manual |
| AC-21 | US-11 | Pengguna sudah menulis ulasan | Tab Profil dibuka | Daftar "Ulasan Saya" dan jumlah favorit tampil sesuai data terbaru | Video adegan 8 |
| AC-22 | US-01, US-11 | Pengguna berada di tab Cari dan sudah menggulir | Pindah ke tab lain lalu kembali | Posisi gulir tetap dan server tidak dipanggil ulang | Log server |
| AC-23 | US-12 | Clone baru dari GitHub | Penguji mengikuti README langkah demi langkah | Server menyala dan aplikasi menampilkan data di emulator tanpa langkah tambahan | Tiket SCRUM-39 |
| AC-24 | US-12 | Aplikasi dijalankan dengan `--dart-define=API_URL=<alamat>` | Aplikasi memuat data | Permintaan dikirim ke alamat tersebut | Log server |
| AC-25 | US-13 | Tidak ada server menyala | `flutter test` dijalankan | Minimal 3 widget test dan 1 test MockClient lulus | Video adegan 10 |
| AC-26 | US-13 | Kode final di `main` | `flutter analyze` dijalankan | Hasil "No issues found!" | Terminal, GitHub Actions |
| AC-27 | US-14 | Daftar tampil atau dalam keadaan gagal | Pengguna menarik layar ke bawah | Indikator muncul dan data dimuat ulang | Video adegan 9 |
| AC-28 | US-15 | Server menyala | Ulasan valid dikirim | Server mencatat `POST /ulasan` dengan status 201 | Log server |
| AC-29 | US-15 | Server mati | Ulasan dikirim | Ulasan tetap tampil di aplikasi dan SnackBar memberi tahu bahwa pengiriman gagal | Pemeriksaan manual |
| AC-30 | US-16 | Kos yang sama tampil di tab Cari dan Favorit | Detail dibuka dari masing-masing tab | Animasi Hero berjalan tanpa error tag ganda | Pemeriksaan manual |

## 9. Scope dan Out of Scope

Versi UTS mencakup satu aplikasi Android dan satu server lokal dengan data contoh, dikerjakan 9 sampai 12 November 2026. Semua yang membutuhkan akun, data nyata, atau layanan pihak ketiga ditunda.

### 9.1 In scope (versi UTS)

**Aplikasi Android (Flutter)**

- Tab Cari: daftar kos, filter tipe, urutan harga atau jarak, ringkasan area, keadaan memuat, gagal, dan berhasil (FR-01 sampai FR-07)
- Halaman detail kos dan form ulasan berbintang (FR-08, FR-10, FR-11)
- Tab Favorit dan tab Profil (FR-12, FR-13)
- Tema terang dan gelap dari satu warna seed, font kustom, ikon launcher, aset gambar lokal (NFR-07)
- Alamat API lewat `--dart-define` (FR-14)

**Server (Dart shelf)**

- `GET /kos`, `GET /kos/<id>`, `GET /area` dari `kos.json` berisi minimal 12 kos fiktif di minimal 3 area (FR-09)

**Mutu dan dokumentasi**

- Minimal 3 widget test, 1 test MockClient, unit test format Rupiah (NFR-04)
- README dengan tabel 28 butir, minimal 4 tangkapan layar, video 3 sampai 5 menit, APK debug, zip repo (NFR-09, NFR-10)

**Nilai tambah, bila waktu cukup (Could)**

- Pull-to-refresh, animasi Hero, `POST /ulasan` (FR-15 sampai FR-17). Ketiganya baru dikerjakan setelah seluruh kebutuhan Must berjalan di `main`.

### 9.2 Out of scope

| Fitur | Alasan ditunda | Kemungkinan di masa depan |
| --- | --- | --- |
| Login, akun, dan autentikasi | Tidak diminta ketentuan; menambah risiko keamanan dan waktu | Diperlukan bila ulasan harus terhubung ke akun asli |
| Data kos nyata dan verifikasi pemilik | Butuh izin pemilik dan proses validasi; data karangan berisiko menyesatkan | Kemitraan dengan pemilik atau pengelola kos |
| Basis data permanen (mis. PostgreSQL) | Ketentuan cukup JSON dan memori | Menyimpan ulasan dan favorit secara permanen |
| Peta dan navigasi rute | Butuh API peta pihak ketiga dan kunci API | Menampilkan lokasi kos di peta |
| Pemesanan, pembayaran, dan chat dengan pemilik | Di luar tema dan berisiko hukum serta keamanan | Fitur transaksi setelah ada mitra |
| Unggah foto oleh pengguna | Butuh penyimpanan berkas dan moderasi | Galeri foto kamar |
| Notifikasi push | Butuh layanan pihak ketiga | Pemberitahuan kamar kosong |
| Versi iOS dan web | Ketentuan hanya Android | Bisa dibangun dari kode Flutter yang sama |
| Perbandingan kos berdampingan | Menambah lingkup UI tanpa bobot nilai | Fitur bandingkan 2 sampai 3 kos |
| Moderasi ulasan | Ulasan hanya tersimpan di perangkat atau server lokal | Diperlukan bila ulasan dipublikasikan |

## 10. Risiko, Asumsi, dan Pertanyaan Terbuka

Risiko terbesar adalah aplikasi tidak bisa menjangkau server di perangkat penguji, karena kesalahan ini langsung terkena pengurangan −20.

### 10.1 Risiko dan mitigasi

| Risiko | Dampak | Mitigasi | Pemilik |
| --- | --- | --- | --- |
| Aplikasi memakai `127.0.0.1` sehingga tidak menjangkau server laptop | −20 | Cantumkan varian `10.0.2.2`, IP LAN, dan `adb reverse` di README; server bind `anyIPv4`; uji dari clone baru | A1 |
| `flutter analyze` memunculkan peringatan API usang | −10 bila berupa error; poin P01 sampai P02 hilang bila warning | Analyze setiap PR lewat GitHub Actions; hindari API usang | A2 |
| Model `Kos` terlambat sehingga halaman tertahan | Jadwal mundur | Model dipush Senin siang; A3 dan A4 boleh memakai data dummy dulu | A2 |
| Font dari `google_fonts` menggagalkan widget test | Test gagal | Pakai file font di `assets/fonts` | A5 |
| Nilai tambah merusak fitur wajib | Nilai turun | Nilai tambah hanya setelah semua Must stabil di `main` | Ketua |
| Ada anggota tanpa commit | Dinilai terpisah | Setiap tiket berlabel PIC dan dipantau di Jira | Ketua |

### 10.2 Asumsi

- Penguji memakai emulator Android atau HP di jaringan yang sama dengan laptop server.
- Versi Flutter dan Dart setiap anggota sama. Versi persisnya dicatat di README setelah `flutter --version` dijalankan.
- Data contoh fiktif dianggap cukup untuk membuktikan fungsi, karena ketentuan tidak meminta data nyata.

### 10.3 Pertanyaan terbuka

- [ ] Warna seed dan token desain dari referensi Dribbble belum ditetapkan tim.
- [ ] File rangkuman materi P03 sampai P07 belum diterima, sehingga pola kode belum dicocokkan.
- [ ] Nama, NIM, dan pembagian peran A1 sampai A5 belum diisi di README.
- [ ] Bila proyek dilanjutkan setelah UTS, perlu survei singkat ke mahasiswa tingkat 2 ke atas untuk memvalidasi masalah M1 sampai M7.

### 10.4 Sumber

- Dokumen UTS P08 Pengembangan Aplikasi Bergerak: Proyek Tengah Semester, Bagian 1 sampai 8.
- [Telkom University: alamat kampus](https://telkomuniversity.ac.id/visit)
- [Gramedia: profil Universitas Telkom, keterangan asrama tahun pertama](https://www.gramedia.com/pendidikan/universitas/universitas-telkom)
- [Buku Wisuda Telkom University Periode II dan III 2019/2020: jumlah mahasiswa](https://wisudawan.telkomuniversity.ac.id/wp-content/uploads/2024/08/wisuda-per-II-III-REVISI.pdf)
- [BTP Telkom University: usulan aplikasi Tekos](https://btp.telkomuniversity.ac.id/landing/ip/HCAP2908232801)
