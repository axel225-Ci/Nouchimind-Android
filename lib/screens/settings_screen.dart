import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PARAMÈTRES',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF18181D) : Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'THÈME & APPARENCE',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.0,
              color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A22) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black.withOpacity(0.06),
              ),
            ),
            child: Column(
              children: [
                RadioListTile<AppThemeMode>(
                  title: Text(
                    'Mode Sombre 🌙',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  subtitle: const Text('Confortable la nuit et économise la batterie'),
                  value: AppThemeMode.dark,
                  groupValue: provider.themeMode,
                  onChanged: (mode) => provider.setThemeMode(mode!),
                  activeColor: const Color(0xFFFF8C42),
                ),
                Divider(height: 1, color: isDark ? Colors.white10 : Colors.black12),
                RadioListTile<AppThemeMode>(
                  title: Text(
                    'Mode Clair ☀️',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  subtitle: const Text('Interface chaleureuse et lumineuse'),
                  value: AppThemeMode.light,
                  groupValue: provider.themeMode,
                  onChanged: (mode) => provider.setThemeMode(mode!),
                  activeColor: const Color(0xFFFF8C42),
                ),
                Divider(height: 1, color: isDark ? Colors.white10 : Colors.black12),
                RadioListTile<AppThemeMode>(
                  title: Text(
                    'Système 📱 (Automatique)',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  subtitle: const Text('S\'adapte au réglage global de ton téléphone'),
                  value: AppThemeMode.system,
                  groupValue: provider.themeMode,
                  onChanged: (mode) => provider.setThemeMode(mode!),
                  activeColor: const Color(0xFFFF8C42),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'AUDIO & SONS',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.0,
              color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A22) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black.withOpacity(0.06),
              ),
            ),
            child: SwitchListTile(
              title: Text(
                'Effets Sonores',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              subtitle: const Text('Sons de clic, pièces et victoires'),
              value: provider.soundEnabled,
              onChanged: (_) => provider.toggleSound(),
              activeColor: const Color(0xFFFF8C42),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'À PROPOS',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.0,
              color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A22) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black.withOpacity(0.06),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NouchiMind Flutter Edition',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.0 (Dart 3 / Flutter 3)',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Application dédiée à la célébration et à l\'apprentissage de la culture ivoirienne, de l\'argot Nouchi et des traditions d\'Éburnie.',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
