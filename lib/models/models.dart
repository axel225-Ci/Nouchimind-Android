enum AppThemeMode { dark, light, system }

class QuizQuestion {
  final String id;
  final String category;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final int difficulty; // 1 to 3

  const QuizQuestion({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    this.difficulty = 1,
  });
}

class CategoryItem {
  final String id;
  final String name;
  final String description;
  final int unlockLevel;
  final bool locked;
  final bool isNew;
  final int colorHex;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.unlockLevel,
    this.locked = false,
    this.isNew = false,
    required this.colorHex,
  });
}

class UserStats {
  int quizzesPlayed;
  int correctAnswers;
  int maxStreak;
  int totalScore;

  UserStats({
    this.quizzesPlayed = 0,
    this.correctAnswers = 0,
    this.maxStreak = 0,
    this.totalScore = 0,
  });

  Map<String, dynamic> toJson() => {
        'quizzesPlayed': quizzesPlayed,
        'correctAnswers': correctAnswers,
        'maxStreak': maxStreak,
        'totalScore': totalScore,
      };

  factory UserStats.fromJson(Map<String, dynamic> json) => UserStats(
        quizzesPlayed: json['quizzesPlayed'] ?? 0,
        correctAnswers: json['correctAnswers'] ?? 0,
        maxStreak: json['maxStreak'] ?? 0,
        totalScore: json['totalScore'] ?? 0,
      );
}

class UserProfile {
  String pseudo;
  String avatarUrl;
  int level;
  int currentXp;
  int nextLevelXp;
  int coins;
  UserStats stats;
  String? lastDailyRewardClaimDate;

  UserProfile({
    required this.pseudo,
    required this.avatarUrl,
    required this.level,
    required this.currentXp,
    required this.nextLevelXp,
    required this.coins,
    required this.stats,
    this.lastDailyRewardClaimDate,
  });
}

class ShopItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final String type; // lifeline, pack, cosmetic
  final String iconEmoji;

  const ShopItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.iconEmoji,
  });
}

class LeaderboardPlayer {
  final int rank;
  final String name;
  final String avatar;
  final int xp;
  final bool isMe;

  const LeaderboardPlayer({
    required this.rank,
    required this.name,
    required this.avatar,
    required this.xp,
    this.isMe = false,
  });
}
