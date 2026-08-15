import 'package:fitai_coach/core/utils/loaders/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitai_coach/core/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class TLoaders {

  static void successSnackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: const Color.fromARGB(255, 19, 21, 21),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
      overlayBlur: 3,
      overlayColor: TColors.black.withValues(alpha: 0.5),
    );
  }

  //stop loader
  static void stopLoading() {
    TFullScreenLoader.stopLoading();
  }

  static void errorSnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: TColors.error,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
      overlayBlur: 3,
      overlayColor: TColors.black.withValues(alpha: 0.5),
    );
  }

  static void warningSnackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: TColors.warning,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.warning_2, color: TColors.primary),
      overlayBlur: 3,
      overlayColor: TColors.black.withValues(alpha: 0.5),
    );
  }
}
