import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  final file = File('data/kos.json');
  final List<dynamic> kos = jsonDecode(await file.readAsString()) as List<dynamic>;
  final router = Router();

  router.get('/health', (Request request) =>
    Response.ok(jsonEncode({'status': 'ok', 'service': 'KosDekat API'}),
      headers: {'content-type': 'application/json'}));

  router.get('/kos', (Request request) =>
    Response.ok(jsonEncode(kos), headers: {'content-type': 'application/json'}));

  router.get('/kos/<id>', (Request request, String id) {
    final matches = kos.where((item) => item['id'] == id).toList();
    if (matches.isEmpty) {
      return Response.notFound(jsonEncode({'message': 'Kos tidak ditemukan'}),
        headers: {'content-type': 'application/json'});
    }
    return Response.ok(jsonEncode(matches.first),
      headers: {'content-type': 'application/json'});
  });

  router.get('/area', (Request request) {
    final Map<String, List<num>> grouped = {};
    for (final item in kos) {
      final area = item['area'] as String;
      grouped.putIfAbsent(area, () => []).add(item['hargaBulanan'] as num);
    }
    final result = grouped.entries.map((entry) {
      final prices = entry.value;
      final average = prices.reduce((a, b) => a + b) / prices.length;
      return {'area': entry.key, 'jumlahKos': prices.length,
        'hargaRataRata': average.round()};
    }).toList()
      ..sort((a, b) => (a['area'] as String).compareTo(b['area'] as String));
    return Response.ok(jsonEncode(result),
      headers: {'content-type': 'application/json'});
  });

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware((inner) => (request) async {
        final response = await inner(request);
        return response.change(headers: {
          'access-control-allow-origin': '*',
          'access-control-allow-methods': 'GET, OPTIONS',
          'access-control-allow-headers': 'Origin, Content-Type',
          ...response.headers,
        });
      })
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('KosDekat API berjalan di http://${server.address.host}:${server.port}');
  print('Endpoint: GET /kos, GET /kos/<id>, GET /area, GET /health');
}
