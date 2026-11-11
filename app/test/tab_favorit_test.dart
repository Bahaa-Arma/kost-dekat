import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kosdekat/halaman/halaman_utama.dart';
import 'package:kosdekat/halaman/tab_favorit.dart';
import 'package:kosdekat/model/kos.dart';
import 'package:kosdekat/pages/detail_kos_page.dart';
import 'package:kosdekat/service/kos_service.dart';

void main() {
  final kos1 = Kos(
    id: '1',
    nama: 'Kos Melati Indah',
    area: 'Sukapura',
    tipe: 'Putri',
    hargaBulanan: 1200000,
    kamarMandiDalam: true,
    jarakKm: 0.8,
    diperbarui: DateTime(2026, 11, 10),
  );

  final kos2 = Kos(
    id: '2',
    nama: 'Pondok Asri',
    area: 'Dayeuhkolot',
    tipe: 'Putra',
    hargaBulanan: 900000,
    kamarMandiDalam: false,
    jarakKm: 1.2,
    diperbarui: DateTime(2026, 11, 10),
  );

  group('TabFavorit unit widget test', () {
    testWidgets('menampilkan empty state bila belum ada kos favorit', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabFavorit(
              futureKos: Future.value([kos1, kos2]),
              idFavorit: const {},
              onToggleFavorit: (_) {},
              onTapKos: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Belum ada kos favorit. Ketuk ikon hati di tab Cari.'),
        findsOneWidget,
      );
      expect(find.text('Kos Melati Indah'), findsNothing);
    });

    testWidgets('hanya menampilkan kos yang ada di idFavorit', (tester) async {
      String? toggledId;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TabFavorit(
              futureKos: Future.value([kos1, kos2]),
              idFavorit: const {'1'},
              onToggleFavorit: (id) => toggledId = id,
              onTapKos: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Kos Melati Indah'), findsOneWidget);
      expect(find.text('Pondok Asri'), findsNothing);

      // Tap favorite icon on Kos Melati Indah
      await tester.tap(find.byTooltip('Hapus dari Favorit'));
      await tester.pump();
      expect(toggledId, '1');
    });
  });

  group('HalamanUtama integrasi Tab Favorit dan Tab Cari', () {
    late KosService mockService;
    int hitCount = 0;

    setUp(() {
      hitCount = 0;
      final client = MockClient((request) async {
        hitCount++;
        final listData = [
          {
            'id': '1',
            'nama': 'Kos Melati Indah',
            'area': 'Sukapura',
            'tipe': 'Putri',
            'hargaBulanan': 1200000,
            'kamarMandiDalam': true,
            'jarakKm': 0.8,
            'diperbarui': '2026-11-10T12:00:00Z',
          },
          {
            'id': '2',
            'nama': 'Pondok Asri',
            'area': 'Dayeuhkolot',
            'tipe': 'Putra',
            'hargaBulanan': 900000,
            'kamarMandiDalam': false,
            'jarakKm': 1.2,
            'diperbarui': '2026-11-10T12:00:00Z',
          },
        ];
        return http.Response(jsonEncode(listData), 200);
      });
      mockService = KosService(client: client, baseUrl: 'http://test:8080');
    });

    testWidgets(
      'toggle favorit di Tab Cari memunculkan SnackBar dan kos tampil di Tab Favorit tanpa re-fetch server',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(home: HalamanUtama(kosService: mockService)),
        );
        await tester.pumpAndSettle();

        // Server harus dipanggil 1 kali saat inisialisasi
        expect(hitCount, 1);
        expect(find.text('Kos Melati Indah'), findsOneWidget);

        // Pindah ke tab Favorit
        await tester.tap(find.text('Favorit'));
        await tester.pumpAndSettle();

        // Tab Favorit awalnya kosong
        expect(
          find.text('Belum ada kos favorit. Ketuk ikon hati di tab Cari.'),
          findsOneWidget,
        );

        // Server tidak dipanggil ulang saat pindah tab
        expect(hitCount, 1);

        // Kembali ke tab Cari
        await tester.tap(find.text('Cari'));
        await tester.pumpAndSettle();

        // Ketuk tombol favorit pada item pertama
        final favoriteButtons = find.byTooltip('Tambah ke Favorit');
        expect(favoriteButtons, findsWidgets);
        await tester.tap(favoriteButtons.first);
        await tester.pump();

        // SnackBar muncul
        expect(find.text('Ditambahkan ke Favorit'), findsOneWidget);
        await tester.pump(const Duration(seconds: 4));
        await tester.pumpAndSettle();

        // Pindah ke tab Favorit lagi
        await tester.tap(find.text('Favorit'));
        await tester.pumpAndSettle();

        // Sekarang Kos Melati Indah muncul di tab Favorit
        expect(find.text('Kos Melati Indah'), findsOneWidget);
        expect(
          find.text('Belum ada kos favorit. Ketuk ikon hati di tab Cari.'),
          findsNothing,
        );

        // Tekan hapus favorit di tab Favorit
        final tombolHapusFavorit = find.descendant(
          of: find.byType(TabFavorit),
          matching: find.byTooltip('Hapus dari Favorit'),
        );
        expect(tombolHapusFavorit, findsOneWidget);
        await tester.tap(tombolHapusFavorit);
        await tester.pumpAndSettle();

        // SnackBar muncul
        expect(find.text('Dihapus dari Favorit'), findsOneWidget);
        await tester.pumpAndSettle();

        // Tab Favorit kembali kosong
        expect(
          find.text('Belum ada kos favorit. Ketuk ikon hati di tab Cari.'),
          findsOneWidget,
        );

        // Server tetap hanya dipanggil 1 kali selama navigasi
        expect(hitCount, 1);
      },
    );

    testWidgets(
      'tombol favorit di AppBar DetailKosPage memicu toggle favorit',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(home: HalamanUtama(kosService: mockService)),
        );
        await tester.pumpAndSettle();

        // Buka detail kos pertama
        await tester.tap(find.text('Kos Melati Indah'));
        await tester.pumpAndSettle();

        // Pastikan berada di DetailKosPage
        expect(find.byType(DetailKosPage), findsOneWidget);

        // Tekan tombol favorit di AppBar Detail
        final tombolFavoritDetail = find.byTooltip('Tambah ke Favorit');
        expect(tombolFavoritDetail, findsOneWidget);
        await tester.tap(tombolFavoritDetail);
        await tester.pumpAndSettle();

        // SnackBar muncul
        expect(find.text('Ditambahkan ke Favorit'), findsOneWidget);

        // Kembali ke HalamanUtama
        final NavigatorState navigator = tester.state(
          find.byType(Navigator).last,
        );
        navigator.pop();
        await tester.pumpAndSettle();

        // Pindah ke tab Favorit
        await tester.tap(find.text('Favorit'));
        await tester.pumpAndSettle();

        // Kos Melati Indah muncul di tab Favorit
        expect(find.text('Kos Melati Indah'), findsOneWidget);
      },
    );
  });
}
