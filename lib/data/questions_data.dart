import '../models/models.dart';

const List<CategoryItem> kCategoriesList = [
  CategoryItem(
    id: 'culture',
    name: 'Culture Générale Ivoirienne',
    description: 'Histoire, géographie, traditions, symboles de la Côte d\'Ivoire.',
    unlockLevel: 1,
    colorHex: 0xFFFF8C42,
  ),
  CategoryItem(
    id: 'music',
    name: 'Musique & Coupé-Décalé',
    description: 'Zouglou, Coupé-Décalé, DJ Arafat, Magic System, rap ivoire.',
    unlockLevel: 1,
    colorHex: 0xFFFFD700,
  ),
  CategoryItem(
    id: 'nouchi',
    name: 'Langage Nouchi & Expressions',
    description: 'Le dictionnaire urbain d\'Abidjan, argot et répliques cultes.',
    unlockLevel: 1,
    isNew: true,
    colorHex: 0xFF2E8B57,
  ),
  CategoryItem(
    id: 'food',
    name: 'Gastronomie & Maquis',
    description: 'Garba, Alloco, Foutou, Kédjénou, Attiéké et saveurs du terroir.',
    unlockLevel: 2,
    colorHex: 0xFFE65100,
  ),
  CategoryItem(
    id: 'football',
    name: 'Éléphants & Sport Ivoirien',
    description: 'CAN 2023/2024, Didier Drogba, exploits et légendes du sport.',
    unlockLevel: 3,
    colorHex: 0xFF00897B,
  ),
];

