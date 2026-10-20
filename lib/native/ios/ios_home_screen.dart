import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../shared/format.dart';
import '../settings_buttons.dart';
import 'ios_topic_screen.dart';

class IosHomeScreen extends StatelessWidget {
  const IosHomeScreen({super.key, required this.fixtures});

  final QuizupFixtures fixtures;

  @override
  Widget build(BuildContext context) {
    return cupertino.CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const cupertino.CupertinoSliverNavigationBar(
            largeTitle: Text('Accueil'),
            trailing: IosSettingsButton(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _TopicSection(
                  title: 'Top 10 du moment',
                  topics: fixtures.home.trending,
                  keyPrefix: 'trending',
                  fixtures: fixtures,
                ),
                _TopicSection(
                  title: 'Tes sujets suivis',
                  topics: fixtures.home.followed,
                  keyPrefix: 'followed',
                  fixtures: fixtures,
                ),
                _TopicSection(
                  title: 'Nouveaux thèmes',
                  topics: fixtures.home.newTopics,
                  keyPrefix: 'new',
                  fixtures: fixtures,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicSection extends StatelessWidget {
  const _TopicSection({
    required this.title,
    required this.topics,
    required this.keyPrefix,
    required this.fixtures,
  });

  final String title;
  final List<Topic> topics;
  final String keyPrefix;
  final QuizupFixtures fixtures;

  @override
  Widget build(BuildContext context) {
    return cupertino.CupertinoListSection.insetGrouped(
      header: Text(title),
      children: [
        for (final topic in topics)
          cupertino.CupertinoListTile(
            key: ValueKey('$keyPrefix-${topic.id}'),
            leading: SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(topic.image, fit: BoxFit.cover),
            ),
            title: Text(topic.name),
            subtitle: Text(
              '${topic.category} · ${compactNumber(topic.followers)} abonnés',
            ),
            trailing: const cupertino.CupertinoListTileChevron(),
            onTap: () {
              Navigator.of(context).push(
                cupertino.CupertinoPageRoute<void>(
                  builder: (_) => IosTopicScreen(
                    fixtures: fixtures,
                    topic: topic,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
