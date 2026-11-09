import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kosdekat/halaman/halaman_login.dart';

void main() {
  String? namaDiterima;
  String? emailDiterima;

  Future<void> bukaLogin(WidgetTester tester) => tester.pumpWidget(
    MaterialApp(
      home: HalamanLogin(
        bukaHalamanUtama: (nama, email) {
          namaDiterima = nama;
          emailDiterima = email;
          return const Scaffold(body: Text('Halaman utama'));
        },
      ),
    ),
  );

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
    expect(find.text('Halaman utama'), findsNothing);
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

  testWidgets('data valid masuk ke halaman utama dan back tidak kembali', (
    tester,
  ) async {
    await bukaLogin(tester);
    await isi(
      tester,
      '  Budi Santoso ',
      'Budi@Student.TelkomUniversity.ac.id',
      'rahasia1',
    );

    expect(find.text('Halaman utama'), findsOneWidget);
    expect(namaDiterima, 'Budi Santoso');
    expect(emailDiterima, 'budi@student.telkomuniversity.ac.id');
    expect(
      Navigator.of(tester.element(find.text('Halaman utama'))).canPop(),
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
