import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../design/adaptive/adaptive_button.dart';
import '../../design/adaptive/adaptive_choice_chip.dart';
import '../../design/adaptive/adaptive_search_field.dart';
import '../../design/adaptive/adaptive_segmented_control.dart';
import '../../design/adaptive/adaptive_sheet.dart';
import '../../design/components/quizup_button.dart';
import '../../design/components/quizup_text.dart';
import '../../design/components/segmented_control.dart';
import '../../design/components/topic_grid_card.dart';
import '../../design/tokens.dart';

enum TopicSort {
  popular('Populaires'),
  played('Joués'),
  alpha('A-Z'),
  recent('Récents');

  const TopicSort(this.label);

  final String label;
}

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({
    super.key,
    required this.topics,
    required this.onOpenTopic,
  });

  final List<Topic> topics;
  final ValueChanged<Topic> onOpenTopic;

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String? _category;
  TopicSort _sort = TopicSort.popular;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilters() async {
    final categories = widget.topics
        .map((topic) => topic.category)
        .toSet()
        .toList(growable: false)
      ..sort();
    final result = await showAdaptiveSheet<_FilterSelection>(
      context,
      child: _FilterSheet(
        categories: categories,
        selectedCategory: _category,
      ),
    );
    if (result != null && mounted) {
      setState(() => _category = result.category);
    }
  }

  List<Topic> get _filtered {
    final query = _query.trim().toLowerCase();
    final filtered = widget.topics.where((topic) {
      final matchesQuery = query.isEmpty ||
          topic.name.toLowerCase().contains(query) ||
          topic.category.toLowerCase().contains(query);
      final matchesCategory = _category == null || topic.category == _category;
      return matchesQuery && matchesCategory;
    }).toList();

    final comparator = switch (_sort) {
      TopicSort.popular => (Topic a, Topic b) =>
        b.followers.compareTo(a.followers),
      TopicSort.played => (Topic a, Topic b) => b.games.compareTo(a.games),
      TopicSort.alpha => (Topic a, Topic b) => a.name.compareTo(b.name),
      TopicSort.recent => (Topic a, Topic b) =>
        a.recentRank.compareTo(b.recentRank),
    };
    filtered.sort(comparator);
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final filtered = _filtered;

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        AdaptiveSearchField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value),
          onFilter: _openFilters,
        ),
        const SizedBox(height: 12),
        AdaptiveSegmentedControl<TopicSort>(
          segments: [
            for (final sort in TopicSort.values)
              QuizupSegment(value: sort, label: sort.label),
          ],
          selected: _sort,
          onChanged: (value) => setState(() => _sort = value),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            QuizupText(
              '${filtered.length} sujet${filtered.length > 1 ? 's' : ''}',
              size: 12,
              weight: FontWeight.w600,
              color: tokens.colors.mutedForeground,
            ),
            const Spacer(),
            if (_category != null)
              AdaptiveChoiceChip(
                label: _category!,
                selected: true,
                icon: Icons.close_rounded,
                onTap: () => setState(() => _category = null),
              ),
          ],
        ),
        const SizedBox(height: 10),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 34,
                  color: tokens.colors.mutedForeground,
                ),
                const SizedBox(height: 10),
                QuizupText(
                  'Aucun sujet ne correspond.',
                  size: 14,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                QuizupText(
                  'Essaie un autre mot-clé ou retire le filtre.',
                  size: 12,
                  color: tokens.colors.mutedForeground,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final topic = filtered[index];
              return TopicGridCard(
                key: ValueKey('topic-grid-${topic.id}'),
                topic: topic,
                onTap: () => widget.onOpenTopic(topic),
              );
            },
          ),
      ],
    );
  }
}

class _FilterSelection {
  const _FilterSelection(this.category);

  final String? category;
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({
    required this.categories,
    required this.selectedCategory,
  });

  final List<String> categories;
  final String? selectedCategory;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  String? _category;

  @override
  void initState() {
    super.initState();
    _category = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuizupText('Filtrer les sujets', size: 18, weight: FontWeight.w700),
        const SizedBox(height: 4),
        QuizupText(
          'Affine le catalogue par catégorie.',
          size: 12,
          color: tokens.colors.mutedForeground,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AdaptiveChoiceChip(
              label: 'Tous',
              selected: _category == null,
              onTap: () => setState(() => _category = null),
            ),
            for (final category in widget.categories)
              AdaptiveChoiceChip(
                label: category,
                selected: _category == category,
                onTap: () => setState(() => _category = category),
              ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: AdaptiveButton(
                label: 'Réinitialiser',
                variant: QuizupButtonVariant.ghost,
                onPressed: () => setState(() => _category = null),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AdaptiveButton(
                label: 'Appliquer',
                onPressed: () =>
                    Navigator.of(context).pop(_FilterSelection(_category)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
