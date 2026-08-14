import 'package:flutter/material.dart';

import '../../../../core/widgets/primary_button.dart';

/// Onboarding carousel shown to first-time users, introducing the app's
/// core features before they log in or register.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _slides = <_OnboardingSlideData>[
    _OnboardingSlideData(
      icon: Icons.accessibility_new_rounded,
      headline: 'Real-time pose coaching',
      description:
          'Point your camera at yourself and get live form cues as you '
          'move, so every rep is safer and more effective.',
    ),
    _OnboardingSlideData(
      icon: Icons.event_available_rounded,
      headline: 'Event countdown mode',
      description:
          'Set a race, meet, or photoshoot date and get a training plan '
          'that builds toward it, with a live countdown along the way.',
    ),
    _OnboardingSlideData(
      icon: Icons.camera_alt_rounded,
      headline: 'Weekly body scan',
      description:
          'A quick guided scan each week tracks real changes over time, '
          'no guesswork, no comparing yourself to anyone else.',
    ),
    _OnboardingSlideData(
      icon: Icons.favorite_rounded,
      headline: 'Couple mode',
      description:
          'Train alongside a partner, share streaks and stats, and keep '
          'each other accountable without leaving the app.',
    ),
  ];

  bool get _isLastPage => _currentPage == _slides.length - 1;

  void _onNext() {
    if (_isLastPage) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _finishOnboarding() {
    // TODO: mark onboarding as seen (e.g. shared_preferences) before
    // navigating, then wire to the real Register/Login route.
    Navigator.of(context).pushReplacementNamed('/register');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return _OnboardingSlide(data: _slides[index]);
                },
              ),
            ),
            _PageIndicator(count: _slides.length, currentIndex: _currentPage),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  TextButton(
                    onPressed: _isLastPage ? null : _finishOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: secondaryColor,
                    ),
                    child: Opacity(
                      opacity: _isLastPage ? 0 : 1,
                      child: const Text('Skip'),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 170,
                    child: PrimaryButton(
                      label: _isLastPage ? 'Get Started' : 'Next',
                      height: 48,
                      onPressed: _onNext,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.icon,
    required this.headline,
    required this.description,
  });

  final IconData icon;
  final String headline;
  final String description;
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.data});

  final _OnboardingSlideData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration placeholder — swap for real artwork later.
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              shape: BoxShape.circle,
              border: Border.all(color: theme.dividerColor, width: 1),
            ),
            alignment: Alignment.center,
            child: Icon(data.icon, size: 84, color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 40),
          Text(
            data.headline,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.count, required this.currentIndex});

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.dividerColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 24 : 8,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
