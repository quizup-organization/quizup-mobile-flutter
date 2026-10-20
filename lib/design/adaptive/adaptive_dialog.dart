import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/quizup_button.dart';
import '../components/quizup_card.dart';
import '../components/quizup_text.dart';
import '../tokens.dart';
import 'native_style.dart';

Future<bool> showAdaptiveConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirmer',
  String cancelLabel = 'Annuler',
  bool destructive = false,
}) async {
  final settings = AppSettingsScope.of(context);
  final result = await (switch (settings.designMode) {
    DesignMode.quizup => showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          final tokens = QuizupTheme.of(dialogContext);
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            child: QuizupCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuizupText(title, size: 18, weight: FontWeight.w700),
                  const SizedBox(height: 8),
                  QuizupText(
                    message,
                    size: 13,
                    color: tokens.colors.mutedForeground,
                    height: 1.4,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: QuizupButton(
                          label: cancelLabel,
                          variant: QuizupButtonVariant.outline,
                          onPressed: () => Navigator.of(dialogContext).pop(false),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: QuizupButton(
                          label: confirmLabel,
                          variant: destructive
                              ? QuizupButtonVariant.destructive
                              : QuizupButtonVariant.primary,
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    DesignMode.platform when settings.isIOS => cupertino.showCupertinoDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return cupertino.CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              cupertino.CupertinoDialogAction(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(cancelLabel),
              ),
              cupertino.CupertinoDialogAction(
                isDefaultAction: true,
                isDestructiveAction: destructive,
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(confirmLabel),
              ),
            ],
          );
        },
      ),
    DesignMode.platform => showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          final platform = settings.resolvedPlatform;
          return AlertDialog(
            title: Text(
              title,
              style: nativeTextStyle(
                platform: platform,
                size: 18,
                weight: FontWeight.w600,
              ),
            ),
            content: Text(
              message,
              style: nativeTextStyle(
                platform: platform,
                size: 14,
                weight: FontWeight.w400,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(
                  cancelLabel,
                  style: nativeTextStyle(
                    platform: platform,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: FilledButton.styleFrom(
                  backgroundColor: destructive
                      ? QuizupTheme.of(dialogContext).colors.destructive
                      : null,
                ),
                child: Text(
                  confirmLabel,
                  style: nativeTextStyle(
                    platform: platform,
                    size: 14,
                    weight: FontWeight.w600,
                    color: destructive
                        ? QuizupTheme.of(dialogContext)
                            .colors
                            .destructiveForeground
                        : null,
                  ),
                ),
              ),
            ],
          );
        },
      ),
  });
  return result ?? false;
}
