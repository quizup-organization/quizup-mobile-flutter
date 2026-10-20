import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../design/components/section_header.dart';
import '../../design/components/topic_media_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.home,
    required this.onOpenTopic,
    this.onExplore,
  });

  final HomeFixture home;
  final ValueChanged<Topic> onOpenTopic;
  final VoidCallback? onExplore;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        if (home.trending.isNotEmpty) ...[
          SectionHeader(
            title: 'Top 10 du moment',
            actionLabel: 'Explorer',
            onAction: onExplore,
          ),
          SizedBox(
            height: 248,
            child: ListView.separated(
              primary: false,
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: home.trending.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final topic = home.trending[index];
                return TopicMediaCard(
                  key: ValueKey('home-topic-${topic.id}'),
                  topic: topic,
                  format: TopicCardFormat.poster,
                  rank: index + 1,
                  onTap: () => onOpenTopic(topic),
                );
              },
            ),
          ),
          const SizedBox(height: 26),
        ],
        if (home.followed.isNotEmpty) ...[
          SectionHeader(
            title: 'Tes sujets suivis',
            actionLabel: 'Tout voir',
            onAction: onExplore,
          ),
          SizedBox(
            height: 164,
            child: ListView.separated(
              primary: false,
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: home.followed.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final topic = home.followed[index];
                return TopicMediaCard(
                  topic: topic,
                  format: TopicCardFormat.landscape,
                  onTap: () => onOpenTopic(topic),
                );
              },
            ),
          ),
          const SizedBox(height: 26),
        ],
        SectionHeader(
          title: 'Nouveaux thèmes',
          actionLabel: 'Tout voir',
          onAction: onExplore,
        ),
        SizedBox(
          height: 164,
          child: ListView.separated(
            primary: false,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: home.newTopics.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final topic = home.newTopics[index];
              return TopicMediaCard(
                topic: topic,
                format: TopicCardFormat.landscape,
                onTap: () => onOpenTopic(topic),
              );
            },
          ),
        ),
      ],
    );
  }
}
