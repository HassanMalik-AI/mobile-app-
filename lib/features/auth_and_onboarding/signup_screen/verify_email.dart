import 'package:fitai_coach/core/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:fitai_coach/core/constants/animation_strings.dart';
//import 'package:fitai_coach/core/utils/usecases/logout_usecase.dart';
import 'package:lottie/lottie.dart';
import 'package:fitai_coach/features/auth_and_onboarding/signup_screen/verify_email_controller.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Animation
              Lottie.asset(
                TAnimation.emailSent,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              const SizedBox(height: TSize.spaceBtwItems),

              //Title and subtitle
              Text(
                TText.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              Text(
                TText.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              //button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: Text(
                    TText.tContinue,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              //Resend Email link
              TextButton(
                onPressed: () => controller.sendEmailVerification(),
                child: const Text(TText.resendEmail),
              ),
              const SizedBox(height: TSize.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
