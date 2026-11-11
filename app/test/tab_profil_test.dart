import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kosdekat/halaman/halaman_utama.dart';
import 'package:kosdekat/halaman/tab_profil.dart';
import 'package:kosdekat/model/ulasan.dart';
import 'package:kosdekat/service/kos_service.dart';
import 'package:kosdekat/tema/tema_kosdekat.dart';

void main() {
  final ulasan1 = Ulasan(
    kosId: 'kos-1',
    namaKos: 'Kos Melati Indah',
    rating: 5,
    komentar: 'Kamar mandi bersih dan luas, ibu kos ramah.',
    tanggal: DateTime(2026, 11, 10),
  );

  final ulasan2 = Ulasan(
    kosId: 'kos-2',
    namaKos: 'Pondok Asri',
    rating: 4,
    komentar: 'Dekat dengan kampus, internet kencang.',
    tanggal: DateTime(2026, 11, 11),
  );

  group('TabProfil unit test', () {
    testWidgets(
        'menampilkan identitas, ringkasan dan empty state jika belum ada ulasan',
        (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TabProfil(
              namaPengguna: 'Budi Santoso',
              emailPengguna: 'budi@student.telkomuniversity.ac.id',
              jumlahFavorit: 3,
              daftarUlasan: [],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Avatar inisial
      expect(find.text('BS'), findsOneWidget);
      // Nama dan Email
      expect(find.text('Budi Santoso'), findsOneWidget);
      expect(
        find.text('budi@student.telkomuniversity.ac.id'),
        findsOneWidget,
      );

      // Ringkasan
      expect(find.text('3'), findsOneWidget);
      expect(find.text('Favorit'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.text('Ulasan'), findsOneWidget);

      // Empty state ulasan
      expect(
        find.text('Belum ada ulasan. Buka detail kos lalu tulis ulasan.'),
        findsOneWidget,
      );

      // Info tentang aplikasi
      expect(find.text('Tentang aplikasi'), findsOneWidget);
      expect(find.text('Kelompok 06 · Proyek UTS PAB'), findsOneWidget);
    });

    testWidgets(
        'menampilkan daftar ulasan saya (nama kos, bintang, komentar, tanggal)',
        (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabProfil(
              namaPengguna: 'Budi Santoso',
              emailPengguna: 'budi@student.telkomuniversity.ac.id',
              jumlahFavorit: 2,
              daftarUlasan: [ulasan1, ulasan2],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Ringkasan ulasan
      expect(find.text('Ulasan Saya (2)'), findsOneWidget);

      // Ulasan 1
      expect(find.text('Kos Melati Indah'), findsOneWidget);
      expect(
        find.text('Kamar mandi bersih dan luas, ibu kos ramah.'),
        findsOneWidget,
      );
      expect(find.text('10/11/2026'), findsOneWidget);

      // Ulasan 2
      expect(find.text('Pondok Asri'), findsOneWidget);
      expect(
        find.text('Dekat dengan kampus, internet kencang.'),
        findsOneWidget,
      );
      expect(find.text('11/11/2026'), findsOneWidget);

      // Tidak ada empty state
      expect(
        find.text('Belum ada ulasan. Buka detail kos lalu tulis ulasan.'),
        findsNothing,
      );
    });

    testWidgets('switch mode gelap mengubah themeModeNotifier', (tester) async {
      themeModeNotifier.value = ThemeMode.light;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TabProfil(
              namaPengguna: 'Budi',
              emailPengguna: 'budi@student.telkomuniversity.ac.id',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      expect(themeModeNotifier.value, ThemeMode.dark);
    });
  });

  group('HalamanUtama integrasi TabProfil (P05 data langsung muncul)', () {
    testWidgets('ulasan baru langsung tampil di Tab Profil', (tester) async {
      final client = MockClient((request) async {
        return http.Response(jsonEncode([]), 200);
      });
      final service =
          KosService(client: client, baseUrl: 'http://localhost:8080');

      await tester.pumpWidget(
        MaterialApp(
          home: HalamanUtama(
            kosService: service,
            namaPengguna: 'Siti Aminah',
            emailPengguna: 'siti@student.telkomuniversity.ac.id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Pindah ke tab Profil
      await tester.tap(find.text('Profil'));
      await tester.pumpAndSettle();

      // Awalnya empty state
      expect(
        find.text('Belum ada ulasan. Buka detail kos lalu tulis ulasan.'),
        findsOneWidget,
      );
      expect(find.text('Ulasan Saya (0)'), findsOneWidget);

      // Simulasikan ulasan baru masuk lewat HalamanUtama (tambahUlasan)
      final state = tester.state<HalamanUtamaState>(find.byType(HalamanUtama));
      state.tambahUlasan(ulasan1);
      await tester.pumpAndSettle();

      // Langsung muncul di Tab Profil tanpa reload halaman
      expect(
        find.text('Belum ada ulasan. Buka detail kos lalu tulis ulasan.'),
        findsNothing,
      );
      expect(find.text('Ulasan Saya (1)'), findsOneWidget);
      expect(find.text('Kos Melati Indah'), findsOneWidget);
      expect(
        find.text('Kamar mandi bersih dan luas, ibu kos ramah.'),
        findsOneWidget,
      );
      expect(find.text('10/11/2026'), findsOneWidget);
    });
  });
}
