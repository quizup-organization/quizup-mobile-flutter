import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import '../tokens.dart';
import 'pressable_scale.dart';
import 'quizup_text.dart';

enum TopicCardFormat { poster, landscape }

class TopicMediaCard extends StatelessWidget {
  const TopicMediaCard({
    super.key,
    required this.topic,
    this.format = TopicCardFormat.landscape,
    this.rank,
    this.onTap,
  });

  final Topic topic;
  final TopicCardFormat format;
  final int? rank;
  final VoidCallback? onTap;

  double get _width => format == TopicCardFormat.poster ? 150 : 238;

  double get _height => format == TopicCardFormat.poster ? 236 : 152;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final isPoster = format == TopicCardFormat.poster;

    return PressableScale(
      onTap: onTap,
      semanticLabel: '${topic.name}, ${topic.category}',
      child: SizedBox(
        width: _width,
        height: _height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(tokens.radii.homeCard),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(topic.image, fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.08),
                      Colors.black.withValues(alpha: 0.86),
                    ],
                    stops: const [0.28, 0.55, 1],
                  ),
                ),
              ),
              if (rank != null)
                Positioned(
                  top: 2,
                  left: 10,
                  child: Text(
                    '$rank',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 46,
                      height: 1,
                      fontWeight: FontWeight.w800,
                      color: Colors.white.withValues(alpha: 0.94),
                      shadows: const [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 12,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QuizupText(
                        topic.category.toUpperCase(),
                        size: isPoster ? 10 : 10,
                        weight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.72),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        letterSpacing: 0.6,
                      ),
                      const SizedBox(height: 3),
                      QuizupText(
                        topic.name,
                        size: isPoster ? 13 : 14,
                        weight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.15,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
