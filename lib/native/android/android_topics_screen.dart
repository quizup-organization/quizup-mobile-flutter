import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../data/topic_sort.dart';
import '../../shared/format.dart';
import '../settings_buttons.dart';
import 'android_topic_screen.dart';

class AndroidTopicsScreen extends StatefulWidget {
  const AndroidTopicsScreen({super.key, required this.fixtures});

  final QuizupFixtures fixtures;

  @override
  State<AndroidTopicsScreen> createState() => _AndroidTopicsScreenState();
}

class _AndroidTopicsScreenState extends State<AndroidTopicsScreen> {
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
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Sujets'),
          actions: [AndroidSettingsButton()],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Rechercher un sujet',
              leading: const Icon(Icons.search),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: SegmentedButton<TopicSort>(
              segments: [
                for (final sort in TopicSort.values)
                  ButtonSegment<TopicSort>(
                    value: sort,
                    label: Text(sort.label),
                  ),
              ],
              selected: {_sort},
              onSelectionChanged: (selection) {
                if (selection.isNotEmpty) {
                  setState(() => _sort = selection.first);
                }
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              '${topics.length} sujet${topics.length > 1 ? 's' : ''}',
              style: Theme.of(context).textTheme.bodyMedium,
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final topic = topics[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    key: ValueKey('topic-${topic.id}'),
                    leading: SizedBox(
                      width: 48,
                      height: 48,
                      child: Image.asset(topic.image, fit: BoxFit.cover),
                    ),
                    title: Text(topic.name),
                    subtitle: Text(
                      '${topic.category} · '
                      '${compactNumber(topic.games)} parties',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => AndroidTopicScreen(
                            fixtures: widget.fixtures,
                            topic: topic,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: topics.length,
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
