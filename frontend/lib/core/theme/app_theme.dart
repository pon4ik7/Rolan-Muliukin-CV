import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPalette {
  static const Color background = Color(0xFF070D1B);
  static const Color surface = Color(0xFF111A2D);
  static const Color surfaceAlt = Color(0xFF0D1424);
  static const Color border = Color(0xFF2A3F66);
  static const Color primary = Color(0xFF3E8BFF);
  static const Color secondary = Color(0xFF35D5FF);
  static const Color success = Color(0xFF42D392);
  static const Color textPrimary = Color(0xFFE9EEFF);
  static const Color textSecondary = Color(0xFF9BB0D6);
}

class AppTheme {
  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.spaceGroteskTextTheme().copyWith(
      bodyMedium: GoogleFonts.manrope(
        color: AppPalette.textPrimary,
        fontSize: 16,
        height: 1.5,
      ),
      bodyLarge: GoogleFonts.manrope(
        color: AppPalette.textPrimary,
        fontSize: 18,
        height: 1.6,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        color: AppPalette.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      headlineLarge: GoogleFonts.spaceGrotesk(
        color: AppPalette.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppPalette.background,
      colorScheme: const ColorScheme.dark(
        primary: AppPalette.primary,
        secondary: AppPalette.secondary,
        surface: AppPalette.surface,
        onSurface: AppPalette.textPrimary,
      ),
      textTheme: textTheme,
      cardTheme: const CardThemeData(
        color: AppPalette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
