import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

const _headerJson = {'Content-Type': 'application/json'};

Response _balasJson(Object? isi, {int status = 200}) =>
    Response(status, body: jsonEncode(isi), headers: _headerJson);

Future<void> main() async {
  // Dijalankan dari folder server/, jadi path relatif ini menunjuk server/data/kos.json.
  final daftarKos =
      (jsonDecode(await File('data/kos.json').readAsString()) as List)
          .cast<Map<String, dynamic>>();

  final router = Router()
    ..get('/kos', (Request req) => _balasJson(daftarKos))
    ..get('/kos/<id>', (Request req, String id) {
      for (final kos in daftarKos) {
        if (kos['id'] == id) return _balasJson(kos);
      }
      return _balasJson({'pesan': 'Kos tidak ditemukan'}, status: 404);
    });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);
  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
  print(
    'Server KosDekat berjalan di http://${server.address.host}:${server.port}',
  );
}
