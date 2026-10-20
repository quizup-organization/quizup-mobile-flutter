import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizup/app/quizup_app.dart';
import 'package:quizup/data/fixture_repository.dart';
import 'package:quizup/data/models.dart';
import 'package:quizup/native/native_settings.dart';

Future<void> _loadFonts() async {
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
}

Future<void> _runFlow(
  WidgetTester tester,
  QuizupFixtures fixtures,
  NativePlatform platform,
) async {
  await tester.pumpWidget(
    QuizupApp(fixtures: fixtures, initialPlatform: platform),
  );
  await tester.pumpAndSettle();

  expect(find.text('Top 10 du moment'), findsOneWidget);

  await tester.tap(find.byKey(const ValueKey('trending-arts')));
  await tester.pumpAndSettle();
  expect(find.text('Lancer un duel'), findsOneWidget);

  await tester.tap(find.byKey(const ValueKey('start-duel')));
  await tester.pumpAndSettle();
  expect(find.text('Question 1 / 3'), findsOneWidget);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late QuizupFixtures fixtures;

  setUpAll(() async {
    await _loadFonts();
    fixtures = await FixtureRepository.load();
  });

  testWidgets('parcours natif iOS', (tester) async {
    await _runFlow(tester, fixtures, NativePlatform.ios);
  });

  testWidgets('parcours natif Android', (tester) async {
    await _runFlow(tester, fixtures, NativePlatform.android);
  });
}
