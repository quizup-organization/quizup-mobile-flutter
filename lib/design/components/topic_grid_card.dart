import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../../shared/format.dart';
import '../tokens.dart';
import 'pressable_scale.dart';
import 'quizup_text.dart';

class TopicGridCard extends StatelessWidget {
  const TopicGridCard({
    super.key,
    required this.topic,
    this.onTap,
  });

  final Topic topic;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;

    return PressableScale(
      onTap: onTap,
      semanticLabel: '${topic.name}, ${topic.category}',
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: colors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 98,
              width: double.infinity,
              child: Image.asset(topic.image, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuizupText(
                      topic.category.toUpperCase(),
                      size: 9,
                      weight: FontWeight.w600,
                      color: topic.color,
                      letterSpacing: 0.7,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    QuizupText(
                      topic.name,
                      size: 13,
                      weight: FontWeight.w600,
                      height: 1.2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline_rounded,
                          size: 13,
                          color: colors.mutedForeground,
                        ),
                        const SizedBox(width: 3),
                        QuizupText(
                          compactNumber(topic.followers),
                          size: 10,
                          weight: FontWeight.w500,
                          color: colors.mutedForeground,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.play_circle_outline_rounded,
                          size: 13,
                          color: colors.mutedForeground,
                        ),
                        const SizedBox(width: 3),
                        QuizupText(
                          compactNumber(topic.games),
                          size: 10,
                          weight: FontWeight.w500,
                          color: colors.mutedForeground,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
