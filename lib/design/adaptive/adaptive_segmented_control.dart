import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/segmented_control.dart';
import '../tokens.dart';
import 'native_style.dart';

class AdaptiveSegmentedControl<T extends Object> extends StatelessWidget {
  const AdaptiveSegmentedControl({
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
    final settings = AppSettingsScope.of(context);
    if (!settings.isPlatformMode) {
      return QuizupSegmentedControl<T>(
        segments: segments,
        selected: selected,
        onChanged: onChanged,
      );
    }

    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final platform = settings.resolvedPlatform;

    if (platform == TargetPlatform.iOS) {
      return cupertino.CupertinoSlidingSegmentedControl<T>(
        groupValue: selected,
        backgroundColor: colors.muted,
        thumbColor: colors.card,
        padding: const EdgeInsets.all(3),
        children: {
          for (final segment in segments)
            segment.value: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              child: Text(
                segment.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: nativeTextStyle(
                  platform: platform,
                  size: 12,
                  weight: FontWeight.w500,
                  color: colors.foreground,
                ),
              ),
            ),
        },
        onValueChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      );
    }

    return SegmentedButton<T>(
      segments: [
        for (final segment in segments)
          ButtonSegment<T>(
            value: segment.value,
            label: Text(
              segment.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: nativeTextStyle(
                platform: platform,
                size: 12,
                weight: FontWeight.w500,
                color: colors.foreground,
              ),
            ),
          ),
      ],
      selected: {selected},
      showSelectedIcon: false,
      expandedInsets: EdgeInsets.zero,
      onSelectionChanged: (selection) {
        if (selection.isNotEmpty) {
          onChanged(selection.first);
        }
      },
    );
  }
}
