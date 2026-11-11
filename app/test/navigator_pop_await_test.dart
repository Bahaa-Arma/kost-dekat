import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kosdekat/halaman/halaman_detail_kos.dart';
import 'package:kosdekat/model/kos.dart';
import 'package:kosdekat/model/ulasan.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  final kosContoh = Kos(
    id: 'k-01',
    nama: 'Kos Melati Indah (contoh)',
    area: 'Sukapura',
    tipe: 'Putri',
    hargaBulanan: 1250000,
    kamarMandiDalam: true,
    jarakKm: 0.8,
    diperbarui: DateTime(2026, 10, 28),
  );

  final ulasanAwal = [
    Ulasan(
      kosId: 'k-01',
      namaKos: 'Kos Melati Indah (contoh)',
      rating: 4,
      komentar: 'Nyaman dan bersih',
      tanggal: DateTime(2026, 10, 1),
    ),
  ];

  testWidgets('halaman detail menampilkan ulasan awal', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HalamanDetailKos(
          kos: kosContoh,
          ulasanAwal: ulasanAwal,
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Ulasan (1)'), findsOneWidget);
    expect(find.text('Nyaman dan bersih'), findsOneWidget);
  });

  testWidgets(
    'tekan back di form tanpa isi tidak menambah ulasan dan tidak error',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HalamanDetailKos(
            kos: kosContoh,
            ulasanAwal: ulasanAwal,
          ),
        ),
      );
      await tester.pump();

      // Buka form ulasan via FAB
      await tester.tap(find.text('Tulis Ulasan'));
      await tester.pumpAndSettle();

      // Pastikan form terbuka
      expect(find.text('Nama kos'), findsOneWidget);

      // Tekan back tanpa isi
      final NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();

      // Kembali ke detail, jumlah ulasan tidak berubah
      expect(find.text('Ulasan (1)'), findsOneWidget);
      // Tidak ada SnackBar
      expect(find.text('Ulasan tersimpan'), findsNothing);
    },
  );

  testWidgets(
    'ulasan baru langsung muncul di daftar dan SnackBar tampil (P05 + P03)',
    (tester) async {
      Ulasan? ulasanDiterima;

      await tester.pumpWidget(
        MaterialApp(
          home: HalamanDetailKos(
            kos: kosContoh,
            ulasanAwal: const [],
            onUlasanBaru: (u) => ulasanDiterima = u,
          ),
        ),
      );
      await tester.pump();

      // Awalnya tidak ada ulasan
      expect(find.text('Ulasan (0)'), findsOneWidget);

      // Buka form ulasan
      await tester.tap(find.text('Tulis Ulasan'));
      await tester.pumpAndSettle();

      // Beri rating 5
      await tester.tap(find.byTooltip('Rating 5 bintang'));
      await tester.pump();

      // Isi komentar
      await tester.enterText(
        find.byType(TextField).last,
        'Lokasi bagus dan harga terjangkau',
      );

      // Kirim
      await tester.tap(find.text('Kirim Ulasan'));
      await tester.pumpAndSettle();

      // Kembali ke halaman detail — ulasan baru langsung muncul
      expect(find.text('Ulasan (1)'), findsOneWidget);
      expect(find.text('Lokasi bagus dan harga terjangkau'), findsOneWidget);

      // SnackBar "Ulasan tersimpan" muncul (P03)
      expect(find.text('Ulasan tersimpan'), findsOneWidget);

      // callback onUlasanBaru dipanggil dengan data yang benar (P05)
      expect(ulasanDiterima, isNotNull);
      expect(ulasanDiterima!.kosId, 'k-01');
      expect(ulasanDiterima!.rating, 5);
      expect(ulasanDiterima!.komentar, 'Lokasi bagus dan harga terjangkau');
    },
  );
}
