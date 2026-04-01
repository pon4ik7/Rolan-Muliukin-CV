import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPalette {
  static const Color primary = Color(0xFF5D4432);
  static const Color secondary = Color(0xFFE9E3DD);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);
  static const Color surface = Color(0xFFF9F7F5);
  static const Color textPrimary = Color(0xFF3E2B1E);
  static const Color background = Color(0xFFF2ECE6);
  static const Color surfaceAlt = Color(0xFFEEE5DC);
  static const Color border = Color(0xFFD9C9BA);
  static const Color textSecondary = Color(0xFF765F4F);
  static const Color accent = Color(0xFF8D6A4D);
  static const Color onPrimary = Color(0xFFFFF8F2);
}

class AppTheme {
  static ThemeData get cafeTheme {
    final textTheme = GoogleFonts.notoSansTextTheme().copyWith(
      bodySmall: GoogleFonts.notoSans(
        color: AppPalette.textSecondary,
        fontSize: 13,
        height: 1.45,
      ),
      bodyMedium: GoogleFonts.notoSans(
        color: AppPalette.textPrimary,
        fontSize: 16,
        height: 1.58,
      ),
      bodyLarge: GoogleFonts.notoSans(
        color: AppPalette.textPrimary,
        fontSize: 18,
        height: 1.62,
      ),
      labelLarge: GoogleFonts.notoSans(
        color: AppPalette.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.notoSans(
        color: AppPalette.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      titleLarge: GoogleFonts.notoSans(
        color: AppPalette.textPrimary,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.notoSans(
        color: AppPalette.textPrimary,
        fontSize: 42,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.06,
      ),
      headlineLarge: GoogleFonts.notoSans(
        color: AppPalette.textPrimary,
        fontSize: 56,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
        height: 1.0,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppPalette.background,
      colorScheme: const ColorScheme.light(
        primary: AppPalette.primary,
        secondary: AppPalette.accent,
        surface: AppPalette.surface,
        onSurface: AppPalette.textPrimary,
        onPrimary: AppPalette.onPrimary,
        error: AppPalette.danger,
      ),
      textTheme: textTheme,
      cardTheme: CardTheme(
        color: AppPalette.surface,
        shadowColor: AppPalette.primary.withOpacity(0.08),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppPalette.border),
        ),
      ),
      dividerColor: AppPalette.border,
      iconTheme: const IconThemeData(color: AppPalette.accent),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppPalette.textPrimary,
        elevation: 0,
        titleTextStyle: textTheme.titleMedium,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppPalette.primary,
          foregroundColor: AppPalette.onPrimary,
          disabledBackgroundColor: AppPalette.border,
          disabledForegroundColor: AppPalette.textSecondary.withOpacity(0.9),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.primary,
          side: const BorderSide(color: AppPalette.border),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppPalette.primary,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppPalette.textPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: GoogleFonts.notoSans(
          color: AppPalette.onPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppPalette.textPrimary,
        contentTextStyle: GoogleFonts.notoSans(
          color: AppPalette.onPrimary,
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get darkTheme => cafeTheme;
}
