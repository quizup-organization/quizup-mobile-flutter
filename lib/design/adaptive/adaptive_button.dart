import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/quizup_button.dart';
import '../tokens.dart';
import 'native_style.dart';

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({
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

  double get _fontSize {
    switch (size) {
      case QuizupButtonSize.sm:
        return 13;
      case QuizupButtonSize.md:
        return 14;
      case QuizupButtonSize.lg:
        return 15;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    if (!settings.isPlatformMode) {
      return QuizupButton(
        label: label,
        onPressed: onPressed,
        variant: variant,
        size: size,
        icon: icon,
        expand: expand,
        loading: loading,
      );
    }

    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final platform = settings.resolvedPlatform;
    final enabled = onPressed != null && !loading;

    final style = switch (variant) {
      QuizupButtonVariant.primary => (
          background: colors.primary,
          foreground: colors.primaryForeground,
        ),
      QuizupButtonVariant.secondary => (
          background: colors.secondary,
          foreground: colors.secondaryForeground,
        ),
      QuizupButtonVariant.outline => (
          background: Colors.transparent,
          foreground: colors.foreground,
        ),
      QuizupButtonVariant.ghost => (
          background: Colors.transparent,
          foreground: colors.foreground,
        ),
      QuizupButtonVariant.destructive => (
          background: colors.destructive,
          foreground: colors.destructiveForeground,
        ),
    };

    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(style.foreground),
            ),
          )
        else if (icon != null)
          Icon(icon, size: 16, color: style.foreground),
        if (loading || icon != null) const SizedBox(width: 8),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: nativeTextStyle(
            platform: platform,
            size: _fontSize,
            weight: FontWeight.w600,
            color: style.foreground,
          ),
        ),
      ],
    );

    final button = platform == TargetPlatform.iOS
        ? cupertino.CupertinoButton(
            onPressed: enabled ? onPressed : null,
            color: style.background == Colors.transparent
                ? null
                : style.background,
            borderRadius: BorderRadius.circular(tokens.radii.button),
            minimumSize: Size(0, _height),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            pressedOpacity: 0.7,
            child: child,
          )
        : switch (variant) {
            QuizupButtonVariant.outline ||
            QuizupButtonVariant.ghost =>
              OutlinedButton(
                onPressed: enabled ? onPressed : null,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(0, _height),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  foregroundColor: style.foreground,
                  side: variant == QuizupButtonVariant.outline
                      ? BorderSide(color: colors.border)
                      : BorderSide.none,
                ),
                child: child,
              ),
            _ => FilledButton(
                onPressed: enabled ? onPressed : null,
                style: FilledButton.styleFrom(
                  minimumSize: Size(0, _height),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: style.background,
                  foregroundColor: style.foreground,
                ),
                child: child,
              ),
          };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
