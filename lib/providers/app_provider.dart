import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../data/questions_data.dart';

class AppProvider extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.system;
  bool _soundEnabled = true;
  bool _musicEnabled = false;
  bool _notificationsEnabled = true;

  late UserProfile _user;
  Map<String, int> _inventory = {
    '50_50': 2,
    'change_question': 1,
    'extra_time': 2,
    'hint': 1,
  };

  // Active quiz session
  String _activeCategory = 'Culture Générale Ivoirienne';
  List<QuizQuestion> _currentQuizQuestions = [];
  int _currentQuestionIndex = 0;
  int _currentScore = 0;
  int _currentStreak = 0;
  int _maxStreakInSession = 0;
  int _sessionCoinsEarned = 0;

  // Jokers active on current question
  bool _isFiftyFiftyUsed = false;
  List<int> _disabledOptionIndices = [];
  bool _isHintUsed = false;
  String? _hintText;

  AppThemeMode get themeMode => _themeMode;
  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  bool get notificationsEnabled => _notificationsEnabled;
  UserProfile get user => _user;
  Map<String, int> get inventory => _inventory;

  String get activeCategory => _activeCategory;
  List<QuizQuestion> get currentQuizQuestions => _currentQuizQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  QuizQuestion? get currentQuestion =>
      _currentQuizQuestions.isNotEmpty && _currentQuestionIndex < _currentQuizQuestions.length
          ? _currentQuizQuestions[_currentQuestionIndex]
          : null;
  int get currentScore => _currentScore;
  int get currentStreak => _currentStreak;
  int get maxStreakInSession => _maxStreakInSession;
  int get sessionCoinsEarned => _sessionCoinsEarned;

  bool get isFiftyFiftyUsed => _isFiftyFiftyUsed;
  List<int> get disabledOptionIndices => _disabledOptionIndices;
  bool get isHintUsed => _isHintUsed;
  String? get hintText => _hintText;

  AppProvider() {
    _user = UserProfile(
      pseudo: 'BabiWarrior',
      avatarUrl: '😎',
      level: 1,
      currentXp: 150,
      nextLevelXp: 500,
      coins: 1250,
      stats: UserStats(
        quizzesPlayed: 0,
        correctAnswers: 0,
        maxStreak: 0,
        totalScore: 0,
      ),
    );
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeStr = prefs.getString('theme_mode');
      if (themeStr == 'dark') _themeMode = AppThemeMode.dark;
      if (themeStr == 'light') _themeMode = AppThemeMode.light;
      if (themeStr == 'system') _themeMode = AppThemeMode.system;

      _soundEnabled = prefs.getBool('sound') ?? true;
      _user.pseudo = prefs.getString('user_pseudo') ?? _user.pseudo;
      _user.avatarUrl = prefs.getString('user_avatar') ?? _user.avatarUrl;
      _user.coins = prefs.getInt('user_coins') ?? _user.coins;
      _user.level = prefs.getInt('user_level') ?? _user.level;
      _user.currentXp = prefs.getInt('user_xp') ?? _user.currentXp;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('theme_mode', _themeMode.name);
      prefs.setBool('sound', _soundEnabled);
      prefs.setString('user_pseudo', _user.pseudo);
      prefs.setString('user_avatar', _user.avatarUrl);
      prefs.setInt('user_coins', _user.coins);
      prefs.setInt('user_level', _user.level);
      prefs.setInt('user_xp', _user.currentXp);
    } catch (_) {}
  }

  void setThemeMode(AppThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _saveToPrefs();
  }

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    notifyListeners();
    _saveToPrefs();
  }

  void updateUserProfile({String? pseudo, String? avatar}) {
    if (pseudo != null && pseudo.trim().isNotEmpty) {
      _user.pseudo = pseudo.trim();
    }
    if (avatar != null && avatar.trim().isNotEmpty) {
      _user.avatarUrl = avatar;
    }
    notifyListeners();
    _saveToPrefs();
  }

  bool claimDailyReward() {
    final today = DateTime.now().toIso8601String().split('T')[0];
    if (_user.lastDailyRewardClaimDate == today) return false;

    _user.coins += 200;
    _user.lastDailyRewardClaimDate = today;
    notifyListeners();
    _saveToPrefs();
    return true;
  }

  void startQuiz(String category) {
    _activeCategory = category;
    final pool = kQuestionsList.where((q) => q.category == category).toList();
    if (pool.isEmpty) {
      _currentQuizQuestions = List.from(kQuestionsList)..shuffle();
      _currentQuizQuestions = _currentQuizQuestions.take(10).toList();
    } else {
      pool.shuffle();
      _currentQuizQuestions = pool.take(10).toList();
    }

    _currentQuestionIndex = 0;
    _currentScore = 0;
    _currentStreak = 0;
    _maxStreakInSession = 0;
    _sessionCoinsEarned = 0;
    _resetJokersForQuestion();
    notifyListeners();
  }

  void _resetJokersForQuestion() {
    _isFiftyFiftyUsed = false;
    _disabledOptionIndices = [];
    _isHintUsed = false;
    _hintText = null;
  }

  bool answerQuestion(int selectedOptionIndex) {
    final question = currentQuestion;
    if (question == null) return false;

    final isCorrect = selectedOptionIndex == question.correctOptionIndex;

    if (isCorrect) {
      _currentScore += 1;
      _currentStreak += 1;
      if (_currentStreak > _maxStreakInSession) {
        _maxStreakInSession = _currentStreak;
      }
      final bonusStreak = _currentStreak > 1 ? (_currentStreak * 10) : 0;
      final coins = 50 + bonusStreak;
      _sessionCoinsEarned += coins;
      _user.coins += coins;
      _addXp(50);
      _user.stats.correctAnswers += 1;
    } else {
      _currentStreak = 0;
      _user.coins += 10;
      _sessionCoinsEarned += 10;
      _addXp(15);
    }

    notifyListeners();
    _saveToPrefs();
    return isCorrect;
  }

  void nextQuestion() {
    _currentQuestionIndex += 1;
    _resetJokersForQuestion();
    notifyListeners();
  }

  void finishQuizSession() {
    _user.stats.quizzesPlayed += 1;
    _user.stats.totalScore += _currentScore;
    if (_maxStreakInSession > _user.stats.maxStreak) {
      _user.stats.maxStreak = _maxStreakInSession;
    }
    notifyListeners();
    _saveToPrefs();
  }

  void _addXp(int amount) {
    _user.currentXp += amount;
    while (_user.currentXp >= _user.nextLevelXp) {
      _user.currentXp -= _user.nextLevelXp;
      _user.level += 1;
      _user.nextLevelXp = (_user.nextLevelXp * 1.35).round();
      _user.coins += 150; // Level up reward
    }
  }

  // Jokers
  bool useFiftyFifty() {
    if ((_inventory['50_50'] ?? 0) <= 0 || _isFiftyFiftyUsed) return false;
    final q = currentQuestion;
    if (q == null) return false;

    _inventory['50_50'] = (_inventory['50_50']! - 1);
    _isFiftyFiftyUsed = true;

    final wrongIndices = [0, 1, 2, 3]..remove(q.correctOptionIndex);
    wrongIndices.shuffle();
    _disabledOptionIndices = wrongIndices.take(2).toList();

    notifyListeners();
    return true;
  }

  bool useHint() {
    if ((_inventory['hint'] ?? 0) <= 0 || _isHintUsed) return false;
    final q = currentQuestion;
    if (q == null) return false;

    _inventory['hint'] = (_inventory['hint']! - 1);
    _isHintUsed = true;
    _hintText = q.explanation;
    notifyListeners();
    return true;
  }

  bool useChangeQuestion() {
    if ((_inventory['change_question'] ?? 0) <= 0) return false;
    final q = currentQuestion;
    if (q == null) return false;

    _inventory['change_question'] = (_inventory['change_question']! - 1);

    // Find a replacement question not already in current session
    final candidates = kQuestionsList
        .where((item) => item.category == _activeCategory && item.id != q.id)
        .toList();
    if (candidates.isNotEmpty) {
      candidates.shuffle();
      _currentQuizQuestions[_currentQuestionIndex] = candidates.first;
    }
    _resetJokersForQuestion();
    notifyListeners();
    return true;
  }

  bool buyShopItem(String itemId, int price) {
    if (_user.coins < price) return false;

    _user.coins -= price;
    _inventory[itemId] = (_inventory[itemId] ?? 0) + 1;
    notifyListeners();
    _saveToPrefs();
    return true;
  }

  void addCoins(int amount) {
    _user.coins += amount;
    notifyListeners();
    _saveToPrefs();
  }
}
