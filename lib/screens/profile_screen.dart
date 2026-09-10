import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showEditProfileDialog(BuildContext context, AppProvider provider) {
    final nameController = TextEditingController(text: provider.user.pseudo);
    String selectedAvatar = provider.user.avatarUrl;
    final avatars = ['😎', '🦁', '👑', '⚡', '🐘', '🌺', '⚽', '🔥', '💃', '🕶️'];

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Text(
                'Modifier le profil',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w800),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Pseudo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Choisir un avatar :',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: avatars.map((av) {
                      final isSel = selectedAvatar == av;
                      return InkWell(
                        onTap: () => setModalState(() => selectedAvatar = av),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSel ? const Color(0xFFFF8C42).withOpacity(0.25) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSel ? const Color(0xFFFF8C42) : Colors.black12,
                              width: isSel ? 2 : 1,
                            ),
                          ),
                          child: Text(av, style: const TextStyle(fontSize: 24)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    provider.updateUserProfile(
                      pseudo: nameController.text,
                      avatar: selectedAvatar,
                    );
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C42),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Enregistrer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final winRate = user.stats.quizzesPlayed > 0
        ? ((user.stats.correctAnswers / (user.stats.quizzesPlayed * 10)) * 100).toInt()
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MON PROFIL',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF18181D) : Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A1A22) : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.black.withOpacity(0.06),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C42).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFF8C42).withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Text(user.avatarUrl, style: const TextStyle(fontSize: 36)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.pseudo,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Niveau ${user.level} • Connaisseur de Babi',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: const Color(0xFF2E8B57),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ElevatedButton.icon(
                          onPressed: () => _showEditProfileDialog(context, provider),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                            foregroundColor: isDark ? Colors.white : const Color(0xFF141418),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.edit_rounded, size: 14),
                          label: Text(
                            'Modifier',
                            style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats grid
            Text(
              'STATISTIQUES DE JEU',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 1.0,
                color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _StatTile(
                  label: 'QUIZ JOUÉS',
                  value: '${user.stats.quizzesPlayed}',
                  icon: Icons.quiz_rounded,
                  color: const Color(0xFFFF8C42),
                ),
                _StatTile(
                  label: 'BONNES RÉPONSES',
                  value: '${user.stats.correctAnswers}',
                  icon: Icons.check_circle_rounded,
                  color: const Color(0xFF2E8B57),
                ),
                _StatTile(
                  label: 'SÉRIE RECORD',
                  value: '${user.stats.maxStreak} 🔥',
                  icon: Icons.local_fire_department_rounded,
                  color: Colors.orange,
                ),
                _StatTile(
                  label: 'PRÉCISION GLOBALE',
                  value: '$winRate %',
                  icon: Icons.pie_chart_rounded,
                  color: const Color(0xFFFFD700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A22) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black.withOpacity(0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
