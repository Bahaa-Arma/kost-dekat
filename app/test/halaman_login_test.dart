import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kosdekat/halaman/halaman_login.dart';
import 'package:kosdekat/halaman/halaman_utama.dart';

void main() {
  Future<void> bukaLogin(WidgetTester tester) =>
      tester.pumpWidget(const MaterialApp(home: HalamanLogin()));

  Future<void> isi(
    WidgetTester tester,
    String nama,
    String email,
    String sandi,
  ) async {
    await tester.enterText(find.widgetWithText(TextFormField, 'Nama'), nama);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email kampus'),
      email,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Kata sandi'),
      sandi,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Masuk'));
    await tester.pumpAndSettle();
  }

  testWidgets('email bukan email kampus ditolak dan halaman tidak pindah', (
    tester,
  ) async {
    await bukaLogin(tester);
    await isi(tester, 'Budi', 'budi@gmail.com', 'rahasia1');

    expect(
      find.text('Pakai email @student.telkomuniversity.ac.id'),
      findsOneWidget,
    );
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('nama pendek, email kosong, sandi pendek ditolak', (
    tester,
  ) async {
    await bukaLogin(tester);
    await isi(tester, 'Bu', '', '123');

    expect(find.text('Nama minimal 3 karakter'), findsOneWidget);
    expect(find.text('Email kampus wajib diisi'), findsOneWidget);
    expect(find.text('Kata sandi minimal 6 karakter'), findsOneWidget);
  });

  testWidgets('data valid masuk, back tidak kembali, nama tampil di Profil', (
    tester,
  ) async {
    await bukaLogin(tester);
    await isi(
      tester,
      '  Budi Santoso ',
      'Budi@Student.TelkomUniversity.ac.id',
      'rahasia1',
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(NavigationBar))).canPop(),
      isFalse,
    );

    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('budi@student.telkomuniversity.ac.id'), findsOneWidget);
    expect(find.text('BS'), findsOneWidget);
  });

  testWidgets('Keluar: Batal tetap di Profil, Keluar kembali ke login', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HalamanUtama()));
    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    expect(find.text('Mahasiswa Tel-U'), findsOneWidget);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Keluar'));
    await tester.pumpAndSettle();
    expect(find.text('Keluar dari KosDekat?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Batal'));
    await tester.pumpAndSettle();
    expect(find.text('Mahasiswa Tel-U'), findsOneWidget);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Keluar'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Keluar'));
    await tester.pumpAndSettle();
    expect(find.text('Masuk ke KosDekat'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(
      Navigator.of(tester.element(find.text('Masuk ke KosDekat'))).canPop(),
      isFalse,
    );
  });

  testWidgets('tombol mata menampilkan dan menyembunyikan kata sandi', (
    tester,
  ) async {
    await bukaLogin(tester);
    bool tersembunyi() => tester
        .widget<EditableText>(
          find.descendant(
            of: find.widgetWithText(TextFormField, 'Kata sandi'),
            matching: find.byType(EditableText),
          ),
        )
        .obscureText;

    expect(tersembunyi(), isTrue);
    await tester.tap(find.byTooltip('Tampilkan kata sandi'));
    await tester.pump();
    expect(tersembunyi(), isFalse);
    expect(find.byTooltip('Sembunyikan kata sandi'), findsOneWidget);
  });
}
