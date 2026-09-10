# NouchiMind - Projet Flutter (Dart) pour Android Studio

Voici le projet complet de l'application **NouchiMind** réécrit en **Dart / Flutter**, prêt à être importé et exécuté directement dans **Android Studio**.

---

## 📁 Structure du Projet Flutter

```
flutter_nouchimind/
├── pubspec.yaml                 # Dépendances Flutter & assets
├── README.md                    # Guide d'installation et de lancement
└── lib/
    ├── main.dart                # Point d'entrée, Thèmes Clair/Sombre, Shell de navigation
    ├── models/
    │   └── models.dart          # Modèles de données (Quiz, Profil, Catégories, Jokers)
    ├── data/
    │   └── questions_data.dart  # Banque de questions ivoiriennes & Nouchi
    ├── providers/
    │   └── app_provider.dart    # State management Provider (Score, XP, Pièces, Jokers, Thème)
    └── screens/
        ├── home_screen.dart     # Accueil, Progression, Défi du jour, Récompense quotidienne
        ├── quiz_screen.dart     # Écran de quiz (Timer 30s, Jokers 50:50 / Indice / Changer, Explications)
        ├── result_screen.dart   # Bilan de fin de niveau (XP, Pièces, Série, Rejouer)
        ├── category_screen.dart # Liste des thèmes de quiz avec verrouillage par niveau
        ├── leaderboard_screen.dart # Podium et classement des joueurs
        ├── shop_screen.dart     # Boutique d'achat de jokers et récompense vidéo
        ├── profile_screen.dart  # Profil du joueur, statistiques et avatar
        └── settings_screen.dart # Thèmes (Clair, Sombre, Système), sons
```

---

## 🚀 Comment l'ouvrir et le lancer dans Android Studio

### Étape 1 : Créer un projet Flutter dans Android Studio
1. Ouvre **Android Studio**.
2. Clique sur **File > New > New Flutter Project** (ou exécute `flutter create nouchimind` dans ton terminal).
3. Sélectionne le chemin de ton SDK Flutter.

### Étape 2 : Copier les fichiers
1. Remplace le fichier `pubspec.yaml` de ton nouveau projet par celui du dossier `flutter_nouchimind/pubspec.yaml`.
2. Remplace le dossier `lib` de ton nouveau projet par le dossier `flutter_nouchimind/lib/`.

### Étape 3 : Installer les dépendances
Dans le terminal d'Android Studio (ou via le bouton en haut du `pubspec.yaml`) :
```bash
flutter pub get
```

### Étape 4 : Lancer l'application
1. Connecte un smartphone Android (avec le débogage USB activé) ou démarre un émulateur Android depuis **Device Manager**.
2. Clique sur le bouton vert **Play (Run)** dans Android Studio ou tape :
```bash
flutter run
```

---

## ✨ Fonctionnalités Incluses en Dart
- **Thème Clair, Sombre et Système** configurables dans les paramètres.
- **Timer interactif de 30 secondes** par question.
- **Jokers fonctionnels** : 50/50, Indice explicatif, Changer de question.
- **Banque de questions culturelles** (Nouchi, Culture, Musique, Gastronomie, Football).
- **Système de progression** : Niveaux, points d'expérience (XP), pièces dorées.
- **Persistance locale** avec `SharedPreferences`.
