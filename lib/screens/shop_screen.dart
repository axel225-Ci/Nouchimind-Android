import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<ShopItem> jokers = const [
      ShopItem(
        id: '50_50',
        name: 'Joker 50:50',
        description: 'Supprime deux mauvaises réponses de l\'écran.',
        price: 150,
        type: 'lifeline',
        iconEmoji: '✂️',
      ),
      ShopItem(
        id: 'hint',
        name: 'Indice Culturel',
        description: 'Affiche un indice explicatif sur la bonne réponse.',
        price: 200,
        type: 'lifeline',
        iconEmoji: '💡',
      ),
      ShopItem(
        id: 'change_question',
        name: 'Changer de Question',
        description: 'Remplace instantanément la question actuelle par une autre.',
        price: 250,
        type: 'lifeline',
        iconEmoji: '🔄',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BOUTIQUE DE BABI',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF18181D) : Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                const Text('🟡', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  '${user.coins}',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: const Color(0xFFFFB300),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video ad bonus card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2E8B57), Color(0xFF4CAF50)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2E8B57).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 32)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vidéo Récompense',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Regarde un court clip pour gagner +150 pièces',
                          style: GoogleFonts.montserrat(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provider.addCoins(150);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('🎉 +150 pièces créditées !'),
                          backgroundColor: Color(0xFF2E8B57),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2E8B57),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'VOIR',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w900, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'JOKERS & AIDES DE JEU',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 1.0,
                color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
              ),
            ),
            const SizedBox(height: 12),

            ...jokers.map((item) {
              final count = provider.inventory[item.id] ?? 0;
              final canAfford = user.coins >= item.price;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8C42).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(item.iconEmoji, style: const TextStyle(fontSize: 26)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              item.description,
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'En réserve : $count',
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2E8B57),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: canAfford
                            ? () {
                                final success = provider.buyShopItem(item.id, item.price);
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Acheté : ${item.name} !')),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8C42),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          '${item.price} 🟡',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
