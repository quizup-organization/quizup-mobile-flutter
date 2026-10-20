import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../data/models.dart';
import '../native/android/android_shell.dart';
import '../native/ios/ios_shell.dart';
import '../native/native_settings.dart';

class QuizupApp extends StatefulWidget {
  const QuizupApp({
    super.key,
    required this.fixtures,
    this.initialPlatform = NativePlatform.android,
    this.initialBrightness = Brightness.light,
  });

  final QuizupFixtures fixtures;
  final NativePlatform initialPlatform;
  final Brightness initialBrightness;

  @override
  State<QuizupApp> createState() => _QuizupAppState();
}

class _QuizupAppState extends State<QuizupApp> {
  late NativePlatform _platform;
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    _platform = widget.initialPlatform;
    _brightness = widget.initialBrightness;
  }

  void _setPlatform(NativePlatform platform) {
    if (_platform == platform) {
      return;
    }
    setState(() => _platform = platform);
  }

  void _setBrightness(Brightness brightness) {
    if (_brightness == brightness) {
      return;
    }
    setState(() => _brightness = brightness);
  }

  @override
  Widget build(BuildContext context) {
    final settings = NativeSettings(
      platform: _platform,
      brightness: _brightness,
      onPlatformChanged: _setPlatform,
      onBrightnessChanged: _setBrightness,
    );

    return NativeSettingsScope(
      settings: settings,
      child: _platform == NativePlatform.ios
          ? cupertino.CupertinoApp(
              title: 'QuizUp Native',
              theme: cupertino.CupertinoThemeData(brightness: _brightness),
              localizationsDelegates:
                  cupertino.GlobalCupertinoLocalizations.delegates,
              supportedLocales: const [Locale('fr'), Locale('en')],
              home: IosShell(fixtures: widget.fixtures),
            )
          : MaterialApp(
              title: 'QuizUp Native',
              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
              ),
              themeMode: _brightness == Brightness.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              supportedLocales: const [Locale('fr'), Locale('en')],
              home: AndroidShell(fixtures: widget.fixtures),
            ),
    );
  }
}
