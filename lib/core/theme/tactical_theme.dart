import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// DFEI Tactical Dark Mode theme.
///
/// High-contrast dark palette designed for field use under varied
/// lighting conditions. Neon blue accent for primary actions,
/// Roboto Mono for data readability.
class TacticalTheme {
  TacticalTheme._();

  // ---------------------------------------------------------------------------
  // Color palette
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF0F172A);
  static const Color surfaceVariant = Color(0xFF1E293B);
  static const Color cardColor = Color(0xFF1A1A2E);

  static const Color neonBlue = Color(0xFF00D4FF);
  static const Color neonBlueLight = Color(0xFF67E8F9);
  static const Color neonBlueDark = Color(0xFF0891B2);

  static const Color critical = Color(0xFFFF3B30);
  static const Color high = Color(0xFFFF6B35);
  static const Color warning = Color(0xFFFFB800);
  static const Color success = Color(0xFF34C759);
  static const Color low = Color(0xFF64748B);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static const Color divider = Color(0xFF334155);

  // ---------------------------------------------------------------------------
  // Volatility level colors
  // ---------------------------------------------------------------------------

  static Color volatilityColor(String level) {
    switch (level.toUpperCase()) {
      case 'CRITICAL':
        return critical;
      case 'HIGH':
        return high;
      case 'MEDIUM':
        return warning;
      case 'LOW':
        return low;
      default:
        return textMuted;
    }
  }

  // ---------------------------------------------------------------------------
  // Text styles
  // ---------------------------------------------------------------------------

  static TextStyle get monoData => GoogleFonts.robotoMono(
        fontSize: 13,
        color: textPrimary,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get monoDataSmall => GoogleFonts.robotoMono(
        fontSize: 11,
        color: textSecondary,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get monoDataBold => GoogleFonts.robotoMono(
        fontSize: 13,
        color: textPrimary,
        fontWeight: FontWeight.w700,
      );

  // ---------------------------------------------------------------------------
  // ThemeData
  // ---------------------------------------------------------------------------

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: neonBlue,
        onPrimary: background,
        secondary: neonBlueLight,
        onSecondary: background,
        surface: surface,
        onSurface: textPrimary,
        error: critical,
        onError: textPrimary,
      ),
      cardTheme: const CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: divider, width: 0.5),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.roboto(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textMuted,
        ),
        labelLarge: GoogleFonts.robotoMono(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: neonBlue,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonBlue,
          foregroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: neonBlue,
          side: const BorderSide(color: neonBlue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        hintStyle: GoogleFonts.roboto(color: textMuted, fontSize: 14),
        labelStyle: GoogleFonts.roboto(color: textSecondary, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: neonBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 0.5,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: neonBlue,
        foregroundColor: background,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaceVariant,
        contentTextStyle: GoogleFonts.roboto(color: textPrimary, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: neonBlue,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
