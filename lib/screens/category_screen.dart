import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../data/questions_data.dart';
import 'quiz_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'THÈMES DE QUIZ',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF18181D) : Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: kCategoriesList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final cat = kCategoriesList[index];
          final isLocked = user.level < cat.unlockLevel || cat.locked;

          return InkWell(
            onTap: isLocked
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Atteins le niveau ${cat.unlockLevel} pour débloquer ce thème !'),
                      ),
                    );
                  }
                : () {
                    provider.startQuiz(cat.name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A1A22) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.black.withOpacity(0.06),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(cat.colorHex).withOpacity(isLocked ? 0.08 : 0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Icon(
                        isLocked ? Icons.lock_outline_rounded : Icons.menu_book_rounded,
                        color: isLocked ? Colors.grey : Color(cat.colorHex),
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                cat.name,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: isLocked ? Colors.grey : null,
                                ),
                              ),
                            ),
                            if (cat.isNew)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF8C42),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'NOUVEAU',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cat.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
                          ),
                        ),
                        if (isLocked)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              'Déblocage au Niveau ${cat.unlockLevel}',
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    isLocked ? Icons.lock_rounded : Icons.chevron_right_rounded,
                    color: isLocked ? Colors.grey : const Color(0xFFFF8C42),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
