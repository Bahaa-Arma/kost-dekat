import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kosdekat/screens/add_review_page.dart';

void main() {
  testWidgets('Form ulasan menampilkan pilihan kos dan rating', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AddReviewPage(kosNames: ['Kos Sukapura', 'Kos Sukabirus']),
    ));
    expect(find.text('Tambah ulasan'), findsOneWidget);
    expect(find.text('Rating kos'), findsOneWidget);
    expect(find.text('Kirim ulasan'), findsOneWidget);
  });
}
