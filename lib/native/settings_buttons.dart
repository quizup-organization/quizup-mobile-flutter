import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import 'native_settings_sheet.dart';

class IosSettingsButton extends StatelessWidget {
  const IosSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return cupertino.CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => showNativeSettingsSheet(context),
      child: const Icon(cupertino.CupertinoIcons.settings),
    );
  }
}

class AndroidSettingsButton extends StatelessWidget {
  const AndroidSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Aperçu iOS/Android',
      icon: const Icon(Icons.phone_iphone),
      onPressed: () => showNativeSettingsSheet(context),
    );
  }
}
