import 'package:material_ui/material_ui.dart';

import '../../design/components/quizup_card.dart';
import '../../design/components/quizup_text.dart';
import '../../design/tokens.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: QuizupCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: tokens.colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: tokens.colors.primary, size: 26),
              ),
              const SizedBox(height: 14),
              QuizupText(title, size: 18, weight: FontWeight.w700),
              const SizedBox(height: 6),
              QuizupText(
                message,
                size: 12,
                color: tokens.colors.mutedForeground,
                textAlign: TextAlign.center,
                height: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
