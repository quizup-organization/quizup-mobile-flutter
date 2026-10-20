import 'package:material_ui/material_ui.dart';

import '../tokens.dart';
import 'pressable_scale.dart';
import 'quizup_text.dart';

enum QuizupButtonVariant { primary, secondary, outline, ghost, destructive }

enum QuizupButtonSize { sm, md, lg }

class QuizupButton extends StatelessWidget {
  const QuizupButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = QuizupButtonVariant.primary,
    this.size = QuizupButtonSize.md,
    this.icon,
    this.expand = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final QuizupButtonVariant variant;
  final QuizupButtonSize size;
  final IconData? icon;
  final bool expand;
  final bool loading;

  double get _height {
    switch (size) {
      case QuizupButtonSize.sm:
        return 36;
      case QuizupButtonSize.md:
        return 44;
      case QuizupButtonSize.lg:
        return 48;
    }
  }

  double get _textSize {
    switch (size) {
      case QuizupButtonSize.sm:
        return 12;
      case QuizupButtonSize.md:
        return 14;
      case QuizupButtonSize.lg:
        return 15;
    }
  }

  double get _iconSize {
    switch (size) {
      case QuizupButtonSize.sm:
        return 14;
      case QuizupButtonSize.md:
        return 16;
      case QuizupButtonSize.lg:
        return 18;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case QuizupButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12);
      case QuizupButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 16);
      case QuizupButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final enabled = onPressed != null && !loading;

    final style = switch (variant) {
      QuizupButtonVariant.primary => (
          background: colors.primary,
          foreground: colors.primaryForeground,
          border: null,
        ),
      QuizupButtonVariant.secondary => (
          background: colors.secondary,
          foreground: colors.secondaryForeground,
          border: null,
        ),
      QuizupButtonVariant.outline => (
          background: Colors.transparent,
          foreground: colors.foreground,
          border: Border.all(color: colors.border),
        ),
      QuizupButtonVariant.ghost => (
          background: Colors.transparent,
          foreground: colors.foreground,
          border: null,
        ),
      QuizupButtonVariant.destructive => (
          background: colors.destructive.withValues(alpha: 0.12),
          foreground: colors.destructive,
          border: Border.all(
            color: colors.destructive.withValues(alpha: 0.18),
          ),
        ),
    };
    final background = style.background;
    final foreground = style.foreground;
    final border = style.border;

    final button = Opacity(
      opacity: enabled ? 1 : 0.45,
      child: Container(
        height: _height,
        padding: _padding,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(tokens.radii.button),
          border: border,
        ),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: _iconSize,
                height: _iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(foreground),
                ),
              )
            else if (icon != null)
              Icon(icon, size: _iconSize, color: foreground),
            if (loading || icon != null) const SizedBox(width: 8),
            QuizupText(
              label,
              size: _textSize,
              weight: FontWeight.w600,
              color: foreground,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );

    final tappable = PressableScale(
      onTap: enabled ? onPressed : null,
      semanticLabel: label,
      child: button,
    );

    return expand ? SizedBox(width: double.infinity, child: tappable) : tappable;
  }
}
