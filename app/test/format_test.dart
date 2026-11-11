import 'package:flutter_test/flutter_test.dart';
import 'package:kosdekat/utils/format.dart';

void main() {
  test('format harga dalam Rupiah per bulan', () {
    expect(formatRupiah(1250000), 'Rp1.250.000/bln');
  });
}
