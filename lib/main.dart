import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'app/quizup_app.dart';
import 'data/fixture_repository.dart';
import 'native/native_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fixtures = await FixtureRepository.load();
  final platform = defaultTargetPlatform == TargetPlatform.iOS
      ? NativePlatform.ios
      : NativePlatform.android;
  runApp(QuizupApp(fixtures: fixtures, initialPlatform: platform));
}
