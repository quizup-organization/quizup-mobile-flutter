import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../shared/format.dart';
import '../settings_buttons.dart';
import 'android_duel_screen.dart';

class AndroidTopicScreen extends StatelessWidget {
  const AndroidTopicScreen({
    super.key,
    required this.fixtures,
    required this.topic,
  });

  final QuizupFixtures fixtures;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final overview = TopicOverview(
      topic: topic,
      stats: fixtures.overview.stats,
      mastery: fixtures.overview.mastery,
      leaderboard: fixtures.overview.leaderboard,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              topic.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: const [AndroidSettingsButton()],
          ),
          SliverToBoxAdapter(
            child: Image.asset(
              topic.banner,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.people_outline),
                    title: const Text('Abonnés'),
                    trailing: Text(compactNumber(overview.stats.followers)),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.play_circle_outline),
                    title: const Text('Parties'),
                    trailing: Text(compactNumber(overview.stats.games)),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.leaderboard_outlined),
                    title: const Text('Ton rang'),
                    trailing: Text('#${overview.stats.myRank}'),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.workspace_premium_outlined),
                    title: const Text('Grade'),
                    trailing: Text(overview.mastery.grade),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.trending_up),
                    title: const Text('Progression'),
                    trailing: Text(
                      '${(overview.mastery.progress * 100).round()} %',
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.flag_outlined),
                    title: const Text('Prochain grade'),
                    subtitle: Text(
                      '${overview.mastery.remainingXp} XP avant '
                      '${overview.mastery.nextGrade}',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  key: const ValueKey('start-duel'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => AndroidDuelScreen(
                          fixture: fixtures.duel,
                        ),
                      ),
                    );
                  },
                  child: const Text('Lancer un duel'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  for (final entry in overview.leaderboard)
                    ListTile(
                      leading: CircleAvatar(child: Text('${entry.rank}')),
                      title: Text(entry.name),
                      subtitle: Text('Niveau ${entry.level}'),
                      trailing: Text('${compactNumber(entry.xp)} XP'),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('À propos'),
                subtitle: Text(topic.description),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
