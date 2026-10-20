import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizup/app/quizup_app.dart';
import 'package:quizup/data/fixture_repository.dart';
import 'package:quizup/data/models.dart';
import 'package:quizup/design/app_settings.dart';

class _Variant {
  const _Variant(this.name, this.designMode, this.platform, this.themeMode);

  final String name;
  final DesignMode designMode;
  final PlatformOverride platform;
  final ThemeMode themeMode;
}

const _variants = [
  _Variant('quizup_dark', DesignMode.quizup, PlatformOverride.auto, ThemeMode.dark),
  _Variant('quizup_light', DesignMode.quizup, PlatformOverride.auto, ThemeMode.light),
  _Variant('native_ios_dark', DesignMode.platform, PlatformOverride.ios, ThemeMode.dark),
  _Variant('native_ios_light', DesignMode.platform, PlatformOverride.ios, ThemeMode.light),
  _Variant(
    'native_android_dark',
    DesignMode.platform,
    PlatformOverride.android,
    ThemeMode.dark,
  ),
  _Variant(
    'native_android_light',
    DesignMode.platform,
    PlatformOverride.android,
    ThemeMode.light,
  ),
];

Future<QuizupFixtures> _loadFixtures() => FixtureRepository.load();

Future<void> _pumpApp(WidgetTester tester, QuizupFixtures fixtures, _Variant variant) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    RepaintBoundary(
      key: const ValueKey('golden-root'),
      child: QuizupApp(
        fixtures: fixtures,
        initialDesignMode: variant.designMode,
        initialPlatform: variant.platform,
        initialThemeMode: variant.themeMode,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _capture(WidgetTester tester, String name) async {
  await expectLater(
    find.byKey(const ValueKey('golden-root')),
    matchesGoldenFile('goldens/$name.png'),
  );
}

Future<void> _goToTopics(WidgetTester tester) async {
  final brandNav = find.byKey(const ValueKey('nav-item-1'));
  if (brandNav.evaluate().isNotEmpty) {
    await tester.tap(brandNav);
  } else {
    await tester.tap(find.text('Sujets').last);
  }
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late QuizupFixtures fixtures;

  setUpAll(() async {
    final fontLoader = FontLoader('Inter');
    for (final path in const [
      'assets/fonts/Inter_400Regular.ttf',
      'assets/fonts/Inter_500Medium.ttf',
      'assets/fonts/Inter_600SemiBold.ttf',
      'assets/fonts/Inter_700Bold.ttf',
      'assets/fonts/Inter_800ExtraBold.ttf',
    ]) {
      fontLoader.addFont(rootBundle.load(path));
    }
    await fontLoader.load();
    fixtures = await _loadFixtures();
  });

  for (final variant in _variants) {
    testWidgets('${variant.name} — Accueil', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await _capture(tester, '${variant.name}_home');
    });

    testWidgets('${variant.name} — Sujets', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await _goToTopics(tester);
      await _capture(tester, '${variant.name}_topics');
    });

    testWidgets('${variant.name} — Fiche sujet', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await tester.tap(find.byKey(const ValueKey('home-topic-arts')));
      await tester.pumpAndSettle();
      await _capture(tester, '${variant.name}_topic');
    });

    testWidgets('${variant.name} — Duel', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await tester.tap(find.byKey(const ValueKey('home-topic-arts')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('start-duel')));
      await tester.pumpAndSettle();
      await _capture(tester, '${variant.name}_duel');
    });
  }
}
