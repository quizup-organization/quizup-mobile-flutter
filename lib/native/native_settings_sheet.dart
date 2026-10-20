import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import 'native_settings.dart';

Future<void> showNativeSettingsSheet(BuildContext context) {
  final settings = NativeSettingsScope.of(context);
  if (settings.platform == NativePlatform.ios) {
    return cupertino.showCupertinoModalPopup<void>(
      context: context,
      builder: (sheetContext) {
        return cupertino.CupertinoActionSheet(
          title: const Text('Aperçu'),
          message: const Text(
            'Compare les composants natifs iOS et Android.',
          ),
          actions: [
            cupertino.CupertinoActionSheetAction(
              isDefaultAction: settings.platform == NativePlatform.ios,
              onPressed: () {
                Navigator.of(sheetContext).pop();
                settings.onPlatformChanged(NativePlatform.ios);
              },
              child: const Text('iOS (Cupertino)'),
            ),
            cupertino.CupertinoActionSheetAction(
              isDefaultAction: settings.platform == NativePlatform.android,
              onPressed: () {
                Navigator.of(sheetContext).pop();
                settings.onPlatformChanged(NativePlatform.android);
              },
              child: const Text('Android (Material)'),
            ),
            cupertino.CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(sheetContext).pop();
                settings.onBrightnessChanged(Brightness.light);
              },
              child: const Text('Thème clair'),
            ),
            cupertino.CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(sheetContext).pop();
                settings.onBrightnessChanged(Brightness.dark);
              },
              child: const Text('Thème sombre'),
            ),
          ],
          cancelButton: cupertino.CupertinoActionSheetAction(
            onPressed: () => Navigator.of(sheetContext).pop(),
            child: const Text('Annuler'),
          ),
        );
      },
    );
  }

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Aperçu'),
              subtitle: Text('Compare les composants natifs iOS et Android.'),
            ),
            ListTile(
              title: const Text('iOS (Cupertino)'),
              trailing: settings.platform == NativePlatform.ios
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                Navigator.of(sheetContext).pop();
                settings.onPlatformChanged(NativePlatform.ios);
              },
            ),
            ListTile(
              title: const Text('Android (Material)'),
              trailing: settings.platform == NativePlatform.android
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                Navigator.of(sheetContext).pop();
                settings.onPlatformChanged(NativePlatform.android);
              },
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text('Thème sombre'),
              value: settings.brightness == Brightness.dark,
              onChanged: (value) {
                Navigator.of(sheetContext).pop();
                settings.onBrightnessChanged(
                  value ? Brightness.dark : Brightness.light,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
