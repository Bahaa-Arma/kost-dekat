import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Seed color diambil dari referensi Dribbble "Papa Kost" (Kretya Studio): #14695C (deep pine green / teal).
const warnaSeed = Color(0xFF14695C);

/// Pengatur mode tema (default: ThemeMode.system).
final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

/// Tema terang khas KosDekat.
final temaTerang = ThemeData(
  useMaterial3: true,
  fontFamily: 'PlusJakartaSans',
  colorScheme: ColorScheme.fromSeed(
    seedColor: warnaSeed,
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.plusJakartaSansTextTheme(),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
  ),
  cardTheme: CardThemeData(
    elevation: 1,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
);

/// Tema gelap khas KosDekat.
final temaGelap = ThemeData(
  useMaterial3: true,
  fontFamily: 'PlusJakartaSans',
  colorScheme: ColorScheme.fromSeed(
    seedColor: warnaSeed,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.plusJakartaSansTextTheme(
    ThemeData.dark().textTheme,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
  ),
  cardTheme: CardThemeData(
    elevation: 1,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
);
