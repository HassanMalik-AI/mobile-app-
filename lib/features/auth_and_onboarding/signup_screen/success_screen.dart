import "package:fitai_coach/core/widgets/style/spacing_styles.dart";
import "package:flutter/material.dart";
import "package:fitai_coach/core/constants/sizes.dart";
import 'package:fitai_coach/core/constants/helper_function.dart';
import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:lottie/lottie.dart';
import 'package:fitai_coach/core/constants/animation_strings.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                TAnimation.success,
                width: THelperFunction.screenWidth(context) * 0.6,
              ),
              const SizedBox(height: TSize.spaceBtwItems),

              //Title and subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSize.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSize.spaceBtwItems),

              //Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(TText.tContinue),
                ),
              ),
              const SizedBox(height: TSize.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
