import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/quizup_sheet.dart';

Future<T?> showAdaptiveSheet<T>(
  BuildContext context, {
  required Widget child,
}) {
  final settings = AppSettingsScope.of(context);
  if (!settings.isPlatformMode) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return QuizupSheet(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.78,
            ),
            child: SingleChildScrollView(child: child),
          ),
        );
      },
    );
  }

  if (settings.isIOS) {
    return cupertino.showCupertinoModalPopup<T>(
      context: context,
      builder: (popupContext) {
        final bottomInset = MediaQuery.viewInsetsOf(popupContext).bottom;
        return Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(popupContext).height * 0.9,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: cupertino.CupertinoColors.systemBackground
                    .resolveFrom(popupContext),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (sheetContext) {
      final bottomInset = MediaQuery.viewInsetsOf(sheetContext).bottom;
      return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(18, 0, 18, 18 + bottomInset),
        child: child,
      );
    },
  );
}
