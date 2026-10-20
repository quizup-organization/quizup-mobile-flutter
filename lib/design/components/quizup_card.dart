import 'package:material_ui/material_ui.dart';

import '../tokens.dart';

class QuizupCard extends StatelessWidget {
  const QuizupCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius,
    this.color,
    this.border,
    this.elevated = false,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? radius;
  final Color? color;
  final Border? border;
  final bool elevated;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final decoration = BoxDecoration(
      color: color ?? colors.card,
      borderRadius: BorderRadius.circular(radius ?? tokens.radii.card),
      border: border ?? Border.all(color: colors.border),
      boxShadow: elevated
          ? [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: tokens.isDark ? 0.28 : 0.05,
                ),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ]
          : null,
    );

    final content = Container(
      padding: padding,
      decoration: decoration,
      child: child,
    );

    if (onTap == null) {
      return content;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: content,
    );
  }
}
