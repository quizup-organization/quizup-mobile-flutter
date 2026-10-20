import 'package:material_ui/material_ui.dart';

import '../tokens.dart';
import 'pressable_scale.dart';
import 'quizup_text.dart';

class QuizupChip extends StatelessWidget {
  const QuizupChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final foreground = selected ? colors.primary : colors.mutedForeground;
    return PressableScale(
      onTap: onTap,
      semanticLabel: label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? colors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? colors.primary.withValues(alpha: 0.34)
                : colors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: foreground),
              const SizedBox(width: 5),
            ],
            QuizupText(
              label,
              size: 12,
              weight: FontWeight.w500,
              color: foreground,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
