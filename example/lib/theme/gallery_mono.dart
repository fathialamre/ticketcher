import 'package:flutter/material.dart';

/// Gallery Mono: black and white with a single accent, volt blue.
///
/// Every example draws its colors from here so the showcases (and the
/// README screenshots taken from them) read as one family. Ticket faces
/// use [white], [black] or [blue]; the page behind them is [fog].
abstract final class Mono {
  // Neutrals
  static const white = Color(0xFFFFFFFF);
  static const fog = Color(0xFFF4F4F2);
  static const panel = Color(0xFFE6E6E2);
  static const line = Color(0xFFD4D4D4);
  static const ash = Color(0xFF737373);
  static const graphite = Color(0xFF2A2A2A);
  static const black = Color(0xFF0A0A0A);

  // Accent ramp (volt blue)
  static const blueTint = Color(0xFFEEF2FF);
  static const blueSoft = Color(0xFFDCE4FF);
  static const blueLight = Color(0xFF8FA6FF);
  static const blue = Color(0xFF2F5BFF);
  static const blueDeep = Color(0xFF1A3AD1);
  static const blueNight = Color(0xFF0B1A5C);

  // Text on light / dark faces
  static const ink = black;
  static const inkMuted = ash;
  static const onDark = white;
  static const onDarkMuted = Color(0xFFA3A3A3);

  // Gradients
  static const gradientBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, blueLight],
  );
  static const gradientNight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blueNight, blue],
  );
  static const gradientInk = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [graphite, black],
  );
  static const gradientFog = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [white, fog],
  );

  // Text styles used on ticket faces
  static const eyebrow = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.8,
    color: ash,
  );
  static const title = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: ink,
  );
  static const body = TextStyle(fontSize: 14, color: ink);
  static const caption = TextStyle(fontSize: 12, color: ash);
}

/// App-wide [ThemeData] for the example app.
ThemeData galleryMonoTheme() {
  const scheme = ColorScheme.light(
    primary: Mono.black,
    onPrimary: Mono.white,
    secondary: Mono.blue,
    onSecondary: Mono.white,
    tertiary: Mono.blueDeep,
    surface: Mono.white,
    onSurface: Mono.ink,
    onSurfaceVariant: Mono.ash,
    surfaceContainerHighest: Mono.fog,
    outline: Mono.line,
    outlineVariant: Mono.line,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: Mono.fog,
    appBarTheme: const AppBarTheme(
      backgroundColor: Mono.fog,
      foregroundColor: Mono.ink,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: Mono.ink,
      ),
    ),
    cardTheme: const CardThemeData(
      color: Mono.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Mono.black,
        foregroundColor: Mono.white,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Mono.black,
      contentTextStyle: TextStyle(color: Mono.white),
      behavior: SnackBarBehavior.floating,
    ),
    dividerTheme: const DividerThemeData(color: Mono.line),
  );
}
