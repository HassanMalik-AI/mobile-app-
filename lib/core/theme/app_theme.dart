import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Central place for the app's [ThemeData] objects.
///
/// - Headline/number styles use a bold condensed face (Inter Tight).
/// - Body/label styles use a standard face (Inter).
/// - Cards: 16-20px corner radius. Dark mode relies on a 1px border in a
///   slightly lighter tone instead of a shadow; light mode uses a soft
///   ~6% opacity shadow instead of a border.
///
/// Requires the `google_fonts` package in pubspec.yaml:
///   dependencies:
///     google_fonts: ^6.2.1
class AppTheme {
  AppTheme._();

  static const double _cardRadius = 18; // within the 16-20px range
  static const double _controlRadius = 14;

  // ---------------------------------------------------------------------
  // Shared text theme builder
  // ---------------------------------------------------------------------
  static TextTheme _buildTextTheme({
    required Color primaryText,
    required Color secondaryText,
  }) {
    final condensed = GoogleFonts.interTightTextTheme();
    final body = GoogleFonts.interTextTheme();

    return TextTheme(
      // Headlines / large numeric displays -> bold condensed
      displayLarge: condensed.displayLarge?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      displayMedium: condensed.displayMedium?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      displaySmall: condensed.displaySmall?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: condensed.headlineLarge?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: condensed.headlineMedium?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: condensed.headlineSmall?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: condensed.titleLarge?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: condensed.titleMedium?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: condensed.titleSmall?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w600,
      ),

      // Body / labels -> standard face
      bodyLarge: body.bodyLarge?.copyWith(color: primaryText),
      bodyMedium: body.bodyMedium?.copyWith(color: primaryText),
      bodySmall: body.bodySmall?.copyWith(color: secondaryText),
      labelLarge: body.labelLarge?.copyWith(
        color: primaryText,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: body.labelMedium?.copyWith(color: secondaryText),
      labelSmall: body.labelSmall?.copyWith(color: secondaryText),
    );
  }

  // ---------------------------------------------------------------------
  // DARK THEME
  // ---------------------------------------------------------------------
  static ThemeData get dark {
    final colorScheme = ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      surface: AppColorsDark.surface,
      primary: AppColorsDark.primary,
      onPrimary: AppColorsDark.background,
      secondary: AppColorsDark.secondary,
      onSecondary: AppColorsDark.background,
      tertiary: AppColorsDark.tertiary,
      onTertiary: AppColorsDark.background,
      onSurface: AppColorsDark.textPrimary,
      outline: AppColorsDark.border,
      error: AppColorsDark.secondary,
      onError: AppColorsDark.background,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColorsDark.background,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(
        primaryText: AppColorsDark.textPrimary,
        secondaryText: AppColorsDark.textSecondary,
      ),
      dividerColor: AppColorsDark.border,
      dividerTheme: DividerThemeData(
        color: AppColorsDark.border,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsDark.background,
        foregroundColor: AppColorsDark.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.interTight(
          color: AppColorsDark.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      // Dark mode cards: no shadow, 1px border in a slightly lighter tone.
      cardTheme: CardThemeData(
        color: AppColorsDark.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
          side: BorderSide(color: AppColorsDark.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsDark.primary,
          foregroundColor: AppColorsDark.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_controlRadius),
          ),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorsDark.textPrimary,
          side: BorderSide(color: AppColorsDark.border, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_controlRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColorsDark.primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsDark.surfaceElevated,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: GoogleFonts.inter(color: AppColorsDark.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
          borderSide: BorderSide(color: AppColorsDark.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
          borderSide: BorderSide(color: AppColorsDark.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
          borderSide: BorderSide(color: AppColorsDark.primary, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColorsDark.surfaceElevated,
        side: BorderSide(color: AppColorsDark.border),
        labelStyle: GoogleFonts.inter(color: AppColorsDark.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      iconTheme: IconThemeData(color: AppColorsDark.textPrimary),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColorsDark.primary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorsDark.surface,
        selectedItemColor: AppColorsDark.primary,
        unselectedItemColor: AppColorsDark.textSecondary,
      ),
    );
  }

  // ---------------------------------------------------------------------
  // LIGHT THEME
  // ---------------------------------------------------------------------
  static ThemeData get light {
    final colorScheme = ColorScheme.light().copyWith(
      brightness: Brightness.light,
      surface: AppColorsLight.surface,
      primary: AppColorsLight.primary,
      onPrimary: AppColorsLight.surface,
      secondary: AppColorsLight.secondary,
      onSecondary: AppColorsLight.surface,
      tertiary: AppColorsLight.tertiary,
      onTertiary: AppColorsLight.surface,
      onSurface: AppColorsLight.textPrimary,
      outline: AppColorsLight.border,
      error: AppColorsLight.secondary,
      onError: AppColorsLight.surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColorsLight.background,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(
        primaryText: AppColorsLight.textPrimary,
        secondaryText: AppColorsLight.textSecondary,
      ),
      dividerColor: AppColorsLight.border,
      dividerTheme: DividerThemeData(
        color: AppColorsLight.border,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsLight.background,
        foregroundColor: AppColorsLight.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.interTight(
          color: AppColorsLight.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      // Light mode cards: no border, soft shadow at ~6% opacity instead.
      cardTheme: CardThemeData(
        color: AppColorsLight.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: AppColorsLight.textPrimary.withValues(alpha: 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.primary,
          foregroundColor: AppColorsLight.surface,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_controlRadius),
          ),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorsLight.textPrimary,
          side: BorderSide(color: AppColorsLight.border, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_controlRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColorsLight.primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsLight.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: GoogleFonts.inter(color: AppColorsLight.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
          borderSide: BorderSide(color: AppColorsLight.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
          borderSide: BorderSide(color: AppColorsLight.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_controlRadius),
          borderSide: BorderSide(color: AppColorsLight.primary, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColorsLight.background,
        side: BorderSide(color: AppColorsLight.border),
        labelStyle: GoogleFonts.inter(color: AppColorsLight.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      iconTheme: IconThemeData(color: AppColorsLight.textPrimary),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColorsLight.primary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorsLight.surface,
        selectedItemColor: AppColorsLight.primary,
        unselectedItemColor: AppColorsLight.textSecondary,
      ),
    );
  }
}
