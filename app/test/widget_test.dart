import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kosdekat/main.dart';

void main() {
  for (final terang in [true, false]) {
    testWidgets('KosDekatApp tampil di tema ${terang ? 'terang' : 'gelap'}', (
      tester,
    ) async {
      tester.platformDispatcher.platformBrightnessTestValue = terang
          ? Brightness.light
          : Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

      await tester.pumpWidget(const KosDekatApp());

      expect(find.text('Masuk ke KosDekat'), findsOneWidget);
      final konteks = tester.element(find.text('Masuk ke KosDekat'));
      expect(
        Theme.of(konteks).brightness,
        terang ? Brightness.light : Brightness.dark,
      );
    });
  }
}
