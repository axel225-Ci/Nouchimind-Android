import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  int _secondsLeft = 30;
  int? _selectedAnswerIndex;
  bool _isAnswerSubmitted = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _handleTimeOut();
      }
    });
  }

  void _handleTimeOut() {
    if (_isAnswerSubmitted) return;
    _handleSelectAnswer(-1); // timeout treated as wrong answer
  }

  void _handleSelectAnswer(int index) {
    if (_isAnswerSubmitted) return;
    _timer?.cancel();
    setState(() {
      _selectedAnswerIndex = index;
      _isAnswerSubmitted = true;
    });

    final provider = context.read<AppProvider>();
    if (index >= 0) {
      provider.answerQuestion(index);
    }
  }

  void _handleNext() {
    final provider = context.read<AppProvider>();
    if (provider.currentQuestionIndex + 1 >= provider.currentQuizQuestions.length) {
      provider.finishQuizSession();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ResultScreen()),
      );
    } else {
      provider.nextQuestion();
      setState(() {
        _selectedAnswerIndex = null;
        _isAnswerSubmitted = false;
      });
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final question = provider.currentQuestion;

    if (question == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentIndex = provider.currentQuestionIndex + 1;
    final totalQuestions = provider.currentQuizQuestions.length;
    final progress = currentIndex / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              'QUESTION $currentIndex / $totalQuestions',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w900,
                fontSize: 12,
                color: const Color(0xFFFF8C42),
                letterSpacing: 1.0,
              ),
            ),
            Text(
              provider.activeCategory,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
              ),
            ),
          ],
        ),
        actions: [
          // Timer badge
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (_secondsLeft <= 5 ? Colors.red : const Color(0xFFFF8C42)).withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: (_secondsLeft <= 5 ? Colors.red : const Color(0xFFFF8C42)).withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: _secondsLeft <= 5 ? Colors.red : const Color(0xFFFF8C42),
                ),
                const SizedBox(width: 4),
                Text(
                  '${_secondsLeft}s',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: _secondsLeft <= 5 ? Colors.red : const Color(0xFFFF8C42),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: isDark ? Colors.white12 : Colors.black12,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF8C42)),
                ),
              ),
              const SizedBox(height: 16),

              // Question Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A22) : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black.withOpacity(0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (provider.currentStreak > 1)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🔥', style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              'Série x${provider.currentStreak} (+${provider.currentStreak * 10} pts)',
                              style: GoogleFonts.montserrat(
                                color: const Color(0xFFFF8C42),
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(
                      question.question,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Hint box if used
              if (provider.isHintUsed && provider.hintText != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFFD700)),
                  ),
                  child: Row(
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          provider.hintText!,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Answer Options
              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final isDimmed = provider.disabledOptionIndices.contains(index);
                    final isSelected = _selectedAnswerIndex == index;
                    final isCorrect = index == question.correctOptionIndex;

                    Color? tileColor;
                    Color? borderColor;
                    Color textColor = isDark ? Colors.white : const Color(0xFF141418);

                    if (_isAnswerSubmitted) {
                      if (isCorrect) {
                        tileColor = const Color(0xFF2E8B57).withOpacity(0.2);
                        borderColor = const Color(0xFF2E8B57);
                      } else if (isSelected) {
                        tileColor = Colors.red.withOpacity(0.2);
                        borderColor = Colors.red;
                      }
                    } else if (isDimmed) {
                      tileColor = isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04);
                      borderColor = Colors.transparent;
                      textColor = Colors.grey;
                    }

                    return Opacity(
                      opacity: isDimmed ? 0.35 : 1.0,
                      child: InkWell(
                        onTap: isDimmed || _isAnswerSubmitted
                            ? null
                            : () => _handleSelectAnswer(index),
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: tileColor ?? (isDark ? const Color(0xFF1E1E28) : Colors.white),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: borderColor ??
                                  (isDark ? Colors.white12 : Colors.black.withOpacity(0.08)),
                              width: isSelected || (_isAnswerSubmitted && isCorrect) ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: borderColor?.withOpacity(0.2) ??
                                      (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                      color: borderColor ?? textColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  question.options[index],
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              if (_isAnswerSubmitted && isCorrect)
                                const Icon(Icons.check_circle_rounded, color: Color(0xFF2E8B57)),
                              if (_isAnswerSubmitted && isSelected && !isCorrect)
                                const Icon(Icons.cancel_rounded, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Jokers & Next Button
              if (!_isAnswerSubmitted) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _JokerButton(
                      emoji: '✂️',
                      label: '50:50',
                      count: provider.inventory['50_50'] ?? 0,
                      onTap: provider.isFiftyFiftyUsed ? null : () => provider.useFiftyFifty(),
                    ),
                    _JokerButton(
                      emoji: '💡',
                      label: 'Indice',
                      count: provider.inventory['hint'] ?? 0,
                      onTap: provider.isHintUsed ? null : () => provider.useHint(),
                    ),
                    _JokerButton(
                      emoji: '🔄',
                      label: 'Changer',
                      count: provider.inventory['change_question'] ?? 0,
                      onTap: () {
                        provider.useChangeQuestion();
                        _startTimer();
                      },
                    ),
                  ],
                ),
              ] else ...[
                // Explanation Card & Next
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E28) : const Color(0xFFF3EFE6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '💡 ${question.explanation}',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C42),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    currentIndex == totalQuestions ? 'VOIR LES RÉSULTATS' : 'QUESTION SUIVANTE',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _JokerButton extends StatelessWidget {
  final String emoji;
  final String label;
  final int count;
  final VoidCallback? onTap;

  const _JokerButton({
    required this.emoji,
    required this.label,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAvailable = count > 0 && onTap != null;

    return InkWell(
      onTap: isAvailable ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1A22) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white12 : Colors.black12,
            ),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 2),
              Text(
                '$label ($count)',
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
