import 'package:flutter/material.dart';

import '../models/kos.dart';
import '../utils/format.dart';

class KosCard extends StatelessWidget {
  const KosCard({
    super.key,
    required this.kos,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
  });
  final Kos kos;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/kos_illustration.png',
                      width: 104,
                      height: 112,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 6,
                    bottom: 6,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface
                            .withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        child: Text(
                          '${kos.jarakKm.toStringAsFixed(1)} km',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            kos.nama,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Favorit',
                          onPressed: onFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? colors.error
                                : colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      kos.area,
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 7),
                    Wrap(
                      spacing: 6,
                      children: [
                        _Tag(text: kos.tipe),
                        _Tag(
                          text: kos.kamarMandiDalam ? 'KM dalam' : 'KM luar',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatRupiah(kos.hargaBulanan),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${kos.jarakKm.toStringAsFixed(1)} km dari kampus',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Update ${kos.diperbarui.day}/${kos.diperbarui.month}/${kos.diperbarui.year}',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Chip(
    label: Text(text, style: Theme.of(context).textTheme.labelSmall),
    visualDensity: VisualDensity.compact,
    padding: EdgeInsets.zero,
  );
}
