import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:fitai_coach/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:fitai_coach/services/auth_service.dart';
import 'package:fitai_coach/controller/user_controller.dart';
import 'package:fitai_coach/core/utils/loaders/full_screen_loader.dart';
import 'package:fitai_coach/core/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitai_coach/core/constants/animation_strings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fitai_coach/core/utils/network/network_manager.dart';
import 'package:fitai_coach/core/utils/usecases/login_usecase.dart';
import 'package:fitai_coach/core/utils/usecases/google_signin_usecase.dart';
import 'package:fitai_coach/core/utils/models/user_model.dart';
import 'package:fitai_coach/features/auth_and_onboarding/login_screen/login.dart';
import 'package:fitai_coach/features/auth_and_onboarding/onboarding_screen/onboarding.dart';
import 'package:fitai_coach/features/first_time_user_setup/home_screen+nav/navigation_menu.dart';
import 'package:fitai_coach/services/repository/user_repository.dart';
import 'package:fitai_coach/services/onboarding_service.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///variable
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final localStorage = GetStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final UserController userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  @visibleForTesting
  Future<void> navigateAfterAuth() => _navigateAfterAuth();

  Future<void> _navigateAfterAuth() async {
    final authService = Get.find<AuthService>();
    final uid = authService.currentUserUid;
    if (uid == null) {
      final onboardingService = Get.isRegistered<OnboardingService>()
          ? Get.find<OnboardingService>()
          : null;
      final hasCompletedOnboarding =
          onboardingService?.hasCompletedOnboarding() ?? true;
      if (!hasCompletedOnboarding) {
        Get.offAll(() => const Onboarding());
      } else {
        Get.offAll(() => const LoginScreen());
      }
      return;
    }

    if (authService.isCurrentUserEmailPasswordProvider &&
        !authService.isCurrentUserEmailVerified) {
      Get.offAllNamed('/verify_email');
      return;
    }

    final savedUser = await UserRepository.instance.getUserById(uid);
    if (savedUser == null ||
        savedUser.firstName.trim().isEmpty ||
        savedUser.lastName.trim().isEmpty ||
        savedUser.username.trim().isEmpty ||
        savedUser.email.trim().isEmpty) {
      Get.offAllNamed('/profile_setup');
      return;
    }

    Get.offAll(() => const NavigationMenu());
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // 1. Form validation first (do not open loader if fields are invalid)
      if (loginFormKey.currentState == null ||
          !loginFormKey.currentState!.validate()) {
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
        'Logging in...',
        TAnimation.docerAnimation,
      );
      //save data if remember me in selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user email & password authentication using UseCase
      final user = await Get.find<LoginUseCase>().call(
        email.text.trim(),
        password.text.trim(),
      );

      if (user != null) {
        try {
          final profile = await UserRepository.instance.getUserById(user.id);
          if (profile != null) {
            userController.user.value = profile;
          }
        } catch (e) {
          // Profile fetch failed, but user is authenticated in Firebase.
          // Stop loading immediately and show error.
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to load profile. Please try logging in again.',
          );
          return;
        }
      }

      //remove loader
      TFullScreenLoader.stopLoading();

      //redirect
      await _navigateAfterAuth();
    } on firebase.FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: TFirebaseAuthException(e.code).message,
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e is String ? e : 'Something went wrong, please try again.',
      );
    }
  }

  //google sign in
  Future<void> signInWithGoogle() async {
    try {
      // 1. Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your internet connection and try again.',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      // 2. Start loading dialog
      TFullScreenLoader.openLoadingDialog(
        'Logging in with Google...',
        TAnimation.docerAnimation,
      );

      // 3. Sign in with Google using UseCase
      final user = await Get.find<GoogleSignInUseCase>().call();
      if (user == null) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check if user already has a Firestore profile (returning user).
      final existingUser = await UserRepository.instance.getUserById(user.id);

      try {
        if (existingUser != null) {
          // Returning user — only update fields that may have changed from Google
          // (e.g. profilePicture, email). Preserve birthDate, isMinor, phoneNo, etc.
          await UserRepository.instance.updateUserRecord(user.id, {
            'email': user.email,
            'profilePicture': user.profilePicture,
          });
          userController.user.value = existingUser;
        } else {
          // New user — create the full Firestore document.
          final userModel = user is UserModel
              ? user
              : UserModel(
                  id: user.id,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  username: user.username,
                  email: user.email,
                  phoneNo: user.phoneNo,
                  profilePicture: user.profilePicture,
                  birthDate: null,
                  isMinor: false,
                );
          await UserRepository.instance.saveUserRecord(userModel);
          userController.user.value = userModel;
        }
      } catch (e) {
        try {
          await Get.find<AuthService>().logout();
        } catch (_) {}
        rethrow;
      }

      // 4. Remove loader
      TFullScreenLoader.stopLoading();

      // 5. Redirect
      await _navigateAfterAuth();
    } on firebase.FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: TFirebaseAuthException(e.code).message,
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e is String ? e : 'Something went wrong, please try again.',
      );
    }
  }
}
