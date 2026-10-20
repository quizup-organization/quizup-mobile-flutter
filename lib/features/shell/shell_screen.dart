import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../design/adaptive/adaptive_scaffold.dart';
import '../../design/app_settings.dart';
import '../../design/debug/design_mode_badge.dart';
import '../design/design_gallery_screen.dart';
import '../duel/duel_screen.dart';
import '../home/home_screen.dart';
import '../placeholder/placeholder_screen.dart';
import '../topic/topic_detail_screen.dart';
import '../topics/topics_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key, required this.fixtures});

  final QuizupFixtures fixtures;

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;

  static const _titles = [
    ('Accueil', 'Ta dose de culture'),
    ('Sujets', 'Explore le catalogue'),
    ('Social', 'Abonnements, défis et salons'),
    ('Notifications', 'Ton inbox'),
    ('Profil', 'Ta progression'),
  ];

  void _openTopic(Topic topic) {
    final overview = TopicOverview(
      topic: topic,
      stats: widget.fixtures.overview.stats,
      mastery: widget.fixtures.overview.mastery,
      leaderboard: widget.fixtures.overview.leaderboard,
    );
    _push(
      TopicDetailScreen(
        overview: overview,
        onStartDuel: _openDuel,
      ),
    );
  }

  void _openDuel() {
    _push(DuelScreen(fixture: widget.fixtures.duel));
  }

  void _openGallery() {
    _push(const DesignGalleryScreen());
  }

  void _push(Widget page) {
    final settings = AppSettingsScope.of(context);
    final route = settings.isPlatformMode && settings.isIOS
        ? cupertino.CupertinoPageRoute<void>(builder: (_) => page)
        : MaterialPageRoute<void>(builder: (_) => page);
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final title = _titles[_index];

    return AdaptiveScaffold(
      title: title.$1,
      subtitle: title.$2,
      currentIndex: _index,
      onTabSelected: (index) => setState(() => _index = index),
      actions: [
        DesignModeBadge(onOpenGallery: _openGallery),
      ],
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(
            home: widget.fixtures.home,
            onOpenTopic: _openTopic,
            onExplore: () => setState(() => _index = 1),
          ),
          TopicsScreen(
            topics: widget.fixtures.topics,
            onOpenTopic: _openTopic,
          ),
          const PlaceholderScreen(
            icon: Icons.people_outline_rounded,
            title: 'Social',
            message: 'Abonnements, abonnés, défis et salons : '
                'hors périmètre de ce PoC visuel.',
          ),
          const PlaceholderScreen(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            message: 'L’inbox et les préférences seront branchées '
                'dans une tranche fonctionnelle.',
          ),
          const PlaceholderScreen(
            icon: Icons.person_outline_rounded,
            title: 'Profil',
            message: 'La progression, les badges et les réglages '
                'arrivent après la validation visuelle.',
          ),
        ],
      ),
    );
  }
}
