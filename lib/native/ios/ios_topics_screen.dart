import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../data/topic_sort.dart';
import '../../shared/format.dart';
import '../settings_buttons.dart';
import 'ios_topic_screen.dart';

class IosTopicsScreen extends StatefulWidget {
  const IosTopicsScreen({super.key, required this.fixtures});

  final QuizupFixtures fixtures;

  @override
  State<IosTopicsScreen> createState() => _IosTopicsScreenState();
}

class _IosTopicsScreenState extends State<IosTopicsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  TopicSort _sort = TopicSort.popular;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Topic> get _filtered {
    final query = _query.trim().toLowerCase();
    final result = widget.fixtures.topics.where((topic) {
      return query.isEmpty ||
          topic.name.toLowerCase().contains(query) ||
          topic.category.toLowerCase().contains(query);
    }).toList();
    return applyTopicSort(result, _sort);
  }

  @override
  Widget build(BuildContext context) {
    final topics = _filtered;
    return cupertino.CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const cupertino.CupertinoSliverNavigationBar(
            largeTitle: Text('Sujets'),
            trailing: IosSettingsButton(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: cupertino.CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Rechercher un sujet',
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: cupertino.CupertinoSlidingSegmentedControl<TopicSort>(
                groupValue: _sort,
                children: {
                  for (final sort in TopicSort.values) sort: Text(sort.label),
                },
                onValueChanged: (value) {
                  if (value != null) {
                    setState(() => _sort = value);
                  }
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text(
                '${topics.length} sujet${topics.length > 1 ? 's' : ''}',
              ),
            ),
          ),
          if (topics.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Text('Aucun sujet ne correspond.')),
              ),
            )
          else
            SliverToBoxAdapter(
              child: cupertino.CupertinoListSection.insetGrouped(
                children: [
                  for (final topic in topics)
                    cupertino.CupertinoListTile(
                      key: ValueKey('topic-${topic.id}'),
                      leading: SizedBox(
                        width: 44,
                        height: 44,
                        child: Image.asset(topic.image, fit: BoxFit.cover),
                      ),
                      title: Text(topic.name),
                      subtitle: Text(
                        '${topic.category} · '
                        '${compactNumber(topic.games)} parties',
                      ),
                      trailing: const cupertino.CupertinoListTileChevron(),
                      onTap: () {
                        Navigator.of(context).push(
                          cupertino.CupertinoPageRoute<void>(
                            builder: (_) => IosTopicScreen(
                              fixtures: widget.fixtures,
                              topic: topic,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
