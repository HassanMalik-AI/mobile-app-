import 'dart:async';

import 'package:fitai_coach/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:fitai_coach/core/constants/image_strings.dart';
import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:fitai_coach/core/utils/loaders/loaders.dart';
import 'package:fitai_coach/core/utils/usecases/logout_usecase.dart';
import 'package:fitai_coach/core/utils/usecases/verify_email_usecase.dart';
import 'package:fitai_coach/features/auth_and_onboarding/signup_screen/success_screen.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final SendVerificationEmailUseCase _sendVerificationEmailUseCase = Get.find();
  final CheckEmailVerifiedUseCase _checkEmailVerifiedUseCase = Get.find();

  Timer? _timer;

  /// Send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;
    super.onClose();
  }

  /// Cancels polling, calls LogoutUseCase, and navigates to /login
  Future<void> logout() async {
    _timer?.cancel();
    _timer = null;
    try {
      final logoutUseCase = Get.find<LogoutUseCase>();
      await logoutUseCase.call();
    } catch (_) {}
    Get.offAllNamed('/login');
  }

  /// Send email verification
  void sendEmailVerification() async {
    try {
      await _sendVerificationEmailUseCase.call();
      TLoaders.successSnackBar(
        title: "Email Sent!",
        message: "Please check your inbox and verify your email",
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }

  /// Timer to automatically redirect on email verification
  void setTimerForAutoRedirect() {
    final authService = Get.find<AuthService>();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final currentUser = authService.currentUser;
        if (currentUser == null) {
          timer.cancel();
          _timer = null;
          return;
        }
        await authService.reloadUser();
        if (authService.isCurrentUserEmailVerified) {
          timer.cancel();
          _timer = null;
          _navigateToSuccess();
        }
      } catch (e) {
        // silently ignore reload errors (e.g. network issues)
      }
    });
  }

  /// Manual check if email is verified
  Future<void> checkEmailVerificationStatus() async {
    try {
      final isVerified = await _checkEmailVerifiedUseCase.call();
      if (isVerified) {
        _timer?.cancel();
        _navigateToSuccess();
      } else {
        TLoaders.warningSnackBar(
          title: "Not Verified",
          message: "Email not verified yet. Please check your inbox.",
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }

  void _navigateToSuccess() {
    final authService = Get.find<AuthService>();
    Get.offAll(
      () => SuccessScreen(
        image: TImage.success,
        title: TText.yourAccountCreatedTitle,
        subTitle: TText.yourAccountCreatedSubTitle,
        onPressed: () async {
          if (authService.currentUser == null) {
            Get.offAllNamed('/login');
            return;
          }

          if (authService.isCurrentUserEmailPasswordProvider &&
              !authService.isCurrentUserEmailVerified) {
            // Email not yet verified — return to verify_email screen, not login
            Get.offAllNamed('/verify_email');
            return;
          }

          Get.offAllNamed('/profile_setup');
        },
      ),
    );
  }
}
