import 'package:flutter/material.dart';

import '../model/kos.dart';
import '../widgets/kartu_kost.dart';
import '../widgets/kategori_segmented_button.dart';
import '../widgets/area_chip_list.dart';
import '../widgets/sort_selector.dart';
import 'detail_kos_page.dart';

class TabCariPage extends StatefulWidget {
  const TabCariPage({
    super.key,
    required this.futureKos,
    required this.idFavorit,
    required this.onToggleFavorit,
    required this.onMuatUlang,
  });

  /// Future data kos — milik HalamanUtama, dipakai bersama dengan TabFavorit.
  final Future<List<Kos>> futureKos;

  /// Set id favorit — milik HalamanUtama.
  final Set<String> idFavorit;

  /// Callback toggle favorit ke HalamanUtama.
  final void Function(String id) onToggleFavorit;

  /// Callback muat ulang data dari server.
  final VoidCallback onMuatUlang;

  @override
  State<TabCariPage> createState() => _TabCariPageState();
}

class _TabCariPageState extends State<TabCariPage> {
  TipeKosFilter _selectedFilter = TipeKosFilter.semua;
  String? _selectedArea;
  SortOption _currentSort = SortOption.jarakTerdekat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KategoriSegmentedButton(
          selectedFilter: _selectedFilter,
          onSelectionChanged: (filter) =>
              setState(() => _selectedFilter = filter),
        ),
        AreaChipList(
          areas: const ['Setiabudi', 'Dayeuhkolot', 'Telekomunikasi'],
          selectedArea: _selectedArea,
          onAreaSelected: (area) => setState(() => _selectedArea = area),
        ),
        SortSelector(
          currentSort: _currentSort,
          onSortChanged: (sort) =>
              setState(() => _currentSort = sort ?? SortOption.jarakTerdekat),
        ),
        const Divider(),
        Expanded(
          child: FutureBuilder<List<Kos>>(
            future: widget.futureKos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Gagal memuat data kost.'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: widget.onMuatUlang,
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }
              final listKos = snapshot.data ?? [];
              if (listKos.isEmpty) {
                return const Center(child: Text('Tidak ada kos ditemukan.'));
              }

              return ListView.builder(
                itemCount: listKos.length,
                itemBuilder: (context, index) {
                  final kos = listKos[index];
                  return KartuKost(
                    kos: kos,
                    isFavorit: widget.idFavorit.contains(kos.id),
                    onToggleFavorit: () => widget.onToggleFavorit(kos.id),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailKosPage(
                            kos: kos,
                            isFavorit: widget.idFavorit.contains(kos.id),
                            onToggleFavorit: () =>
                                widget.onToggleFavorit(kos.id),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
