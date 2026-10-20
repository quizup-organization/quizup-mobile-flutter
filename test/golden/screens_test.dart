import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizup/app/quizup_app.dart';
import 'package:quizup/data/fixture_repository.dart';
import 'package:quizup/data/models.dart';
import 'package:quizup/native/native_settings.dart';

class _Variant {
  const _Variant(this.name, this.platform, this.brightness);

  final String name;
  final NativePlatform platform;
  final Brightness brightness;
}

const _variants = [
  _Variant('ios_light', NativePlatform.ios, Brightness.light),
  _Variant('ios_dark', NativePlatform.ios, Brightness.dark),
  _Variant('android_light', NativePlatform.android, Brightness.light),
  _Variant('android_dark', NativePlatform.android, Brightness.dark),
];

Future<void> _loadFonts() async {
  const fontPaths = [
    'assets/fonts/Inter_400Regular.ttf',
    'assets/fonts/Inter_500Medium.ttf',
    'assets/fonts/Inter_600SemiBold.ttf',
    'assets/fonts/Inter_700Bold.ttf',
    'assets/fonts/Inter_800ExtraBold.ttf',
  ];
  // Register a realistic fallback under the platform family names used by
  // Cupertino and Material. Linux runners do not have SF Pro or Roboto.
  for (final family in const ['Inter', '.SF Pro Text', 'Roboto']) {
    final loader = FontLoader(family);
    for (final path in fontPaths) {
      loader.addFont(rootBundle.load(path));
    }
    await loader.load();
  }
}

Future<void> _pumpApp(
  WidgetTester tester,
  QuizupFixtures fixtures,
  _Variant variant,
) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    RepaintBoundary(
      key: const ValueKey('golden-root'),
      child: QuizupApp(
        fixtures: fixtures,
        initialPlatform: variant.platform,
        initialBrightness: variant.brightness,
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

Future<void> _goToTopics(WidgetTester tester, _Variant variant) async {
  if (variant.platform == NativePlatform.ios) {
    await tester.tap(
      find.byIcon(cupertino.CupertinoIcons.square_grid_2x2).last,
    );
  } else {
    await tester.tap(find.byIcon(Icons.grid_view_outlined).last);
  }
  await tester.pumpAndSettle();
}

Future<void> _openTopic(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('trending-arts')));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late QuizupFixtures fixtures;

  setUpAll(() async {
    await _loadFonts();
    fixtures = await FixtureRepository.load();
  });

  for (final variant in _variants) {
    testWidgets('${variant.name} — Accueil', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await _capture(tester, '${variant.name}_home');
    });

    testWidgets('${variant.name} — Sujets', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await _goToTopics(tester, variant);
      await _capture(tester, '${variant.name}_topics');
    });

    testWidgets('${variant.name} — Fiche sujet', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await _openTopic(tester);
      await _capture(tester, '${variant.name}_topic');
    });

    testWidgets('${variant.name} — Duel', (tester) async {
      await _pumpApp(tester, fixtures, variant);
      await _openTopic(tester);
      await tester.tap(find.byKey(const ValueKey('start-duel')));
      await tester.pumpAndSettle();
      await _capture(tester, '${variant.name}_duel');
    });
  }
}
