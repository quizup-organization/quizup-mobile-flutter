import 'package:material_ui/material_ui.dart';

/// Couleurs sémantiques alignées sur `quizup-web/src/index.css`.
/// Les valeurs oklch du web ont été converties en sRGB pour Flutter.
class QuizupColors {
  const QuizupColors({
    required this.background,
    required this.foreground,
    required this.card,
    required this.cardForeground,
    required this.popover,
    required this.popoverForeground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.border,
    required this.input,
    required this.inputMuted,
    required this.ring,
    required this.success,
    required this.warning,
    required this.win,
    required this.draw,
    required this.loss,
    required this.surfaceMuted,
    required this.duelBackground,
    required this.duelSurface,
    required this.duelAccent,
    required this.onDuel,
    required this.mutedOnDuel,
  });

  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color popover;
  final Color popoverForeground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color input;
  final Color inputMuted;
  final Color ring;
  final Color success;
  final Color warning;
  final Color win;
  final Color draw;
  final Color loss;
  final Color surfaceMuted;
  final Color duelBackground;
  final Color duelSurface;
  final Color duelAccent;
  final Color onDuel;
  final Color mutedOnDuel;
}

const QuizupColors lightColors = QuizupColors(
  background: Color(0xFFFFFFFF),
  foreground: Color(0xFF0A0A0A),
  card: Color(0xFFFFFFFF),
  cardForeground: Color(0xFF0A0A0A),
  popover: Color(0xFFFFFFFF),
  popoverForeground: Color(0xFF0A0A0A),
  primary: Color(0xFF1447E6),
  primaryForeground: Color(0xFFEFF6FF),
  secondary: Color(0xFFF4F4F5),
  secondaryForeground: Color(0xFF18181B),
  muted: Color(0xFFF5F5F5),
  mutedForeground: Color(0xFF737373),
  accent: Color(0xFFF5F5F5),
  accentForeground: Color(0xFF171717),
  destructive: Color(0xFFE7000B),
  destructiveForeground: Color(0xFFFFFFFF),
  border: Color(0xFFE5E5E5),
  input: Color(0xFFE5E5E5),
  inputMuted: Color(0xFFF2F2F2),
  ring: Color(0xFFA1A1A1),
  success: Color(0xFF00A63E),
  warning: Color(0xFFF59E0B),
  win: Color(0xFF02D274),
  draw: Color(0xFFFEBD19),
  loss: Color(0xFFFE5454),
  surfaceMuted: Color(0xFFF5F5F5),
  duelBackground: Color(0xFF0B1020),
  duelSurface: Color(0xFF151B2E),
  duelAccent: Color(0xFFFBBF24),
  onDuel: Color(0xFFF8FAFC),
  mutedOnDuel: Color(0xFF94A3B8),
);

const QuizupColors darkColors = QuizupColors(
  background: Color(0xFF121212),
  foreground: Color(0xFFE9E9E9),
  card: Color(0xFF1F1F1F),
  cardForeground: Color(0xFFE9E9E9),
  popover: Color(0xFF1F1F1F),
  popoverForeground: Color(0xFFE9E9E9),
  primary: Color(0xFF193CB8),
  primaryForeground: Color(0xFFEFF6FF),
  secondary: Color(0xFF2A2A2A),
  secondaryForeground: Color(0xFFE9E9E9),
  muted: Color(0xFF2A2A2A),
  mutedForeground: Color(0xFFA0A0A0),
  accent: Color(0xFF2A2A2A),
  accentForeground: Color(0xFFE9E9E9),
  destructive: Color(0xFFF15C6D),
  destructiveForeground: Color(0xFFFFFFFF),
  border: Color(0xFF2E2E2E),
  input: Color(0xFF2E2E2E),
  inputMuted: Color(0xFF202020),
  ring: Color(0xFF737373),
  success: Color(0xFF00BC7D),
  warning: Color(0xFFF59E0B),
  win: Color(0xFF02D274),
  draw: Color(0xFFFEBD19),
  loss: Color(0xFFFE5454),
  surfaceMuted: Color(0xFF2A2A2A),
  duelBackground: Color(0xFF0B1020),
  duelSurface: Color(0xFF151B2E),
  duelAccent: Color(0xFFFBBF24),
  onDuel: Color(0xFFF8FAFC),
  mutedOnDuel: Color(0xFF94A3B8),
);

class QuizupRadii {
  const QuizupRadii({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.xxxxl,
    required this.card,
    required this.homeCard,
    required this.button,
    required this.input,
    required this.sheet,
  });

  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;
  final double xxxxl;
  final double card;
  final double homeCard;
  final double button;
  final double input;
  final double sheet;
}

