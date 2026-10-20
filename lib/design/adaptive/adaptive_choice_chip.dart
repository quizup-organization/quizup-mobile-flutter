import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/chip.dart';
import '../tokens.dart';
import 'native_style.dart';

class AdaptiveChoiceChip extends StatelessWidget {
  const AdaptiveChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    if (!settings.isPlatformMode) {
      return QuizupChip(
        label: label,
        selected: selected,
        onTap: onTap,
        icon: icon,
      );
    }

    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final platform = settings.resolvedPlatform;

    if (platform == TargetPlatform.iOS) {
      final foreground = selected ? colors.primary : colors.foreground;
      return cupertino.CupertinoButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        minSize: const Size(0, 36),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: selected
                ? colors.primary.withValues(alpha: 0.12)
                : colors.secondary,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 13, color: foreground),
                const SizedBox(width: 5),
              ],
              Text(
                label,
                maxLines: 1,
                style: nativeTextStyle(
                  platform: platform,
                  size: 13,
                  weight: FontWeight.w500,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FilterChip(
      label: Text(
        label,
        style: nativeTextStyle(
          platform: platform,
          size: 12,
          weight: FontWeight.w500,
          color: colors.foreground,
        ),
      ),
      selected: selected,
      onSelected: onTap == null ? null : (_) => onTap!(),
      showCheckmark: true,
      checkmarkColor: colors.primary,
      selectedColor: colors.primary.withValues(alpha: 0.14),
      backgroundColor: colors.secondary,
      side: BorderSide(color: colors.border),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
