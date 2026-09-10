import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final score = provider.currentScore;
    final total = provider.currentQuizQuestions.isNotEmpty ? provider.currentQuizQuestions.length : 10;
    final isVictory = score >= (total * 0.7);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Victory Emoji / Trophy
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: (isVictory ? const Color(0xFF2E8B57) : const Color(0xFFFF8C42)).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      isVictory ? '🏆' : '💪',
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                isVictory ? 'Félicitations Champion ! 🎉' : 'Bien tenté, Mogoy !',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isVictory
                    ? 'Tu gères la culture ivoirienne comme un vrai chef.'
                    : 'La culture ivoirienne est riche, rejoue pour t\'enjailler !',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : const Color(0xFF6B6B78),
                ),
              ),
              const SizedBox(height: 28),

              // Metrics Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A22) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black12,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _MetricColumn(
                      label: 'SCORE',
                      value: '$score/$total',
                      color: const Color(0xFFFF8C42),
                    ),
                    _MetricColumn(
                      label: 'PIÈCES',
                      value: '+${provider.sessionCoinsEarned} 🟡',
                      color: const Color(0xFFFFD700),
                    ),
                    _MetricColumn(
                      label: 'SÉRIE MAX',
                      value: '${provider.maxStreakInSession} 🔥',
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Buttons
              ElevatedButton.icon(
                onPressed: () {
                  provider.startQuiz(provider.activeCategory);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8C42),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                icon: const Icon(Icons.replay_rounded),
                label: Text(
                  'REJOUER CE THÈME',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  side: BorderSide(
                    color: isDark ? Colors.white24 : Colors.black26,
                  ),
                ),
                child: Text(
                  'RETOUR À L\'ACCUEIL',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricColumn({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Colors.grey,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }
}
