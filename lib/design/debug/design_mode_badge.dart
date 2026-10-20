import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/pressable_scale.dart';
import '../components/quizup_text.dart';
import '../tokens.dart';
import 'design_debug_sheet.dart';

class DesignModeBadge extends StatelessWidget {
  const DesignModeBadge({super.key, this.onOpenGallery});

  final VoidCallback? onOpenGallery;

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;

    return PressableScale(
      onTap: () => showDesignDebugSheet(
        context,
        onOpenGallery: onOpenGallery,
      ),
      semanticLabel: 'Changer de design system',
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 9),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: colors.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.palette_outlined,
              size: 14,
              color: colors.primary,
            ),
            const SizedBox(width: 4),
            QuizupText(
              settings.designMode.label,
              size: 10,
              weight: FontWeight.w600,
              color: colors.primary,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
