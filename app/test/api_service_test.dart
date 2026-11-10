import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kosdekat/models/ulasan.dart';
import 'package:kosdekat/services/api_service.dart';

void main() {
  test('ApiService membaca daftar kos dari MockClient', () async {
    final mock = MockClient((request) async {
      expect(request.url.path, '/kos');
      return http.Response(jsonEncode([{
        'id': 'k01', 'nama': 'Kos Mock', 'area': 'Sukapura',
        'tipe': 'Putra', 'hargaBulanan': 1000000,
        'kamarMandiDalam': true, 'jarakKm': 1.0,
        'diperbarui': '2026-11-08T09:00:00.000Z'
      }]), 200, headers: {'content-type': 'application/json'});
    });
    final service = ApiService(client: mock, baseUrl: 'http://localhost:8080');
    final result = await service.getKos();
    expect(result, hasLength(1));
    expect(result.first.nama, 'Kos Mock');
    service.dispose();
  });

  test('ApiService kirimUlasan POST berhasil (201)', () async {
    final ulasanInput = Ulasan(
      kosId: 'k01',
      namaKos: 'Kos Mock',
      rating: 5,
      komentar: 'Bersih dan nyaman',
      tanggal: DateTime(2026, 11, 11, 10),
    );

    final mock = MockClient((request) async {
      expect(request.method, 'POST');
      expect(request.url.path, '/ulasan');
      expect(request.headers['Content-Type'], contains('application/json'));

      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['kosId'], 'k01');
      expect(body['rating'], 5);

      return http.Response(
        jsonEncode({
          'id': 'u1',
          'kosId': 'k01',
          'namaKos': 'Kos Mock',
          'rating': 5,
          'komentar': 'Bersih dan nyaman',
          'tanggal': '2026-11-11T10:00:00.000',
        }),
        201,
        headers: {'content-type': 'application/json'},
      );
    });

    final service = ApiService(client: mock, baseUrl: 'http://localhost:8080');
    final result = await service.kirimUlasan(ulasanInput);
    expect(result.kosId, 'k01');
    expect(result.rating, 5);
    service.dispose();
  });

  test('ApiService kirimUlasan lempar Exception jika bukan 201', () async {
    final ulasanInput = Ulasan(
      kosId: '',
      namaKos: '',
      rating: 0,
      komentar: '',
      tanggal: DateTime.now(),
    );
    final mock = MockClient((_) async => http.Response(
        jsonEncode({'message': 'Field rating harus angka 1–5'}), 400,
        headers: {'content-type': 'application/json'}));

    final service = ApiService(client: mock, baseUrl: 'http://localhost:8080');
    expect(() => service.kirimUlasan(ulasanInput), throwsException);
    service.dispose();
  });
}
