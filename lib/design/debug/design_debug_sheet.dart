import 'package:material_ui/material_ui.dart';

import '../adaptive/adaptive_button.dart';
import '../adaptive/adaptive_segmented_control.dart';
import '../adaptive/adaptive_sheet.dart';
import '../app_settings.dart';
import '../components/quizup_button.dart';
import '../components/quizup_text.dart';
import '../components/segmented_control.dart';
import '../tokens.dart';

Future<void> showDesignDebugSheet(
  BuildContext context, {
  VoidCallback? onOpenGallery,
}) {
  return showAdaptiveSheet<void>(
    context,
    child: DesignDebugSheetContent(onOpenGallery: onOpenGallery),
  );
}

class DesignDebugSheetContent extends StatelessWidget {
  const DesignDebugSheetContent({super.key, this.onOpenGallery});

  final VoidCallback? onOpenGallery;

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    final tokens = QuizupTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuizupText(
          'Design & plateforme',
          size: 18,
          weight: FontWeight.w700,
        ),
        const SizedBox(height: 4),
        QuizupText(
          'Compare le rendu QuizUp au rendu natif, sans quitter les écrans.',
          size: 12,
          color: tokens.colors.mutedForeground,
          height: 1.4,
        ),
        const SizedBox(height: 18),
        const QuizupText('Design system', size: 12, weight: FontWeight.w600),
        const SizedBox(height: 8),
        AdaptiveSegmentedControl<DesignMode>(
          segments: const [
            QuizupSegment(value: DesignMode.quizup, label: 'QuizUp'),
            QuizupSegment(value: DesignMode.platform, label: 'Natif'),
          ],
          selected: settings.designMode,
          onChanged: settings.setDesignMode,
        ),
        const SizedBox(height: 16),
        const QuizupText('Aperçu plateforme', size: 12, weight: FontWeight.w600),
        const SizedBox(height: 8),
        AdaptiveSegmentedControl<PlatformOverride>(
          segments: const [
            QuizupSegment(value: PlatformOverride.auto, label: 'Auto'),
            QuizupSegment(value: PlatformOverride.ios, label: 'iOS'),
            QuizupSegment(value: PlatformOverride.android, label: 'Android'),
          ],
          selected: settings.platformOverride,
          onChanged: settings.setPlatformOverride,
        ),
        const SizedBox(height: 16),
        const QuizupText('Thème', size: 12, weight: FontWeight.w600),
        const SizedBox(height: 8),
        AdaptiveSegmentedControl<ThemeMode>(
          segments: const [
            QuizupSegment(value: ThemeMode.system, label: 'Système'),
            QuizupSegment(value: ThemeMode.light, label: 'Clair'),
            QuizupSegment(value: ThemeMode.dark, label: 'Sombre'),
          ],
          selected: settings.themeMode,
          onChanged: settings.setThemeMode,
        ),
        const SizedBox(height: 20),
        if (onOpenGallery != null)
          Row(
            children: [
              Expanded(
                child: AdaptiveButton(
                  label: 'Galerie design',
                  icon: Icons.palette_outlined,
                  variant: QuizupButtonVariant.outline,
                  onPressed: () {
                    final navigator = Navigator.of(context);
                    navigator.pop();
                    onOpenGallery!();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AdaptiveButton(
                  label: 'Fermer',
                  variant: QuizupButtonVariant.ghost,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          )
        else
          AdaptiveButton(
            label: 'Fermer',
            variant: QuizupButtonVariant.ghost,
            expand: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
        const SizedBox(height: 8),
        QuizupText(
          'Le mode Natif utilise Cupertino sur iOS et Material sur Android. '
          'Les cartes et visuels restent QuizUp.',
          size: 10,
          color: tokens.colors.mutedForeground,
          height: 1.4,
        ),
      ],
    );
  }
}
