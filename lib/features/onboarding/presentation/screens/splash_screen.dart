import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

/// First screen shown on app launch.
///
/// Shows the app logo centered on the [Background] token with a simple
/// fade-in, while quietly checking login status and app version in the
/// background. Once both checks resolve (and a minimum splash duration
/// has elapsed so the fade never feels clipped), it navigates to
/// Onboarding, Login, or Home.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
    _bootstrap();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    // Run the real checks alongside a minimum visible-splash duration so
    // the fade-in never gets cut off by a fast network/disk response.
    final results = await Future.wait([
      _checkLoginStatus(),
      _checkAppVersion(),
      Future.delayed(const Duration(milliseconds: 1100)),
    ]);

    final isLoggedIn = results[0] as bool;
    final isFirstLaunch = results[1] as bool;

    if (!mounted) return;

    if (isFirstLaunch) {
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    } else if (isLoggedIn) {
      // TODO: replace with the real Home route once it exists.
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // TODO: replace with the real Login route name/import once wired.
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  /// TODO: wire up to the real auth repository / token storage
  /// (e.g. check a stored session token via secure storage).
  Future<bool> _checkLoginStatus() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return false;
  }

  /// TODO: wire up to package_info_plus + a remote "minimum supported
  /// version" check, and/or shared_preferences for first-launch state.
  Future<bool> _checkAppVersion() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true; // true == treat as first launch -> show onboarding
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(opacity: _fadeAnimation, child: const _AppLogo()),
      ),
    );
  }
}

class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.bolt_rounded,
            size: 52,
            color: colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text('FitAI Coach', style: theme.textTheme.titleLarge),
      ],
    );
  }
}
