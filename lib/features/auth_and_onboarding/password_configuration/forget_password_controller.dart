import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:fitai_coach/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:fitai_coach/core/utils/usecases/reset_password_usecase.dart';
import 'package:fitai_coach/core/utils/loaders/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fitai_coach/core/constants/animation_strings.dart';
import 'package:fitai_coach/core/utils/network/network_manager.dart';
import 'package:fitai_coach/core/utils/loaders/loaders.dart';
import 'package:fitai_coach/features/auth_and_onboarding/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variable
  final email = TextEditingController();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  Future<void> sendPasswordResetEmail() async {
    try {
      // 1. Form validation
      if (forgetPasswordFormKey.currentState == null ||
          !forgetPasswordFormKey.currentState!.validate()) {
        return;
      }

      // 2. Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your internet connection and try again.',
        );
        return;
      }

      // 3. Start loading dialog
      TFullScreenLoader.openLoadingDialog(
        'Sending password reset email...',
        TAnimation.docerAnimation,
      );

      // 4. Send reset email
      await Get.find<ResetPasswordUseCase>().call(email.text.trim());

      // 5. Remove loader BEFORE navigating or showing snackbars
      TFullScreenLoader.stopLoading();

      // 6. Show success message
      TLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Password reset email sent. Please check your inbox.',
      );

      // 7. Navigate to ResetPasswordScreen
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } on firebase.FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: TFirebaseAuthException(e.code).message,
      );
    } catch (e, st) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Error sending reset email: $e\n$st');
      }
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e is String ? e : 'Something went wrong, please try again.',
      );
    }
  }

  Future<void> resendPasswordResetEmail(String emailAddress) async {
    try {
      // 1. Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your internet connection and try again.',
        );
        return;
      }

      // 2. Start loading dialog
      TFullScreenLoader.openLoadingDialog(
        'Sending password reset email...',
        TAnimation.docerAnimation,
      );

      // 3. Send reset email using the explicitly provided address
      await Get.find<ResetPasswordUseCase>().call(emailAddress.trim());

      // 4. Remove loader BEFORE showing snackbar
      TFullScreenLoader.stopLoading();

      // 5. Show success message
      TLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Password reset email sent. Please check your inbox.',
      );
    } on firebase.FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: TFirebaseAuthException(e.code).message,
      );
    } catch (e, st) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Error resending reset email: $e\n$st');
      }
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e is String ? e : 'Something went wrong, please try again.',
      );
    }
  }
}
