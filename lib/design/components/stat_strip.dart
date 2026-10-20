import 'package:material_ui/material_ui.dart';

import '../tokens.dart';
import 'quizup_text.dart';

class StatItem {
  const StatItem({required this.value, required this.label});

  final String value;
  final String label;
}

class StatStrip extends StatelessWidget {
  const StatStrip({super.key, required this.items});

  final List<StatItem> items;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Row(
      children: [
        for (var index = 0; index < items.length; index++) ...[
          if (index > 0)
            Container(
              width: 1,
              height: 30,
              color: tokens.colors.border,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                QuizupText(
                  items[index].value,
                  size: 18,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                QuizupText(
                  items[index].label,
                  size: 11,
                  weight: FontWeight.w500,
                  color: tokens.colors.mutedForeground,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