const QuizupRadii quizupRadii = QuizupRadii(
  sm: 6,
  md: 8,
  lg: 10,
  xl: 14,
  xxl: 18,
  xxxl: 22,
  xxxxl: 26,
  card: 34,
  homeCard: 10,
  button: 26,
  input: 22,
  sheet: 26,
);

class QuizupSpacing {
  const QuizupSpacing({
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.gutter,
  });

  final double xxs;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double gutter;
}

const QuizupSpacing quizupSpacing = QuizupSpacing(
  xxs: 2,
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  gutter: 14,
);

/// Tokens applicatifs exposés via `Theme.of(context).extension<QuizupTheme>()`.
class QuizupTheme extends ThemeExtension<QuizupTheme> {
  const QuizupTheme({
    required this.colors,
    required this.radii,
    required this.spacing,
    required this.brightness,
  });

  final QuizupColors colors;
  final QuizupRadii radii;
  final QuizupSpacing spacing;
  final Brightness brightness;

  bool get isDark => brightness == Brightness.dark;

  static QuizupTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<QuizupTheme>();
    assert(theme != null, 'QuizupTheme is missing from ThemeData.extensions');
    return theme!;
  }

  @override
  QuizupTheme copyWith({
    QuizupColors? colors,
    QuizupRadii? radii,
    QuizupSpacing? spacing,
    Brightness? brightness,
  }) {
    return QuizupTheme(
      colors: colors ?? this.colors,
      radii: radii ?? this.radii,
      spacing: spacing ?? this.spacing,
      brightness: brightness ?? this.brightness,
    );
  }

  @override
  QuizupTheme lerp(ThemeExtension<QuizupTheme>? other, double t) {
    if (other is! QuizupTheme) {
      return this;
    }
    return QuizupTheme(
      colors: QuizupColors(
        background: Color.lerp(colors.background, other.colors.background, t)!,
        foreground: Color.lerp(colors.foreground, other.colors.foreground, t)!,
        card: Color.lerp(colors.card, other.colors.card, t)!,
        cardForeground: Color.lerp(
          colors.cardForeground,
          other.colors.cardForeground,
          t,
        )!,
        popover: Color.lerp(colors.popover, other.colors.popover, t)!,
        popoverForeground: Color.lerp(
          colors.popoverForeground,
          other.colors.popoverForeground,
          t,
        )!,
        primary: Color.lerp(colors.primary, other.colors.primary, t)!,
        primaryForeground: Color.lerp(
          colors.primaryForeground,
          other.colors.primaryForeground,
          t,
        )!,
        secondary: Color.lerp(colors.secondary, other.colors.secondary, t)!,
        secondaryForeground: Color.lerp(
          colors.secondaryForeground,
          other.colors.secondaryForeground,
          t,
        )!,
        muted: Color.lerp(colors.muted, other.colors.muted, t)!,
        mutedForeground: Color.lerp(
          colors.mutedForeground,
          other.colors.mutedForeground,
          t,
        )!,
        accent: Color.lerp(colors.accent, other.colors.accent, t)!,
        accentForeground: Color.lerp(
          colors.accentForeground,
          other.colors.accentForeground,
          t,
        )!,
        destructive: Color.lerp(colors.destructive, other.colors.destructive, t)!,
        destructiveForeground: Color.lerp(
          colors.destructiveForeground,
          other.colors.destructiveForeground,
          t,
        )!,
        border: Color.lerp(colors.border, other.colors.border, t)!,
        input: Color.lerp(colors.input, other.colors.input, t)!,
        inputMuted: Color.lerp(colors.inputMuted, other.colors.inputMuted, t)!,
        ring: Color.lerp(colors.ring, other.colors.ring, t)!,
        success: Color.lerp(colors.success, other.colors.success, t)!,
        warning: Color.lerp(colors.warning, other.colors.warning, t)!,
        win: Color.lerp(colors.win, other.colors.win, t)!,
        draw: Color.lerp(colors.draw, other.colors.draw, t)!,
        loss: Color.lerp(colors.loss, other.colors.loss, t)!,
        surfaceMuted: Color.lerp(
          colors.surfaceMuted,
          other.colors.surfaceMuted,
          t,
        )!,
        duelBackground: Color.lerp(
          colors.duelBackground,
          other.colors.duelBackground,
          t,
        )!,
        duelSurface: Color.lerp(
          colors.duelSurface,
          other.colors.duelSurface,
          t,
        )!,
        duelAccent: Color.lerp(colors.duelAccent, other.colors.duelAccent, t)!,
        onDuel: Color.lerp(colors.onDuel, other.colors.onDuel, t)!,
        mutedOnDuel: Color.lerp(
          colors.mutedOnDuel,
          other.colors.mutedOnDuel,
          t,
        )!,
      ),
      radii: radii,
      spacing: spacing,
      brightness: t < 0.5 ? brightness : other.brightness,
    );
  }
}
