import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizup/app/quizup_app.dart';
import 'package:quizup/data/fixture_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('parcours Accueil → Fiche sujet → Duel', (tester) async {
    final fixtures = await FixtureRepository.load();

    await tester.pumpWidget(QuizupApp(fixtures: fixtures));
    await tester.pumpAndSettle();

    expect(find.text('Top 10 du moment'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('home-topic-arts')));
    await tester.pumpAndSettle();

    expect(find.text('Lancer un duel'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('start-duel')));
    await tester.pumpAndSettle();

    expect(find.text('Duel amical'), findsOneWidget);
    expect(find.text('Question 1 / 3'), findsOneWidget);
  });
}
