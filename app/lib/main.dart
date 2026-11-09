import 'package:flutter/material.dart';

import 'tema/tema_kosdekat.dart';

void main() {
  runApp(const KosDekatApp());
}

class KosDekatApp extends StatelessWidget {
  const KosDekatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KosDekat',
      theme: temaTerang,
      darkTheme: temaGelap,
      themeMode: ThemeMode.system,
      // TODO(SCRUM-27): ganti dengan HalamanUtama (NavigationBar Cari, Favorit, Profil).
      home: const _HalamanSementara(),
    );
  }
}

class _HalamanSementara extends StatelessWidget {
  const _HalamanSementara();

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KosDekat', style: teks.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Halaman utama sedang dibuat (SCRUM-27).',
                style: teks.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
