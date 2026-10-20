import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizup/app/quizup_app.dart';
import 'package:quizup/data/fixture_repository.dart';
import 'package:quizup/data/models.dart';
import 'package:quizup/design/app_settings.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late QuizupFixtures fixtures;

  setUpAll(() async {
    const fontPaths = [
      'assets/fonts/Inter_400Regular.ttf',
      'assets/fonts/Inter_500Medium.ttf',
      'assets/fonts/Inter_600SemiBold.ttf',
      'assets/fonts/Inter_700Bold.ttf',
      'assets/fonts/Inter_800ExtraBold.ttf',
    ];
    for (final family in const ['Inter', '.SF Pro Text', 'Roboto']) {
      final loader = FontLoader(family);
      for (final path in fontPaths) {
        loader.addFont(rootBundle.load(path));
      }
      await loader.load();
    }
    fixtures = await FixtureRepository.load();
  });

  testWidgets('debug iOS detail layout', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final previous = FlutterError.onError;
    FlutterError.onError = (details) {
      debugPrint('LAYOUT ERROR: ${details.exceptionAsString()}');
    };

    await tester.pumpWidget(
      QuizupApp(
        fixtures: fixtures,
        initialDesignMode: DesignMode.platform,
        initialPlatform: PlatformOverride.ios,
        initialThemeMode: ThemeMode.dark,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('home-topic-arts')));
    await tester.pumpAndSettle();

    debugDumpRenderTree();

    FlutterError.onError = previous;
  });
}
