import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

const _headerJson = {'Content-Type': 'application/json'};

Response _balasJson(Object? isi, {int status = 200}) =>
    Response(status, body: jsonEncode(isi), headers: _headerJson);

/// Kelompokkan kos per area: jumlah kos dan harga rata-rata (dibulatkan), urut nama area.
List<Map<String, Object>> ringkasArea(List<Map<String, dynamic>> daftarKos) {
  final hargaPerArea = <String, List<int>>{};
  for (final kos in daftarKos) {
    hargaPerArea
        .putIfAbsent(kos['area'] as String, () => [])
        .add(kos['hargaBulanan'] as int);
  }
  final namaArea = hargaPerArea.keys.toList()..sort();
  return [
    for (final area in namaArea)
      {
        'area': area,
        'jumlahKos': hargaPerArea[area]!.length,
        'hargaRataRata':
            (hargaPerArea[area]!.reduce((a, b) => a + b) /
                    hargaPerArea[area]!.length)
                .round(),
      },
  ];
}

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
    })
    ..get('/area', (Request req) => _balasJson(ringkasArea(daftarKos)));

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);
  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
  print(
    'Server KosDekat berjalan di http://${server.address.host}:${server.port}',
  );
}
