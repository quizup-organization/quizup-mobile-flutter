import 'package:material_ui/material_ui.dart';

import '../tokens.dart';
import 'pressable_scale.dart';
import 'quizup_text.dart';

class QuizupSegment<T extends Object> {
  const QuizupSegment({required this.value, required this.label});

  final T value;
  final String label;
}

class QuizupSegmentedControl<T extends Object> extends StatelessWidget {
  const QuizupSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  final List<QuizupSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.muted,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          for (final segment in segments)
            Expanded(
              child: PressableScale(
                onTap: () => onChanged(segment.value),
                haptics: false,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: segment.value == selected
                        ? colors.card
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: segment.value == selected
                          ? colors.border
                          : Colors.transparent,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: QuizupText(
                    segment.label,
                    size: 12,
                    weight: segment.value == selected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: segment.value == selected
                        ? colors.foreground
                        : colors.mutedForeground,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
