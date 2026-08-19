import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// Splash screen that matches flutter_native_splash exactly.
///
/// Native Splash
///      ↓
/// Flutter Splash
///      ↓
/// Home / Login
class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({
    super.key,
    this.onComplete,
    this.nextScreen,
    this.holdDuration = const Duration(milliseconds: 500),
    this.transitionDuration = const Duration(milliseconds: 250),
  }) : assert(
         onComplete != null || nextScreen != null,
         'Provide either onComplete or nextScreen.',
       );

  final VoidCallback? onComplete;
  final Widget? nextScreen;
  final Duration holdDuration;
  final Duration transitionDuration;

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  static const String _lightLogo = 'assets/logo/light_logo.png';
  static const String _darkLogo = 'assets/logo/dark_logo.png';

  static const String _lightBrand = 'assets/logo/hinberb_light_logo.png';
  static const String _darkBrand = 'assets/logo/hinberb_dark_logo.png';

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    _timer = Timer(widget.holdDuration, _navigate);
  }

  void _navigate() {
    if (!mounted) return;

    if (widget.onComplete != null) {
      widget.onComplete!();
      return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: widget.transitionDuration,
        reverseTransitionDuration: widget.transitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) =>
            FadeTransition(opacity: animation, child: widget.nextScreen!),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF00030A)
          : const Color(0xFFF5F7FC),
      body: Stack(
        children: [
          // Center Logo
          Center(
            child: Image.asset(
              isDark ? _darkLogo : _lightLogo,
              width: 110,
              height: 110,
              fit: BoxFit.contain,
            ),
          ),

          // Bottom Branding
          Positioned(
            
            left: 0,
            right: 0,
            bottom: 36,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'from',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                    color: isDark
                        ? const Color(0xFF8A8A8A)
                        : const Color(0xFF9E9E9E),
                  ),
                ),

                const SizedBox(height: 8),

                Image.asset(
                  isDark ? _darkBrand : _lightBrand,
                  width: 140,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
