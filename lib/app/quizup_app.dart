import 'package:material_ui/material_ui.dart';

import '../data/models.dart';
import '../design/app_settings.dart';
import '../design/theme.dart';
import '../features/shell/shell_screen.dart';

class QuizupApp extends StatefulWidget {
  const QuizupApp({
    super.key,
    required this.fixtures,
    this.initialDesignMode = DesignMode.quizup,
    this.initialPlatform = PlatformOverride.auto,
    this.initialThemeMode = ThemeMode.dark,
  });

  final QuizupFixtures fixtures;
  final DesignMode initialDesignMode;
  final PlatformOverride initialPlatform;
  final ThemeMode initialThemeMode;

  @override
  State<QuizupApp> createState() => _QuizupAppState();
}

class _QuizupAppState extends State<QuizupApp> {
  late final AppSettingsController _settings;

  @override
  void initState() {
    super.initState();
    _settings = AppSettingsController(
      designMode: widget.initialDesignMode,
      platformOverride: widget.initialPlatform,
      themeMode: widget.initialThemeMode,
    );
  }

  @override
  void dispose() {
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSettingsScope(
      controller: _settings,
      child: AnimatedBuilder(
        animation: _settings,
        builder: (context, _) {
          final platform = _settings.resolvedPlatform;
          return MaterialApp(
            title: 'QuizUp Flutter',
            debugShowCheckedModeBanner: false,
            theme: buildQuizupTheme(Brightness.light, platform),
            darkTheme: buildQuizupTheme(Brightness.dark, platform),
            themeMode: _settings.themeMode,
            locale: const Locale('fr'),
            supportedLocales: const [Locale('fr'), Locale('en')],
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            home: ShellScreen(fixtures: widget.fixtures),
          );
        },
      ),
    );
  }
}
