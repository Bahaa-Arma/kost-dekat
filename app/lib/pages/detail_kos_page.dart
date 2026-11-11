import 'package:flutter/material.dart';

import '../model/kos.dart';
import '../utils/format_rupiah.dart';

class DetailKosPage extends StatefulWidget {
  final Kos kos;
  final bool isFavorit;
  final VoidCallback? onToggleFavorit;

  const DetailKosPage({
    super.key,
    required this.kos,
    this.isFavorit = false,
    this.onToggleFavorit,
  });

  @override
  State<DetailKosPage> createState() => _DetailKosPageState();
}

class _DetailKosPageState extends State<DetailKosPage> {
  late bool _isFavorit;

  @override
  void initState() {
    super.initState();
    _isFavorit = widget.isFavorit;
  }

  void _handleToggleFavorit() {
    setState(() {
      _isFavorit = !_isFavorit;
    });
    widget.onToggleFavorit?.call();
  }

  @override
  Widget build(BuildContext context) {
    final kos = widget.kos;
    return Scaffold(
      appBar: AppBar(
        title: Text(kos.nama),
        actions: [
          if (widget.onToggleFavorit != null)
            IconButton(
              tooltip: _isFavorit ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
              icon: Icon(
                _isFavorit ? Icons.favorite : Icons.favorite_border,
                color: _isFavorit ? Theme.of(context).colorScheme.error : null,
              ),
              onPressed: _handleToggleFavorit,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'kos-img-${kos.id}',
              child: Image.network(
                'https://picsum.photos/400?id=${kos.id}',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kos.nama,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    kos.area,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    CurrencyUtils.formatRupiah(kos.hargaBulanan),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const Divider(height: 24),
                  Text(
                    'Tipe Kos: ${kos.tipe}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kamar Mandi Dalam: ${kos.kamarMandiDalam ? "Ya" : "Tidak"}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jarak: ${kos.jarakKm} km',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Diperbarui: ${kos.diperbarui.toLocal().toString().split(".")[0]}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
