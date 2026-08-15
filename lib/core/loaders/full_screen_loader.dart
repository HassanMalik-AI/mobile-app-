import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitai_coach/core/constants/colors.dart';
import 'package:fitai_coach/core/constants/helper_function.dart';
import 'package:fitai_coach/core/utils/loaders/animation_loader.dart';

/// A utility class for managing a full-screen loading dialog.
class TFullScreenLoader {
  /// Opens a full-screen loading dialog with a given text and animation.
  /// This method does not return anything.
  /// Parameters:
  /// text: the text to be displayed in the loading dialog
  /// animation: the lottie animation to be shown
  static void openLoadingDialog(String text, String animation) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Container(
          color: THelperFunction.isDarkMode(Get.overlayContext ?? Get.context!)
              ? TColors.black
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              TAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Stop the loading dialog
  static void stopLoading() {
    Navigator.of(Get.overlayContext ?? Get.context!).pop();
  }
}
