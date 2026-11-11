import 'package:flutter/material.dart';

import '../models/kos.dart';
import '../utils/format.dart';

class KosDetailPage extends StatelessWidget {
  const KosDetailPage({super.key, required this.kos});
  final Kos kos;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail kos')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/kos_illustration.png',
              height: 210,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            kos.nama,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            kos.area,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatRupiah(kos.hargaBulanan),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 24),
                  _Info(
                    icon: Icons.people_alt_outlined,
                    label: 'Tipe kos',
                    value: kos.tipe,
                  ),
                  _Info(
                    icon: Icons.bathroom_outlined,
                    label: 'Kamar mandi',
                    value: kos.kamarMandiDalam ? 'Di dalam' : 'Di luar',
                  ),
                  _Info(
                    icon: Icons.directions_walk,
                    label: 'Jarak ke kampus',
                    value: '${kos.jarakKm.toStringAsFixed(1)} km',
                  ),
                  _Info(
                    icon: Icons.update,
                    label: 'Diperbarui',
                    value:
                        '${kos.diperbarui.day}/${kos.diperbarui.month}/${kos.diperbarui.year}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text('Informasi kos', style: Theme.of(context).textTheme.titleMedium),
          const Text(
            'Hubungi pemilik kos untuk memastikan ketersediaan kamar, fasilitas, dan ketentuan sewa terbaru.',
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
