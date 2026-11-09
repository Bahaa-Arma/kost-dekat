import 'package:flutter/material.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key, required this.kosNames});
  final List<String> kosNames;
  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final _comment = TextEditingController();
  String? _selectedKos;
  int _rating = 0;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Tambah ulasan')),
        body: Form(
            key: _formKey,
            child: ListView(padding: const EdgeInsets.all(20), children: [
              Text('Bagikan pengalamanmu',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 18),
              DropdownButtonFormField<String>(
                initialValue: _selectedKos,
                decoration: const InputDecoration(
                    labelText: 'Nama kos', border: OutlineInputBorder()),
                items: widget.kosNames
                    .map((name) =>
                        DropdownMenuItem(value: name, child: Text(name)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedKos = value),
                validator: (value) => value == null ? 'Pilih nama kos' : null,
              ),
              const SizedBox(height: 22),
              const Text('Rating kos'),
              const SizedBox(height: 6),
              Row(
                  children: List.generate(
                      5,
                      (index) => IconButton(
                            tooltip: 'Beri ${index + 1} bintang',
                            onPressed: () =>
                                setState(() => _rating = index + 1),
                            icon: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 34,
                                color: Theme.of(context).colorScheme.tertiary),
                          ))),
              Text(_rating == 0
                  ? 'Ketuk bintang untuk memberi rating'
                  : '$_rating dari 5 bintang'),
              const SizedBox(height: 18),
              TextFormField(
                  controller: _comment,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      labelText: 'Komentar',
                      hintText: 'Ceritakan pengalamanmu...',
                      border: OutlineInputBorder()),
                  validator: (value) => value == null || value.trim().length < 5
                      ? 'Komentar minimal 5 karakter'
                      : null),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  if (_rating == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Pilih rating terlebih dahulu')));
                    return;
                  }
                  Navigator.pop(context, {
                    'namaKos': _selectedKos,
                    'rating': _rating,
                    'komentar': _comment.text.trim(),
                  });
                },
                icon: const Icon(Icons.send),
                label: const Text('Kirim ulasan'),
              ),
            ])),
      );
}
