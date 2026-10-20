import 'package:material_ui/material_ui.dart';

import '../tokens.dart';

class QuizupSheet extends StatelessWidget {
  const QuizupSheet({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(18, 10, 18, 18),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tokens.colors.card,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        border: Border.all(color: tokens.colors.border),
      ),
      padding: padding.add(EdgeInsets.only(bottom: bottomInset)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: tokens.colors.mutedForeground.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
