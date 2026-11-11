import 'package:flutter/material.dart';

import '../model/kos.dart';
import '../model/ulasan.dart';
import '../tema/tema_kosdekat.dart';

/// Form tambah ulasan kos (SCRUM-29).
/// Menerima objek [Kos] utuh lewat konstruktor (P05).
/// Mengembalikan objek [Ulasan] melalui `Navigator.pop(context, ulasan)`.
class HalamanFormUlasan extends StatefulWidget {
  const HalamanFormUlasan({
    super.key,
    required this.kos,
  });

  final Kos kos;

  @override
  State<HalamanFormUlasan> createState() => _HalamanFormUlasanState();
}

class _HalamanFormUlasanState extends State<HalamanFormUlasan> {
  final _namaKosController = TextEditingController();
  final _komentarController = TextEditingController();
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _namaKosController.text = widget.kos.nama;
  }

  @override
  void dispose() {
    _namaKosController.dispose(); // P03: controller di-dispose sebelum super
    _komentarController.dispose();
    super.dispose();
  }

  void _kirim() {
    if (_rating == 0 || _komentarController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Beri bintang dan komentar dulu')),
      );
      return;
    }

    Navigator.pop(
      context,
      Ulasan(
        kosId: widget.kos.id,
        namaKos: widget.kos.nama,
        rating: _rating,
        komentar: _komentarController.text.trim(),
        tanggal: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warnaBintang =
        Theme.of(context).extension<WarnaKosDekat>()?.bintang ??
            Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Tulis Ulasan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _namaKosController,
            readOnly: true,
            decoration: const InputDecoration(labelText: 'Nama kos'),
          ),
          const SizedBox(height: 16),
          Text('Rating', style: teks.titleMedium),
          const SizedBox(height: 8),
          Row(
            // Fitur khas: 5 IconButton bintang yang bisa diketuk
            children: List.generate(5, (i) {
              return IconButton(
                tooltip: 'Rating ${i + 1} bintang',
                icon: Icon(
                  i < _rating ? Icons.star : Icons.star_border,
                  color: warnaBintang,
                  size: 32,
                ),
                onPressed: () => setState(() => _rating = i + 1),
              );
            }),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _komentarController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Komentar',
              hintText: 'Ceritakan pengalaman tinggal di kos ini...',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _kirim,
            icon: const Icon(Icons.send),
            label: const Text('Kirim Ulasan'),
          ),
        ],
      ),
    );
  }
}
