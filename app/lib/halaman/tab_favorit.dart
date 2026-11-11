import 'package:flutter/material.dart';

import '../model/kos.dart';
import '../widgets/kartu_kost.dart';

/// Tab Favorit (SCRUM-31).
/// Menyaring data kos dari [futureKos] berdasarkan [idFavorit].
/// Data dipakai bersama dengan Tab Cari — tidak ada pemanggilan server baru.
class TabFavorit extends StatelessWidget {
  const TabFavorit({
    super.key,
    required this.futureKos,
    required this.idFavorit,
    required this.onToggleFavorit,
    required this.onTapKos,
  });

  /// Future data kos yang sama dengan Tab Cari — tidak memanggil server ulang.
  final Future<List<Kos>> futureKos;

  /// Set id kos yang difavoritkan — milik HalamanUtama.
  final Set<String> idFavorit;

  /// Callback ke HalamanUtama untuk toggle favorit.
  final void Function(String id) onToggleFavorit;

  /// Callback saat kartu kos diketuk (buka halaman detail).
  final void Function(Kos kos) onTapKos;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;

    return FutureBuilder<List<Kos>>(
      future: futureKos,
      builder: (context, snapshot) {
        // Masih loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Gagal memuat data',
              style: teks.bodyMedium?.copyWith(color: warna.error),
            ),
          );
        }

        // Filter: hanya kos yang ada di idFavorit
        final semua = snapshot.data ?? [];
        final favorit = semua.where((k) => idFavorit.contains(k.id)).toList();

        // Empty state
        if (favorit.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 72,
                    color: warna.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada kos favorit. Ketuk ikon hati di tab Cari.',
                    style: teks.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: favorit.length,
          itemBuilder: (context, index) {
            final kos = favorit[index];
            return KartuKost(
              kos: kos,
              isFavorit: true, // di tab Favorit semua pasti favorit
              onTap: () => onTapKos(kos),
              onToggleFavorit: () => onToggleFavorit(kos.id),
            );
          },
        );
      },
    );
  }
}
