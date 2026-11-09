import 'package:flutter/material.dart';

import 'halaman/halaman_login.dart';
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
      home: const HalamanLogin(),
    );
  }
}
