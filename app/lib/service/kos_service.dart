import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/kos.dart';
import '../model/ulasan.dart';

class KosService {
  KosService({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      baseUrl =
          baseUrl ??
          const String.fromEnvironment(
            'API_URL',
            defaultValue: 'http://10.0.2.2:8080',
          );

  final http.Client _client;
  final String baseUrl;

  Future<List<Kos>> ambilDaftarKos() async {
    final response = await _client
        .get(Uri.parse('$baseUrl/kos'))
        .timeout(const Duration(seconds: 8));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat kos: status ${response.statusCode}');
    }
    final List<dynamic> listJson = jsonDecode(response.body) as List<dynamic>;
    return listJson
        .map((e) => Kos.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Kos> ambilKos(String id) async {
    final response = await _client
        .get(Uri.parse('$baseUrl/kos/$id'))
        .timeout(const Duration(seconds: 8));
    if (response.statusCode != 200) {
      throw Exception(
        'Gagal memuat detail kos $id: status ${response.statusCode}',
      );
    }
    return Kos.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<Map<String, dynamic>>> ambilRingkasanArea() async {
    final response = await _client
        .get(Uri.parse('$baseUrl/area'))
        .timeout(const Duration(seconds: 8));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat area: status ${response.statusCode}');
    }
    final List<dynamic> listJson = jsonDecode(response.body) as List<dynamic>;
    return listJson.cast<Map<String, dynamic>>();
  }

  Future<Ulasan> kirimUlasan(Ulasan ulasan) async {
    final response = await _client
        .post(
          Uri.parse('$baseUrl/ulasan'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(ulasan.toJson()),
        )
        .timeout(const Duration(seconds: 8));
    if (response.statusCode != 201) {
      throw Exception('Gagal mengirim ulasan: status ${response.statusCode}');
    }
    return Ulasan.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  void dispose() {
    _client.close();
  }
}
