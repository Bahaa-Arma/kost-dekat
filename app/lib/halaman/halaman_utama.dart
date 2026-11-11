import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/kos.dart';
import '../model/ulasan.dart';
import '../service/kos_service.dart';
import '../pages/detail_kos_page.dart';
import '../pages/tab_cari_page.dart';
import 'tab_favorit.dart';
import 'tab_profil.dart';

/// Pemilik state tab. NavigationBar + IndexedStack agar keadaan tiap tab tetap.
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({
    super.key,
    this.namaPengguna = 'Mahasiswa Tel-U',
    this.emailPengguna = '',
    this.kosService,
  });

  final String namaPengguna;
  final String emailPengguna;

  /// KosService opsional — untuk widget test bisa menyuntikkan service palsu.
  final KosService? kosService;

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _indeksTab = 0;

  // State bersama antar-tab (pemilik data)
  late Future<List<Kos>> _futureKos;
  final Set<String> _idFavorit = {};
  final List<Ulasan> _daftarUlasan = [];

  late final KosService _kosService;

  @override
  void initState() {
    super.initState();
    _kosService = widget.kosService ?? KosService(client: http.Client());
    _futureKos = _kosService.ambilDaftarKos();
  }

  /// Toggle favorit: tambah jika belum ada, hapus jika sudah ada.
  void toggleFavorit(String id) {
    final ditambah = !_idFavorit.contains(id);
    setState(() {
      if (ditambah) {
        _idFavorit.add(id);
      } else {
        _idFavorit.remove(id);
      }
    });
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ditambah ? 'Ditambahkan ke Favorit' : 'Dihapus dari Favorit',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Simpan ulasan baru dari HalamanDetailKos.
  void tambahUlasan(Ulasan u) {
    setState(() => _daftarUlasan.add(u));
  }

  /// Muat ulang data dari server.
  void muatUlang() {
    setState(() {
      _futureKos = _kosService.ambilDaftarKos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _indeksTab,
          children: [
            // Tab 0 — Cari (pakai TabCariPage yang sudah ada)
            TabCariPage(
              futureKos: _futureKos,
              idFavorit: _idFavorit,
              onToggleFavorit: toggleFavorit,
              onMuatUlang: muatUlang,
            ),
            // Tab 1 — Favorit: filter dari data yang sama, tidak panggil server
            TabFavorit(
              futureKos: _futureKos,
              idFavorit: _idFavorit,
              onToggleFavorit: toggleFavorit,
              onTapKos: (kos) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailKosPage(
                      kos: kos,
                      isFavorit: _idFavorit.contains(kos.id),
                      onToggleFavorit: () => toggleFavorit(kos.id),
                    ),
                  ),
                );
              },
            ),
            // Tab 2 — Profil
            TabProfil(
              namaPengguna: widget.namaPengguna,
              emailPengguna: widget.emailPengguna,
              daftarUlasan: _daftarUlasan,
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
