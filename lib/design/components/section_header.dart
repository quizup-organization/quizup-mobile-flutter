import 'package:material_ui/material_ui.dart';

import '../tokens.dart';
import 'pressable_scale.dart';
import 'quizup_text.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: QuizupText(
              title,
              size: 18,
              weight: FontWeight.w700,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (actionLabel != null && onAction != null)
            PressableScale(
              onTap: onAction,
              haptics: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QuizupText(
                      actionLabel!,
                      size: 12,
                      weight: FontWeight.w500,
                      color: tokens.colors.mutedForeground,
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 16,
                      color: tokens.colors.mutedForeground,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
