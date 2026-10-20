import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../shared/format.dart';
import '../settings_buttons.dart';
import 'ios_duel_screen.dart';

class IosTopicScreen extends StatelessWidget {
  const IosTopicScreen({
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

    return cupertino.CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          cupertino.CupertinoSliverNavigationBar(
            largeTitle: Text(
              topic.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const IosSettingsButton(),
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
            child: cupertino.CupertinoListSection.insetGrouped(
              header: const Text('Statistiques'),
              children: [
                cupertino.CupertinoListTile(
                  title: const Text('Abonnés'),
                  trailing: Text(compactNumber(overview.stats.followers)),
                ),
                cupertino.CupertinoListTile(
                  title: const Text('Parties'),
                  trailing: Text(compactNumber(overview.stats.games)),
                ),
                cupertino.CupertinoListTile(
                  title: const Text('Ton rang'),
                  trailing: Text('#${overview.stats.myRank}'),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: cupertino.CupertinoListSection.insetGrouped(
              header: const Text('Maîtrise'),
              children: [
                cupertino.CupertinoListTile(
                  title: const Text('Grade'),
                  trailing: Text(overview.mastery.grade),
                ),
                cupertino.CupertinoListTile(
                  title: const Text('Progression'),
                  trailing: Text(
                    '${(overview.mastery.progress * 100).round()} %',
                  ),
                ),
                cupertino.CupertinoListTile(
                  title: const Text('Prochain grade'),
                  subtitle: Text(
                    '${overview.mastery.remainingXp} XP avant '
                    '${overview.mastery.nextGrade}',
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                width: double.infinity,
                child: cupertino.CupertinoButton.filled(
                  key: const ValueKey('start-duel'),
                  onPressed: () {
                    Navigator.of(context).push(
                      cupertino.CupertinoPageRoute<void>(
                        builder: (_) => IosDuelScreen(
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
            child: cupertino.CupertinoListSection.insetGrouped(
              header: const Text('Classement'),
              children: [
                for (final entry in overview.leaderboard)
                  cupertino.CupertinoListTile(
                    leading: const Icon(
                      cupertino.CupertinoIcons.person_crop_circle_fill,
                      size: 32,
                    ),
                    title: Text(entry.name),
                    subtitle: Text('Niveau ${entry.level}'),
                    trailing: Text('${compactNumber(entry.xp)} XP'),
                  ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: cupertino.CupertinoListSection.insetGrouped(
              header: const Text('À propos'),
              children: [
                cupertino.CupertinoListTile(title: Text(topic.description)),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
