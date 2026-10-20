import 'package:material_ui/material_ui.dart';

import 'tokens.dart';

ThemeData buildQuizupTheme(Brightness brightness, TargetPlatform platform) {
  final colors = brightness == Brightness.dark ? darkColors : lightColors;
  final quizupTheme = QuizupTheme(
    colors: colors,
    radii: quizupRadii,
    spacing: quizupSpacing,
    brightness: brightness,
  );

  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: colors.primary,
    onPrimary: colors.primaryForeground,
    secondary: colors.secondary,
    onSecondary: colors.secondaryForeground,
    error: colors.destructive,
    onError: colors.destructiveForeground,
    surface: colors.background,
    onSurface: colors.foreground,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    platform: platform,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colors.background,
    fontFamily: 'Inter',
    extensions: <ThemeExtension<dynamic>>[quizupTheme],
  );

  final textTheme = base.textTheme
      .apply(
        fontFamily: 'Inter',
        bodyColor: colors.foreground,
        displayColor: colors.foreground,
      )
      .copyWith(
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          height: 1.4,
          color: colors.foreground,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          height: 1.4,
          color: colors.foreground,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          height: 1.35,
          color: colors.mutedForeground,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colors.foreground,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colors.foreground,
        ),
      );

  final buttonText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  return base.copyWith(
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colors.background,
      foregroundColor: colors.foreground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: colors.foreground,
      ),
      iconTheme: IconThemeData(color: colors.foreground),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.card,
      surfaceTintColor: Colors.transparent,
      indicatorColor: colors.primary.withValues(alpha: 0.14),
      labelTextStyle: WidgetStatePropertyAll<TextStyle>(
        TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colors.foreground,
        ),
      ),
      iconTheme: WidgetStatePropertyAll<IconThemeData>(
        IconThemeData(color: colors.foreground),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.primaryForeground,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(quizupRadii.button),
        ),
        textStyle: buttonText,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.foreground,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        side: BorderSide(color: colors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(quizupRadii.button),
        ),
        textStyle: buttonText,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colors.foreground,
        textStyle: buttonText,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.card,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: colors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
    ),
    dividerColor: colors.border,
    canvasColor: colors.background,
    splashColor: colors.primary.withValues(alpha: 0.08),
    highlightColor: colors.primary.withValues(alpha: 0.04),
  );
}
