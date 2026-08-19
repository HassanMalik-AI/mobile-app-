import 'package:fitai_coach/core/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:fitai_coach/core/constants/sizes.dart';
import 'package:fitai_coach/core/constants/helper_function.dart';
import 'package:fitai_coach/features/auth_and_onboarding/login_screen/login.dart';
import 'package:fitai_coach/features/auth_and_onboarding/password_configuration/forget_password_controller.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.xmark),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image with 60% of screen width
            Image(
              image: const AssetImage(TImage.deliveryEmailIllustration),
              width: THelperFunction.screenWidth(context) * 0.6,
            ),
            const SizedBox(height: TSize.spaceBtwSections * 2),
            //title % subtitle
            Text(
              textAlign: TextAlign.center,
              TText.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSize.spaceBtwItems),
            Text(
              textAlign: TextAlign.center,
              TText.changeYourPasswordSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: TSize.spaceBtwItems),
            //button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.off (() => const LoginScreen()),
                child: const Text(TText.done),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                child: const Text(TText.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
