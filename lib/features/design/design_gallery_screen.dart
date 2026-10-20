import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../design/adaptive/adaptive_button.dart';
import '../../design/adaptive/adaptive_choice_chip.dart';
import '../../design/adaptive/adaptive_scaffold.dart';
import '../../design/adaptive/adaptive_search_field.dart';
import '../../design/adaptive/adaptive_segmented_control.dart';
import '../../design/components/avatar.dart';
import '../../design/components/chip.dart';
import '../../design/components/leaderboard_row.dart';
import '../../design/components/progress_bar.dart';
import '../../design/components/quizup_button.dart';
import '../../design/components/quizup_card.dart';
import '../../design/components/quizup_text.dart';
import '../../design/components/segmented_control.dart';
import '../../design/components/stat_strip.dart';
import '../../design/components/topic_media_card.dart';
import '../../design/debug/design_mode_badge.dart';
import '../../design/tokens.dart';

const _sampleTopic = Topic(
  id: 'sample',
  name: "Chefs-d'œuvre de la peinture",
  category: 'Arts',
  image: 'assets/images/starry_night.jpg',
  banner: 'assets/images/starry_night.jpg',
  colorHex: '#1447E6',
  description: 'Les tableaux qui ont marqué l’histoire du regard.',
  followers: 12840,
  games: 48210,
  recentRank: 1,
);

class DesignGalleryScreen extends StatefulWidget {
  const DesignGalleryScreen({super.key});

  @override
  State<DesignGalleryScreen> createState() => _DesignGalleryScreenState();
}

class _DesignGalleryScreenState extends State<DesignGalleryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _category = 'Arts';
  String _tab = 'Aperçu';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);

    return AdaptiveScaffold(
      title: 'Galerie design',
      subtitle: 'Composants QuizUp et natifs',
      showBack: true,
      showNav: false,
      actions: const [DesignModeBadge()],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 28),
        children: [
          QuizupText(
            'Bascule le design system en haut à droite. Les composants '
            'ci-dessous changent de peau sans changer de layout.',
            size: 12,
            color: tokens.colors.mutedForeground,
            height: 1.45,
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Typographie'),
          QuizupText('Titre d’écran', size: 26, weight: FontWeight.w800),
          const SizedBox(height: 4),
          QuizupText('Titre de section', size: 18, weight: FontWeight.w700),
          const SizedBox(height: 4),
          QuizupText(
            'Corps de texte : une phrase de quiz, lisible et compacte.',
            size: 14,
          ),
          const SizedBox(height: 4),
          QuizupText(
            'Légende secondaire, 11 px.',
            size: 11,
            color: tokens.colors.mutedForeground,
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Boutons'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AdaptiveButton(
                label: 'Principal',
                onPressed: () {},
              ),
              AdaptiveButton(
                label: 'Secondaire',
                variant: QuizupButtonVariant.secondary,
                onPressed: () {},
              ),
              AdaptiveButton(
                label: 'Contour',
                variant: QuizupButtonVariant.outline,
                onPressed: () {},
              ),
              AdaptiveButton(
                label: 'Fantôme',
                variant: QuizupButtonVariant.ghost,
                onPressed: () {},
              ),
              AdaptiveButton(
                label: 'Supprimer',
                variant: QuizupButtonVariant.destructive,
                onPressed: () {},
              ),
              const AdaptiveButton(
                label: 'Désactivé',
                onPressed: null,
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Champ de recherche'),
          AdaptiveSearchField(
            controller: _searchController,
            onFilter: () {},
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Chips'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in const [
                'Arts',
                'Nature',
                'Musique',
                'Histoire',
              ])
                AdaptiveChoiceChip(
                  label: category,
                  selected: _category == category,
                  onTap: () => setState(() => _category = category),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              QuizupChip(label: 'QuizUp chip', selected: true),
              QuizupChip(label: 'Inactif'),
            ],
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Segmented control'),
          AdaptiveSegmentedControl<String>(
            segments: const [
              QuizupSegment(value: 'Aperçu', label: 'Aperçu'),
              QuizupSegment(value: 'Classement', label: 'Classement'),
              QuizupSegment(value: 'Parties', label: 'Parties'),
            ],
            selected: _tab,
            onChanged: (value) => setState(() => _tab = value),
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Cartes de sujet'),
          SizedBox(
            height: 248,
            child: ListView(
              primary: false,
              scrollDirection: Axis.horizontal,
              children: [
                TopicMediaCard(
                  topic: _sampleTopic,
                  format: TopicCardFormat.poster,
                  rank: 1,
                ),
                const SizedBox(width: 10),
                TopicMediaCard(
                  topic: _sampleTopic,
                  format: TopicCardFormat.landscape,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Progression & statistiques'),
          QuizupCard(
            padding: const EdgeInsets.all(16),
            radius: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const QuizupText(
                      'Maîtrise du sujet',
                      size: 13,
                      weight: FontWeight.w700,
                    ),
                    const Spacer(),
                    QuizupText(
                      '68 %',
                      size: 13,
                      weight: FontWeight.w700,
                      color: tokens.colors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                QuizupProgressBar(value: 0.68, color: tokens.colors.warning),
                const SizedBox(height: 16),
                const StatStrip(
                  items: [
                    StatItem(value: '12,8 k', label: 'abonnés'),
                    StatItem(value: '48 k', label: 'parties'),
                    StatItem(value: '#128', label: 'ton rang'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _GalleryTitle('Avatars & classement'),
          Row(
            children: [
              QuizupAvatar(
                name: 'Nova',
                color: tokens.colors.primary,
                size: 44,
              ),
              const SizedBox(width: 10),
              QuizupAvatar(
                name: 'Maya',
                color: tokens.colors.win,
                size: 44,
              ),
              const SizedBox(width: 10),
              QuizupAvatar(
                name: 'Léo',
                color: tokens.colors.warning,
                size: 44,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const QuizupCard(
            padding: EdgeInsets.all(8),
            radius: 18,
            child: Column(
              children: [
                LeaderboardRow(
                  entry: LeaderboardEntry(
                    rank: 1,
                    name: 'Nova',
                    level: 42,
                    xp: 18420,
                    colorHex: '#1447E6',
                  ),
                ),
                LeaderboardRow(
                  entry: LeaderboardEntry(
                    rank: 2,
                    name: 'Léo',
                    level: 38,
                    xp: 16110,
                    colorHex: '#00A63E',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryTitle extends StatelessWidget {
  const _GalleryTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: QuizupText(title, size: 16, weight: FontWeight.w700),
    );
  }
}
