import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

enum DesignMode {
  quizup('QuizUp'),
  platform('Natif');

  const DesignMode(this.label);

  final String label;
}

enum PlatformOverride {
  auto('Auto'),
  ios('iOS'),
  android('Android');

  const PlatformOverride(this.label);

  final String label;
}

class AppSettingsController extends ChangeNotifier {
  AppSettingsController({
    DesignMode designMode = DesignMode.quizup,
    PlatformOverride platformOverride = PlatformOverride.auto,
    ThemeMode themeMode = ThemeMode.dark,
  })  : _designMode = designMode,
        _platformOverride = platformOverride,
        _themeMode = themeMode;

  DesignMode _designMode;
  PlatformOverride _platformOverride;
  ThemeMode _themeMode;

  DesignMode get designMode => _designMode;
  PlatformOverride get platformOverride => _platformOverride;
  ThemeMode get themeMode => _themeMode;

  bool get isPlatformMode => _designMode == DesignMode.platform;

  TargetPlatform get resolvedPlatform {
    switch (_platformOverride) {
      case PlatformOverride.ios:
        return TargetPlatform.iOS;
      case PlatformOverride.android:
        return TargetPlatform.android;
      case PlatformOverride.auto:
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          return TargetPlatform.iOS;
        }
        return TargetPlatform.android;
    }
  }

  bool get isIOS => resolvedPlatform == TargetPlatform.iOS;

  void setDesignMode(DesignMode mode) {
    if (_designMode == mode) {
      return;
    }
    _designMode = mode;
    notifyListeners();
  }

  void toggleDesignMode() {
    setDesignMode(
      _designMode == DesignMode.quizup ? DesignMode.platform : DesignMode.quizup,
    );
  }

  void setPlatformOverride(PlatformOverride value) {
    if (_platformOverride == value) {
      return;
    }
    _platformOverride = value;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) {
      return;
    }
    _themeMode = mode;
    notifyListeners();
  }
}

class AppSettingsScope extends InheritedNotifier<AppSettingsController> {
  const AppSettingsScope({
    super.key,
    required AppSettingsController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppSettingsController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    assert(scope != null, 'AppSettingsScope is missing above this context.');
    return scope!.notifier!;
  }
}
