import 'package:material_ui/material_ui.dart';

import 'app/quizup_app.dart';
import 'data/fixture_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fixtures = await FixtureRepository.load();
  runApp(QuizupApp(fixtures: fixtures));
}
