import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kosdekat/tema/tema_kosdekat.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Tema KosDekat Test', () {
    test('Konfigurasi warnaSeed sesuai referensi Papa Kost', () {
      expect(warnaSeed, const Color(0xFF14695C));
    });

    testWidgets(
        'temaTerang memiliki ColorScheme light dan konfigurasi komponen',
        (tester) async {
      expect(temaTerang.colorScheme.brightness, Brightness.light);
      expect(temaTerang.useMaterial3, isTrue);

      final cardShape = temaTerang.cardTheme.shape;
      expect(cardShape, isA<RoundedRectangleBorder>());
      expect(
        (cardShape as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(16),
      );

      final buttonShape =
          temaTerang.filledButtonTheme.style?.shape?.resolve({});
      expect(buttonShape, isA<RoundedRectangleBorder>());
      expect(
        (buttonShape as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(14),
      );

      final navIndicator = temaTerang.navigationBarTheme.indicatorShape;
      expect(navIndicator, isA<RoundedRectangleBorder>());
    });

    testWidgets('temaGelap memiliki ColorScheme dark dan konfigurasi komponen',
        (tester) async {
      expect(temaGelap.colorScheme.brightness, Brightness.dark);
      expect(temaGelap.useMaterial3, isTrue);

      final cardShape = temaGelap.cardTheme.shape;
      expect(cardShape, isA<RoundedRectangleBorder>());
      expect(
        (cardShape as RoundedRectangleBorder).borderRadius,
        BorderRadius.circular(16),
      );

      final buttonShape = temaGelap.filledButtonTheme.style?.shape?.resolve({});
      expect(buttonShape, isA<RoundedRectangleBorder>());

      final navIndicator = temaGelap.navigationBarTheme.indicatorShape;
      expect(navIndicator, isA<RoundedRectangleBorder>());
    });

    testWidgets(
        'Komponen tombol dan kartu dapat dirender dalam mode terang dan gelap',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: temaTerang,
        darkTheme: temaGelap,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: Column(
            children: [
              const Card(child: Text('Kartu Mode Gelap')),
              FilledButton(
                onPressed: () {},
                child: const Text('Tombol Mode Gelap'),
              ),
            ],
          ),
        ),
      ));

      expect(find.text('Kartu Mode Gelap'), findsOneWidget);
      expect(find.text('Tombol Mode Gelap'), findsOneWidget);
    });
  });
}
