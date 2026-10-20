import 'package:material_ui/material_ui.dart';

enum NativePlatform {
  ios('iOS (Cupertino)'),
  android('Android (Material)');

  const NativePlatform(this.label);

  final String label;
}

class NativeSettings {
  const NativeSettings({
    required this.platform,
    required this.brightness,
    required this.onPlatformChanged,
    required this.onBrightnessChanged,
  });

  final NativePlatform platform;
  final Brightness brightness;
  final ValueChanged<NativePlatform> onPlatformChanged;
  final ValueChanged<Brightness> onBrightnessChanged;
}

class NativeSettingsScope extends InheritedWidget {
  const NativeSettingsScope({
    super.key,
    required this.settings,
    required super.child,
  });

  final NativeSettings settings;

  static NativeSettings of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<NativeSettingsScope>();
    assert(scope != null, 'NativeSettingsScope is missing above this context.');
    return scope!.settings;
  }

  @override
  bool updateShouldNotify(NativeSettingsScope oldWidget) {
    return oldWidget.settings.platform != settings.platform ||
        oldWidget.settings.brightness != settings.brightness;
  }
}
