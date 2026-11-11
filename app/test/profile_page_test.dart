import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kosdekat/screens/profile_page.dart';

void main() {
  testWidgets('ProfilePage menampilkan identitas KosDekat', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ProfilePage())));
    expect(find.text('Mahasiswa Telkom University'), findsOneWidget);
    expect(find.text('Tentang KosDekat'), findsOneWidget);
  });
}
