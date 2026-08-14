import 'package:flutter/material.dart';

/// Color tokens for the FitAI Coach app.
///
/// Two static token sets are exposed: [AppColorsDark] and [AppColorsLight].
/// No pure black (#000000), pure white (#FFFFFF), or blue hues are used
/// anywhere in this palette by design.
class AppColorsDark {
  AppColorsDark._();

  // Surfaces
  static const Color background = Color(0xFF181310);
  static const Color surface = Color(0xFF241D18);
  static const Color surfaceElevated = Color(0xFF2F251F);

  // Structure
  static const Color border = Color(0xFF3D322A);

  // Text
  static const Color textPrimary = Color(0xFFF3ECE3);
  static const Color textSecondary = Color(0xFFA9998A);

  // Accents
  static const Color primary = Color(0xFFC4E538); // olive-lime
  static const Color secondary = Color(0xFFFF5A36); // coral ember
  static const Color tertiary = Color(0xFFC98A4B); // bronze/copper
}

class AppColorsLight {
  AppColorsLight._();

  // Surfaces
  static const Color background = Color(0xFFF7F1E8);
  static const Color surface = Color(0xFFFFFCF7);

  // Structure
  static const Color border = Color(0xFFE8DECE);

  // Text
  static const Color textPrimary = Color(0xFF1F1712);
  static const Color textSecondary = Color(0xFF7A6C5D);

  // Accents
  static const Color primary = Color(0xFF5C7A1F); // olive
  static const Color secondary = Color(0xFFD9481F); // coral
  static const Color tertiary = Color(0xFFA9702F); // bronze
}
