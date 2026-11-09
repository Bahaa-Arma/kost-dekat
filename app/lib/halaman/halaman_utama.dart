import 'package:flutter/material.dart';

import 'tab_profil.dart';

/// Pemilik state tab. NavigationBar + IndexedStack agar keadaan tiap tab tetap.
// shortcut: belum menerima KosService dan tab Cari/Favorit masih placeholder; lengkapi di SCRUM-19, 22, 27, 31.
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({
    super.key,
    this.namaPengguna = 'Mahasiswa Tel-U',
    this.emailPengguna = '',
  });

  final String namaPengguna;
  final String emailPengguna;

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _indeksTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _indeksTab,
          children: [
            const _TabSementara(judul: 'Cari kos', tiket: 'SCRUM-22'),
            const _TabSementara(judul: 'Favorit', tiket: 'SCRUM-31'),
            TabProfil(
              namaPengguna: widget.namaPengguna,
              emailPengguna: widget.emailPengguna,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeksTab,
        onDestinationSelected: (indeks) => setState(() => _indeksTab = indeks),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Cari'),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _TabSementara extends StatelessWidget {
  const _TabSementara({required this.judul, required this.tiket});

  final String judul;
  final String tiket;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(judul, style: teks.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Bagian ini sedang dibuat ($tiket).',
            style: teks.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
