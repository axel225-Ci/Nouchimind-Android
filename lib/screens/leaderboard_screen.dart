import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<LeaderboardPlayer> players = [
      const LeaderboardPlayer(rank: 1, name: 'Aïcha_Cocody', avatar: '👑', xp: 4850),
      const LeaderboardPlayer(rank: 2, name: 'Kouassi_Pro', avatar: '🦁', xp: 4120),
      const LeaderboardPlayer(rank: 3, name: 'Moussa_Yop', avatar: '⚡', xp: 3780),
      LeaderboardPlayer(
        rank: 4,
        name: '${user.pseudo} (Toi)',
        avatar: user.avatarUrl,
        xp: user.stats.totalScore * 50 + user.currentXp,
        isMe: true,
      ),
      const LeaderboardPlayer(rank: 5, name: 'Fanta_Babi', avatar: '🌺', xp: 2900),
      const LeaderboardPlayer(rank: 6, name: 'Drogba_Fan', avatar: '⚽', xp: 2450),
      const LeaderboardPlayer(rank: 7, name: 'Yao_Zouglou', avatar: '🔥', xp: 1980),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CLASSEMENT DES MOGOYS',
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
        itemCount: players.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final player = players[index];
          final isTop3 = player.rank <= 3;

          Color rankColor = isDark ? Colors.white60 : Colors.black54;
          if (player.rank == 1) rankColor = const Color(0xFFFFD700);
          if (player.rank == 2) rankColor = const Color(0xFFC0C0C0);
          if (player.rank == 3) rankColor = const Color(0xFFCD7F32);

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: player.isMe
                  ? const Color(0xFFFF8C42).withOpacity(0.15)
                  : (isDark ? const Color(0xFF1A1A22) : Colors.white),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: player.isMe
                    ? const Color(0xFFFF8C42)
                    : (isDark ? Colors.white12 : Colors.black.withOpacity(0.06)),
                width: player.isMe ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  child: Text(
                    '#${player.rank}',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      fontSize: isTop3 ? 16 : 14,
                      color: rankColor,
                    ),
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(player.avatar, style: const TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.name,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: player.isMe ? const Color(0xFFFF8C42) : null,
                        ),
                      ),
                      Text(
                        '${player.xp} XP',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: isDark ? Colors.white60 : const Color(0xFF6B6B78),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isTop3)
                  Text(
                    player.rank == 1 ? '🥇' : (player.rank == 2 ? '🥈' : '🥉'),
                    style: const TextStyle(fontSize: 20),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
