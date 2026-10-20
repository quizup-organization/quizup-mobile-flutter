import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../shared/format.dart';
import '../tokens.dart';
import 'avatar.dart';
import 'quizup_text.dart';

Color rankColor(int rank) {
  switch (rank) {
    case 1:
      return const Color(0xFFF5B301);
    case 2:
      return const Color(0xFFA7B0BE);
    case 3:
      return const Color(0xFFC77A3A);
    default:
      return const Color(0xFF737373);
  }
}

class LeaderboardRow extends StatelessWidget {
  const LeaderboardRow({
    super.key,
    required this.entry,
    this.isMe = false,
  });

  final LeaderboardEntry entry;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: isMe
            ? tokens.colors.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: isMe
            ? Border.all(
                color: tokens.colors.primary.withValues(alpha: 0.18),
              )
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: QuizupText(
              '${entry.rank}',
              size: 13,
              weight: FontWeight.w700,
              color: rankColor(entry.rank),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          QuizupAvatar(
            name: entry.name,
            color: entry.color,
            size: 36,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                QuizupText(
                  isMe ? '${entry.name} (toi)' : entry.name,
                  size: 13,
                  weight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                QuizupText(
                  'Niveau ${entry.level}',
                  size: 11,
                  weight: FontWeight.w400,
                  color: tokens.colors.mutedForeground,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          QuizupText(
            '${compactNumber(entry.xp)} XP',
            size: 12,
            weight: FontWeight.w600,
            color: tokens.colors.mutedForeground,
          ),
        ],
      ),
    );
  }
}

class LeaderboardPodium extends StatelessWidget {
  const LeaderboardPodium({super.key, required this.entries});

  final List<LeaderboardEntry> entries;

  @override
  Widget build(BuildContext context) {
    final top = entries.take(3).toList(growable: false);
    if (top.length < 3) {
      return const SizedBox.shrink();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: _PodiumItem(entry: top[1], avatarSize: 52)),
        Expanded(child: _PodiumItem(entry: top[0], avatarSize: 64, first: true)),
        Expanded(child: _PodiumItem(entry: top[2], avatarSize: 52)),
      ],
    );
  }
}

class _PodiumItem extends StatelessWidget {
  const _PodiumItem({
    required this.entry,
    required this.avatarSize,
    this.first = false,
  });

  final LeaderboardEntry entry;
  final double avatarSize;
  final bool first;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: first ? 10 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (first)
            const Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.emoji_events_rounded,
                size: 18,
                color: Color(0xFFF5B301),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: QuizupText(
                '#${entry.rank}',
                size: 12,
                weight: FontWeight.w700,
                color: rankColor(entry.rank),
              ),
            ),
          QuizupAvatar(
            name: entry.name,
            color: entry.color,
            size: avatarSize,
            showBorder: true,
            borderColor: rankColor(entry.rank),
          ),
          const SizedBox(height: 6),
          QuizupText(
            entry.name,
            size: 12,
            weight: FontWeight.w600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          QuizupText(
            '${compactNumber(entry.xp)} XP',
            size: 10,
            weight: FontWeight.w500,
            color: tokens.colors.mutedForeground,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
