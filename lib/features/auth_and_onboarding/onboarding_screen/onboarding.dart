//

import 'package:fitai_coach/core/widgets/onboarding/onboarding_skip.dart';
import 'package:fitai_coach/core/widgets/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:fitai_coach/core/widgets/onboarding/onbording_dot_nvigtion.dart';
import 'package:fitai_coach/core/constants/animation_strings.dart'; // ← changed from image_strings.dart
import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:fitai_coach/core/widgets/onboarding/onboarding_next_button.dart';
import 'package:fitai_coach/features/auth_and_onboarding/onboarding_screen/onboarding_controller.dart';
import 'package:get/get.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                animation: TAnimation.onboarding1,
                title: TText.onboardingTitle1,
                subtitle: TText.onboardingSubtitle1,
              ),
              OnBoardingPage(
                animation: TAnimation.onboarding2,
                title: TText.onboardingTitle2,
                subtitle: TText.onboardingSubtitle2,
              ),
              OnBoardingPage(
                animation: TAnimation.onboarding3,
                title: TText.onboardingTitle3,
                subtitle: TText.onboardingSubtitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}
