import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kosdekat/halaman/halaman_form_ulasan.dart';
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

  Widget buatHalaman() => MaterialApp(home: HalamanFormUlasan(kos: kosContoh));

  testWidgets('nama kos otomatis terisi dan readOnly', (tester) async {
    await tester.pumpWidget(buatHalaman());
    expect(find.text('Kos Melati Indah (contoh)'), findsOneWidget);
  });

  testWidgets('mengetuk bintang ke-4 menyalakan 4 bintang', (tester) async {
    await tester.pumpWidget(buatHalaman());

    // Ketuk bintang ke-4 (tooltip "Rating 4 bintang")
    await tester.tap(find.byTooltip('Rating 4 bintang'));
    await tester.pump();

    // Harus ada 4 ikon star (menyala) dan 1 ikon star_border (mati)
    expect(find.byIcon(Icons.star), findsNWidgets(4));
    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });

  testWidgets('kirim tanpa rating menampilkan SnackBar', (tester) async {
    await tester.pumpWidget(buatHalaman());

    // Isi komentar tapi jangan beri rating
    await tester.enterText(find.byType(TextField).last, 'Bagus sekali');
    await tester.tap(find.text('Kirim Ulasan'));
    await tester.pump();

    expect(find.text('Beri bintang dan komentar dulu'), findsOneWidget);
  });

  testWidgets('kirim tanpa komentar menampilkan SnackBar', (tester) async {
    await tester.pumpWidget(buatHalaman());

    // Beri rating tapi jangan isi komentar
    await tester.tap(find.byTooltip('Rating 3 bintang'));
    await tester.pump();
    await tester.tap(find.text('Kirim Ulasan'));
    await tester.pump();

    expect(find.text('Beri bintang dan komentar dulu'), findsOneWidget);
  });

  testWidgets('kirim valid menutup halaman dengan objek Ulasan', (
    tester,
  ) async {
    Ulasan? hasilPop;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (ctx) => ElevatedButton(
            onPressed: () async {
              hasilPop = await Navigator.push<Ulasan>(
                ctx,
                MaterialPageRoute(
                  builder: (_) => HalamanFormUlasan(kos: kosContoh),
                ),
              );
            },
            child: const Text('Buka Form'),
          ),
        ),
      ),
    );

    // Buka halaman form
    await tester.tap(find.text('Buka Form'));
    await tester.pumpAndSettle();

    // Beri rating 5
    await tester.tap(find.byTooltip('Rating 5 bintang'));
    await tester.pump();

    // Isi komentar
    await tester.enterText(
      find.byType(TextField).last,
      'Lokasi strategis, kamar bersih',
    );

    // Kirim
    await tester.tap(find.text('Kirim Ulasan'));
    await tester.pumpAndSettle();

    // Halaman sudah tertutup dan hasilPop berisi Ulasan yang benar
    expect(hasilPop, isNotNull);
    expect(hasilPop!.kosId, 'k-01');
    expect(hasilPop!.namaKos, 'Kos Melati Indah (contoh)');
    expect(hasilPop!.rating, 5);
    expect(hasilPop!.komentar, 'Lokasi strategis, kamar bersih');
  });
}
