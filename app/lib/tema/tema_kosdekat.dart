import 'package:flutter/material.dart';

/// Token `kd.ref.color.seed` (docs/design/design.md). Satu-satunya hex warna merek.
// shortcut: seed masih usulan (inferred), ganti setelah tim memilih dari shot "Papa Kost".
const warnaSeed = Color(0xFF1F6FEB);

/// Warna di luar ColorScheme.
@immutable
class WarnaKosDekat extends ThemeExtension<WarnaKosDekat> {
  const WarnaKosDekat({required this.bintang});

  final Color bintang;

  @override
  WarnaKosDekat copyWith({Color? bintang}) =>
      WarnaKosDekat(bintang: bintang ?? this.bintang);

  @override
  WarnaKosDekat lerp(WarnaKosDekat? other, double t) =>
      WarnaKosDekat(bintang: Color.lerp(bintang, other?.bintang, t)!);
}

ThemeData _buatTema(Brightness brightness) {
  final skema = ColorScheme.fromSeed(
    seedColor: warnaSeed,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: skema,
    // Hanya berat yang beda dari skala M3 (design.md, Typography); ukuran tetap bawaan.
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontWeight: FontWeight.w600),
    ),
    // Komponen lain memakai bawaan M3 karena sudah sesuai design-components.md.
    cardTheme: const CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    // Text Field outlined radius 12; warna fokus dan error tetap bawaan M3.
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    extensions: [
      // Amber gelap di mode terang agar kontras bintang tetap >= 3:1 (design.md).
      WarnaKosDekat(
        bintang: brightness == Brightness.light
            ? const Color(0xFFB26A00)
            : const Color(0xFFFFC107),
      ),
    ],
  );
}

final temaTerang = _buatTema(Brightness.light);
final temaGelap = _buatTema(Brightness.dark);
