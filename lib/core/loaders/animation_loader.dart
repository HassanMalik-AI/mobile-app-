import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fitai_coach/core/constants/sizes.dart';
import 'package:fitai_coach/core/constants/colors.dart';
import 'package:fitai_coach/core/constants/helper_function.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunction.isDarkMode(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(height: TSize.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? TColors.white : TColors.textPrimary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSize.defaultSpace),
          showAction && actionText != null
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isDark ? TColors.dark : TColors.light,
                    ),
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? TColors.white : TColors.dark,
                          ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