const List<QuizQuestion> kQuestionsList = [
  // Culture
  QuizQuestion(
    id: 'cult_1',
    category: 'Culture Générale Ivoirienne',
    question: 'Quelle est la capitale politique et administrative officielle de la Côte d\'Ivoire ?',
    options: ['Abidjan', 'Yamoussoukro', 'Bouaké', 'San-Pédro'],
    correctOptionIndex: 1,
    explanation: 'Yamoussoukro est la capitale politique depuis 1983, bien qu\'Abidjan demeure le poumon économique.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'cult_2',
    category: 'Culture Générale Ivoirienne',
    question: 'Quel est l\'animal emblématique national figurant sur les armoiries de la Côte d\'Ivoire ?',
    options: ['Le Lion', 'L\'Éléphant', 'Le Léopard', 'L\'Aigle'],
    correctOptionIndex: 1,
    explanation: 'L\'éléphant est le symbole national majeur de la Côte d\'Ivoire, qui donne aussi le nom à l\'équipe sportive.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'cult_3',
    category: 'Culture Générale Ivoirienne',
    question: 'Dans quelle ville ivoirienne se trouve la célèbre Basilique Notre-Dame de la Paix ?',
    options: ['Abidjan', 'Yamoussoukro', 'Grand-Bassam', 'Korhogo'],
    correctOptionIndex: 1,
    explanation: 'Édifiée par le président Félix Houphouët-Boigny à Yamoussoukro, elle compte parmi les plus grands édifices religieux au monde.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'cult_4',
    category: 'Culture Générale Ivoirienne',
    question: 'Quelle ancienne ville côtière est classée au patrimoine mondial de l\'UNESCO en Côte d\'Ivoire ?',
    options: ['Assinie', 'Grand-Bassam', 'Sassandra', 'Jacqueville'],
    correctOptionIndex: 1,
    explanation: 'Grand-Bassam, première capitale coloniale de 1893 à 1900, est classée pour son architecture historique.',
    difficulty: 2,
  ),

  // Nouchi
  QuizQuestion(
    id: 'nou_1',
    category: 'Langage Nouchi & Expressions',
    question: 'Que signifie précisément l\'expression Nouchi "Mettre le gbê" ?',
    options: ['Faire la fête', 'Dire la vérité sans détour', 'Prêter de l\'argent', 'Prendre la fuite'],
    correctOptionIndex: 1,
    explanation: '"Mettre le gbê", c\'est dire la vérité crue, parler franchement sans hypocrisie.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'nou_2',
    category: 'Langage Nouchi & Expressions',
    question: 'En nouchi ivoirien, que désigne le mot "Mogoy" ou "Mogo" ?',
    options: ['Une voiture', 'Une personne / un ami / un type', 'Un plat de nourriture', 'Un billet de banque'],
    correctOptionIndex: 1,
    explanation: '"Mogo" ou "Mogoy" signifie quelqu\'un, une personne, un ami ou un gars en argot ivoirien.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'nou_3',
    category: 'Langage Nouchi & Expressions',
    question: 'Quand un Abidjanais dit "Je vais m\'enjailler", que compte-t-il faire ?',
    options: ['Aller dormir', 'Se disputer', 'Se faire plaisir et s\'amuser', 'Aller travailler'],
    correctOptionIndex: 2,
    explanation: '"S\'enjailler" signifie kiffer, faire la fête, prendre du bon temps.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'nou_4',
    category: 'Langage Nouchi & Expressions',
    question: 'Que signifie l\'expression nouchi "Casser les papos" ?',
    options: ['Révéler des secrets / commérer', 'Danser le coupé-décalé', 'Détruire du matériel', 'Payer l\'addition'],
    correctOptionIndex: 0,
    explanation: '"Casser les papos", c\'est divulguer des ragots, des secrets ou raconter les affaires d\'autrui.',
    difficulty: 2,
  ),

  // Musique
  QuizQuestion(
    id: 'mus_1',
    category: 'Musique & Coupé-Décalé',
    question: 'Quel artiste ivoirien mondialement célèbre était surnommé le "Daïshikan" ou "Yorobo" ?',
    options: ['Serge Beynaud', 'DJ Arafat', 'Debordo Leekunfa', 'Bebi Philip'],
    correctOptionIndex: 1,
    explanation: 'Ange Didier Houon, dit DJ Arafat, était le roi incontesté du Coupé-Décalé avec une immense communauté.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'mus_2',
    category: 'Musique & Coupé-Décalé',
    question: 'Quel groupe mythique d\'Anoumabo a fait danser le monde entier avec "Premier Gaou" ?',
    options: ['Les Salopards', 'Magic System', 'Yodé & Siro', 'Espoir 2000'],
    correctOptionIndex: 1,
    explanation: 'Magic System, emmené par A\'salfo, a propulsé le Zouglou au sommet des hit-parades internationaux.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'mus_3',
    category: 'Musique & Coupé-Décalé',
    question: 'Quel genre musical ivoirien est né dans les cités universitaires d\'Abidjan au début des années 1990 ?',
    options: ['Le Coupé-Décalé', 'Le Zouglou', 'L\'Afrobeats', 'Le Ziglibithy'],
    correctOptionIndex: 1,
    explanation: 'Le Zouglou est né sur le campus de Yopougon comme voix revendicatrice des étudiants avec Bilé Didier.',
    difficulty: 1,
  ),

  // Gastronomie
  QuizQuestion(
    id: 'food_1',
    category: 'Gastronomie & Maquis',
    question: 'De quoi est principalement composé le célèbre "Garba" ivoirien ?',
    options: [
      'Attiéké et poisson thon frit',
      'Foutou banane et sauce graine',
      'Riz gras et poulet braisé',
      'Alloco et œufs durs'
    ],
    correctOptionIndex: 0,
    explanation: 'Le Garba est le repas populaire par excellence à Abidjan : semoule de manioc (attiéké) avec pavé de thon frit pimenté.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'food_2',
    category: 'Gastronomie & Maquis',
    question: 'Avec quoi est confectionné le véritable "Alloco" ?',
    options: ['Des bananes plantains mûres frites', 'Des pommes de terre douces', 'Du manioc vapeur', 'Des ignames bouillies'],
    correctOptionIndex: 0,
    explanation: 'L\'Alloco est fait de bananes plantains bien mûres découpées en dés et dorées à l\'huile chaude.',
    difficulty: 1,
  ),

  // Football
  QuizQuestion(
    id: 'foot_1',
    category: 'Éléphants & Sport Ivoirien',
    question: 'En quelle année la Côte d\'Ivoire a-t-elle remporté sa 3e Coupe d\'Afrique des Nations (CAN) à domicile ?',
    options: ['2015', '2019', '2024 (CAN 2023 jouée en 2024)', '2012'],
    correctOptionIndex: 2,
    explanation: 'Au terme d\'un parcours miraculeux, les Éléphants ont conquis leur 3e étoile en février 2024 à Abidjan.',
    difficulty: 1,
  ),
  QuizQuestion(
    id: 'foot_2',
    category: 'Éléphants & Sport Ivoirien',
    question: 'Quel attaquant légendaire de Chelsea est le meilleur buteur de l\'histoire de la sélection ivoirienne ?',
    options: ['Salomon Kalou', 'Didier Drogba', 'Wilfried Bony', 'Sébastien Haller'],
    correctOptionIndex: 1,
    explanation: 'Didier Drogba totalise 65 buts en 105 sélections sous le maillot orange des Éléphants.',
    difficulty: 1,
  ),
];
