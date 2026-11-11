import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/kos.dart';

class ApiService {
  ApiService({http.Client? client, required this.baseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Future<List<Kos>> getKos() async {
    final response = await _client.get(Uri.parse('$baseUrl/kos'));
    _check(response);
    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded.map((e) => Kos.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Kos> getKosById(String id) async {
    final response = await _client.get(Uri.parse('$baseUrl/kos/$id'));
    _check(response);
    return Kos.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<Map<String, dynamic>>> getArea() async {
    final response = await _client.get(Uri.parse('$baseUrl/area'));
    _check(response);
    return (jsonDecode(response.body) as List<dynamic>)
        .cast<Map<String, dynamic>>();
  }

  void _check(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Server mengembalikan status ${response.statusCode}');
    }
  }

  void dispose() => _client.close();
}
