import 'package:flutter_test/flutter_test.dart';
import 'package:kosdekat/models/kos.dart';

void main() {
  test('Kos dapat dikonversi dari dan ke JSON', () {
    final source = {
      'id': 'k01', 'nama': 'Kos Uji', 'area': 'Sukapura',
      'tipe': 'Putra', 'hargaBulanan': 1000000,
      'kamarMandiDalam': true, 'jarakKm': 1.25,
      'diperbarui': '2026-11-08T09:00:00.000Z'
    };
    final kos = Kos.fromJson(source);
    expect(kos.kamarMandiDalam, isTrue);
    expect(kos.jarakKm, 1.25);
    expect(kos.toJson()['id'], 'k01');
  });
}
