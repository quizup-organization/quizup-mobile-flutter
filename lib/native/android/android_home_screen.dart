import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../shared/format.dart';
import '../settings_buttons.dart';
import 'android_topic_screen.dart';

class AndroidHomeScreen extends StatelessWidget {
  const AndroidHomeScreen({super.key, required this.fixtures});

  final QuizupFixtures fixtures;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Accueil'),
          actions: [AndroidSettingsButton()],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
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
          ]),
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        for (final topic in topics)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              key: ValueKey('$keyPrefix-${topic.id}'),
              leading: SizedBox(
                width: 48,
                height: 48,
                child: Image.asset(topic.image, fit: BoxFit.cover),
              ),
              title: Text(topic.name),
              subtitle: Text(
                '${topic.category} · '
                '${compactNumber(topic.followers)} abonnés',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => AndroidTopicScreen(
                      fixtures: fixtures,
                      topic: topic,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
