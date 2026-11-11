import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kosdekat/services/api_service.dart';

void main() {
  test('ApiService membaca daftar kos dari MockClient', () async {
    final mock = MockClient((request) async {
      expect(request.url.path, '/kos');
      return http.Response(
        jsonEncode([
          {
            'id': 'k01',
            'nama': 'Kos Mock',
            'area': 'Sukapura',
            'tipe': 'Putra',
            'hargaBulanan': 1000000,
            'kamarMandiDalam': true,
            'jarakKm': 1.0,
            'diperbarui': '2026-11-08T09:00:00.000Z',
          },
        ]),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    final service = ApiService(client: mock, baseUrl: 'http://localhost:8080');
    final result = await service.getKos();
    expect(result, hasLength(1));
    expect(result.first.nama, 'Kos Mock');
    service.dispose();
  });
}
