import 'package:flutter/material.dart';

import '../models/kos.dart';
import '../services/api_service.dart';
import '../widgets/kos_card.dart';
import 'add_review_page.dart';
import 'kos_detail_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.api});
  final ApiService api;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Kos>> _futureKos;
  final _searchController = TextEditingController();
  int _tab = 0;
  String _tipe = 'Semua';
  String _sort = 'Harga';
  final Set<String> _favorites = {};
  List<Map<String, dynamic>> _reviews = [];

  @override
  void initState() {
    super.initState();
    _futureKos = widget.api.getKos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() => setState(() => _futureKos = widget.api.getKos());

  Future<void> _addReview(List<Kos> kos) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddReviewPage(kosNames: kos.map((e) => e.nama).toList()),
      ),
    );
    if (!mounted) return;
    if (result != null) {
      setState(() => _reviews = [..._reviews, result]);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ulasan berhasil ditambahkan!')),
      );
    }
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (!_favorites.add(id)) _favorites.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/kosdekat_logo.png', width: 34, height: 34),
            const SizedBox(width: 9),
            const Text(
              'KosDekat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          if (_tab == 0)
            IconButton(
              tooltip: 'Tambah ulasan',
              icon: const Icon(Icons.rate_review_outlined),
              onPressed: () async {
                try {
                  final items = await _futureKos;
                  if (!context.mounted) return;
                  _addReview(items);
                } catch (_) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data kos belum dapat dimuat'),
                    ),
                  );
                }
              },
            ),
        ],
      ),
      body: FutureBuilder<List<Kos>>(
        future: _futureKos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 48),
                    const SizedBox(height: 12),
                    const Text(
                      'Belum bisa memuat daftar kos. Periksa koneksi server.',
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            );
          }
          final kos = snapshot.data ?? [];
          return IndexedStack(
            index: _tab,
            children: [
              _buildSearchTab(kos),
              _buildFavoriteTab(kos),
              const ProfilePage(),
            ],
          );
        },
      ),
      floatingActionButton: _tab == 0
          ? FloatingActionButton.extended(
              onPressed: () => _futureKos.then((items) {
                if (mounted) _addReview(items);
              }),
              icon: const Icon(Icons.rate_review),
              label: const Text('Ulas kos'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (value) => setState(() => _tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Cari'),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab(List<Kos> data) {
    final query = _searchController.text.toLowerCase();
    final filtered = data
        .where(
          (k) =>
              (k.nama.toLowerCase().contains(query) ||
                  k.area.toLowerCase().contains(query)) &&
              (_tipe == 'Semua' || k.tipe == _tipe),
        )
        .toList();
    filtered.sort(
      (a, b) => _sort == 'Harga'
          ? a.hargaBulanan.compareTo(b.hargaBulanan)
          : a.jarakKm.compareTo(b.jarakKm),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Cari nama kos atau area...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Putra', label: Text('Putra')),
                    ButtonSegment(value: 'Putri', label: Text('Putri')),
                    ButtonSegment(value: 'Campur', label: Text('Campur')),
                  ],
                  selected: _tipe == 'Semua' ? <String>{} : <String>{_tipe},
                  emptySelectionAllowed: true,
                  onSelectionChanged: (values) => setState(
                    () => _tipe = values.isEmpty ? 'Semua' : values.first,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                tooltip: 'Urutkan',
                initialValue: _sort,
                onSelected: (value) => setState(() => _sort = value),
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'Harga', child: Text('Harga terendah')),
                  PopupMenuItem(value: 'Jarak', child: Text('Jarak terdekat')),
                ],
                child: Chip(
                  avatar: const Icon(Icons.sort, size: 18),
                  label: Text(_sort),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Text(
                '${filtered.length} kos ditemukan',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              Text(
                'Area sekitar Tel-U',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(
                  child: Text('Kos tidak ditemukan. Coba kata kunci lain.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return KosCard(
                      kos: item,
                      isFavorite: _favorites.contains(item.id),
                      onFavorite: () => _toggleFavorite(item.id),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => KosDetailPage(kos: item),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFavoriteTab(List<Kos> data) {
    final items = data.where((k) => _favorites.contains(k.id)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            'Kos favorit',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada kos favorit. Ketuk ikon hati pada kartu kos.',
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return KosCard(
                      kos: item,
                      isFavorite: true,
                      onFavorite: () => _toggleFavorite(item.id),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => KosDetailPage(kos: item),
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (_reviews.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Ulasan terkirim: ${_reviews.length}'),
          ),
      ],
    );
  }
}
