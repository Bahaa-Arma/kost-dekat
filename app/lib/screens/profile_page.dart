import 'package:flutter/material.dart';
import '../tema/tema_kosdekat.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 22),
        CircleAvatar(
          radius: 42,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.person,
            size: 46,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Mahasiswa Telkom University',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 6),
        Text(
          'Temukan tempat tinggal nyaman di sekitar kampus.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 28),
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeModeNotifier,
          builder: (context, currentMode, _) {
            final isDark = currentMode == ThemeMode.dark ||
                (currentMode == ThemeMode.system &&
                    MediaQuery.platformBrightnessOf(context) ==
                        Brightness.dark);
            return SwitchListTile(
              secondary: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Mode gelap'),
              subtitle: Text(
                currentMode == ThemeMode.system
                    ? 'Mengikuti sistem (${isDark ? "Gelap" : "Terang"})'
                    : (isDark ? 'Mode gelap aktif' : 'Mode terang aktif'),
              ),
              value: isDark,
              onChanged: (val) {
                themeModeNotifier.value =
                    val ? ThemeMode.dark : ThemeMode.light;
              },
            );
          },
        ),
        const Divider(height: 20),
        const ListTile(
          leading: Icon(Icons.location_on_outlined),
          title: Text('Area pencarian'),
          subtitle: Text('Sukapura, Sukabirus, Bojongsoang, dan sekitarnya'),
        ),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Tentang KosDekat'),
          subtitle: Text('Platform pencarian kos dekat Telkom University'),
        ),
      ],
    );
  }
}
