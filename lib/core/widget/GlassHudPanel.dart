import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A translucent, blurred dark panel meant to float over a live camera
/// feed (e.g. form-check HUD controls during a workout).
///
/// This intentionally always uses the dark surface token — regardless of
/// the app's active [ThemeMode] — since it sits over live video and needs
/// to read the same way in both light and dark app themes.
class GlassHudPanel extends StatelessWidget {
  const GlassHudPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 20,
    this.blurSigma = 18,
    this.opacity = 0.7,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final double blurSigma;

  /// Opacity of the dark fill behind the blur, ~0.7 by default.
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColorsDark.background.withValues(alpha: opacity),
            borderRadius: radius,
            border: Border.all(
              color: AppColorsDark.border.withValues(alpha: 0.8),
              width: 1,
            ),
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: AppColorsDark.textPrimary),
            child: IconTheme(
              data: IconThemeData(color: AppColorsDark.textPrimary),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
