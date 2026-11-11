import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kosdekat/models/kos.dart';
import 'package:kosdekat/widgets/kos_card.dart';

void main() {
  testWidgets('KosCard menampilkan nama, area, dan harga', (tester) async {
    final kos = Kos(
        id: '1',
        nama: 'Kos Uji',
        area: 'Sukapura',
        tipe: 'Putra',
        hargaBulanan: 1250000,
        kamarMandiDalam: true,
        jarakKm: 1.2,
        diperbarui: DateTime(2026, 11, 8));
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body:
          KosCard(kos: kos, isFavorite: false, onFavorite: () {}, onTap: () {}),
    )));
    expect(find.text('Kos Uji'), findsOneWidget);
    expect(find.text('Sukapura'), findsOneWidget);
    expect(find.text('Rp1.250.000/bln'), findsOneWidget);
  });
}
