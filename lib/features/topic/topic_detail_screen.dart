import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../design/adaptive/adaptive_button.dart';
import '../../design/adaptive/adaptive_icon_button.dart';
import '../../design/adaptive/adaptive_scaffold.dart';
import '../../design/adaptive/adaptive_segmented_control.dart';
import '../../design/components/leaderboard_row.dart';
import '../../design/components/progress_bar.dart';
import '../../design/components/quizup_button.dart';
import '../../design/components/quizup_card.dart';
import '../../design/components/quizup_text.dart';
import '../../design/components/segmented_control.dart';
import '../../design/components/stat_strip.dart';
import '../../design/tokens.dart';
import '../../shared/format.dart';

enum TopicTab {
  overview('Aperçu'),
  leaderboard('Classement');

  const TopicTab(this.label);

  final String label;
}

class TopicDetailScreen extends StatefulWidget {
  const TopicDetailScreen({
    super.key,
    required this.overview,
    required this.onStartDuel,
  });

  final TopicOverview overview;
  final VoidCallback onStartDuel;

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  bool _following = false;
  TopicTab _tab = TopicTab.overview;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final topic = widget.overview.topic;

    return AdaptiveScaffold(
      title: topic.name,
      subtitle: topic.category,
      showBack: true,
      showNav: false,
      actions: [
        AdaptiveIconButton(
          icon: Icons.ios_share_rounded,
          tooltip: 'Partager',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Lien du sujet copié.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
        children: [
          _TopicHeader(
            topic: topic,
            following: _following,
            onToggleFollow: () => setState(() => _following = !_following),
          ),
          const SizedBox(height: 14),
          AdaptiveSegmentedControl<TopicTab>(
            segments: [
              for (final tab in TopicTab.values)
                QuizupSegment(value: tab, label: tab.label),
            ],
            selected: _tab,
            onChanged: (value) => setState(() => _tab = value),
          ),
          const SizedBox(height: 14),
          if (_tab == TopicTab.overview) ...[
            QuizupCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              radius: 18,
              child: StatStrip(
                items: [
                  StatItem(
                    value: compactNumber(widget.overview.stats.followers),
                    label: 'abonnés',
                  ),
                  StatItem(
                    value: compactNumber(widget.overview.stats.games),
                    label: 'parties',
                  ),
                  StatItem(
                    value: '#${widget.overview.stats.myRank}',
                    label: 'ton rang',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _MasteryCard(mastery: widget.overview.mastery),
            const SizedBox(height: 14),
            AdaptiveButton(
              key: const ValueKey('start-duel'),
              label: 'Lancer un duel',
              icon: Icons.bolt_rounded,
              size: QuizupButtonSize.lg,
              expand: true,
              onPressed: widget.onStartDuel,
            ),
            const SizedBox(height: 14),
            QuizupCard(
              padding: const EdgeInsets.all(16),
              radius: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuizupText(
                    'À propos',
                    size: 14,
                    weight: FontWeight.w700,
                  ),
                  const SizedBox(height: 6),
                  QuizupText(
                    topic.description,
                    size: 13,
                    color: tokens.colors.mutedForeground,
                    height: 1.45,
                  ),
                ],
              ),
            ),
          ] else ...[
            QuizupCard(
              padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
              radius: 18,
              child: Column(
                children: [
                  LeaderboardPodium(entries: widget.overview.leaderboard),
                  const SizedBox(height: 10),
                  Divider(color: tokens.colors.border, height: 1),
                  const SizedBox(height: 4),
                  for (final entry in widget.overview.leaderboard.skip(3))
                    LeaderboardRow(entry: entry),
                  const SizedBox(height: 4),
                  const LeaderboardRow(
                    entry: LeaderboardEntry(
                      rank: 128,
                      name: 'Toi',
                      level: 12,
                      xp: 9340,
                      colorHex: '#1447E6',
                    ),
                    isMe: true,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TopicHeader extends StatelessWidget {
  const _TopicHeader({
    required this.topic,
    required this.following,
    required this.onToggleFollow,
  });

  final Topic topic;
  final bool following;
  final VoidCallback onToggleFollow;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return SizedBox(
      height: 196,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(topic.banner, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.86),
                  ],
                  stops: const [0.3, 1],
                ),
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QuizupText(
                          topic.category.toUpperCase(),
                          size: 10,
                          weight: FontWeight.w700,
                          color: Colors.white.withValues(alpha: 0.72),
                          letterSpacing: 0.8,
                        ),
                        const SizedBox(height: 4),
                        QuizupText(
                          topic.name,
                          size: 22,
                          weight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  AdaptiveButton(
                    key: const ValueKey('follow-topic'),
                    label: following ? 'Suivi' : 'Suivre',
                    size: QuizupButtonSize.sm,
                    variant: following
                        ? QuizupButtonVariant.outline
                        : QuizupButtonVariant.primary,
                    icon: following
                        ? Icons.check_rounded
                        : Icons.add_rounded,
                    onPressed: onToggleFollow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MasteryCard extends StatelessWidget {
  const _MasteryCard({required this.mastery});

  final Mastery mastery;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return QuizupCard(
      padding: const EdgeInsets.all(16),
      radius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: tokens.colors.warning.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: tokens.colors.warning,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuizupText(
                      'Maîtrise du sujet',
                      size: 13,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(height: 2),
                    QuizupText(
                      'Grade ${mastery.grade}',
                      size: 11,
                      color: tokens.colors.mutedForeground,
                    ),
                  ],
                ),
              ),
              QuizupText(
                '${(mastery.progress * 100).round()} %',
                size: 14,
                weight: FontWeight.w700,
                color: tokens.colors.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          QuizupProgressBar(
            value: mastery.progress,
            color: tokens.colors.warning,
          ),
          const SizedBox(height: 7),
          QuizupText(
            '${mastery.remainingXp} XP avant ${mastery.nextGrade}',
            size: 10,
            color: tokens.colors.mutedForeground,
          ),
        ],
      ),
    );
  }
}
