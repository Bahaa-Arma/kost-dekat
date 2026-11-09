import 'package:flutter/material.dart';

const _akhiranEmailKampus = '@student.telkomuniversity.ac.id';

/// Login simulasi lokal: tidak ada server, kata sandi tidak dikirim maupun disimpan.
class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key, required this.bukaHalamanUtama});

  // shortcut: callback, bukan KosService, karena HalamanUtama (SCRUM-27) belum ada; ganti saat SCRUM-27 di-merge.
  final Widget Function(String nama, String email) bukaHalamanUtama;

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final _kunciForm = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _sandiController = TextEditingController();
  bool _sandiTersembunyi = true;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _sandiController.dispose();
    super.dispose();
  }

  void _masuk() {
    if (!_kunciForm.currentState!.validate()) return;
    final tujuan = widget.bukaHalamanUtama(
      _namaController.text.trim(),
      _emailController.text.trim().toLowerCase(),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => tujuan),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    final warna = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _kunciForm,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            children: [
              Text('Masuk ke KosDekat', style: teks.headlineMedium),
              const SizedBox(height: 24),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: (nilai) {
                  final nama = nilai?.trim() ?? '';
                  if (nama.isEmpty) return 'Nama wajib diisi';
                  if (nama.length < 3) return 'Nama minimal 3 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email kampus',
                  helperText: 'Contoh: nama$_akhiranEmailKampus',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                validator: (nilai) {
                  final email = nilai?.trim().toLowerCase() ?? '';
                  if (email.isEmpty) return 'Email kampus wajib diisi';
                  if (!email.endsWith(_akhiranEmailKampus) ||
                      email.length == _akhiranEmailKampus.length) {
                    return 'Pakai email $_akhiranEmailKampus';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sandiController,
                obscureText: _sandiTersembunyi,
                decoration: InputDecoration(
                  labelText: 'Kata sandi',
                  suffixIcon: IconButton(
                    tooltip: _sandiTersembunyi
                        ? 'Tampilkan kata sandi'
                        : 'Sembunyikan kata sandi',
                    icon: Icon(
                      _sandiTersembunyi
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () =>
                        setState(() => _sandiTersembunyi = !_sandiTersembunyi),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _masuk(),
                validator: (nilai) => (nilai ?? '').length < 6
                    ? 'Kata sandi minimal 6 karakter'
                    : null,
              ),
              const SizedBox(height: 12),
              Text(
                'Mode demo: data tidak dikirim ke server dan kata sandi tidak disimpan.',
                style: teks.bodySmall?.copyWith(color: warna.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: _masuk, child: const Text('Masuk')),
            ],
          ),
        ),
      ),
    );
  }
}
