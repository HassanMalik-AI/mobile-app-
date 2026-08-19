import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:fitai_coach/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:fitai_coach/services/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:fitai_coach/core/utils/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fitai_coach/features/auth_and_onboarding/signup_screen/verify_email.dart';
import 'package:fitai_coach/core/utils/loaders/loaders.dart';
import 'package:fitai_coach/core/utils/network/network_manager.dart';
import 'package:fitai_coach/core/utils/loaders/full_screen_loader.dart';
import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:fitai_coach/core/constants/animation_strings.dart';
import 'package:fitai_coach/core/utils/usecases/register_usecase.dart';
//import 'package:fitai_coach/core/utils/helper/formatter.dart';
import 'package:fitai_coach/core/utils/helper/age_calculator.dart'; // ✅ ADD THIS

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  ///variable
  final privacyPolicy = false.obs;
  final termAndConditions = false.obs;
  final RxBool hidePassword = true.obs;
  final RxBool hideConfirmPassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNo = TextEditingController();
  final username = TextEditingController();

  // ✅ Only ONE source of truth for birth date now — removed `selectedBirthDate` and `age` (unused)
  final Rx<DateTime?> birthDate = Rx<DateTime?>(null);
  final RxString birthDateError = ''.obs;

  bool get isMinorFlag =>
      birthDate.value != null ? AgeCalculator.isMinor(birthDate.value!) : false;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // ✅ ADD THIS — form calls controller.pickBirthDate(context), it didn't exist before
  Future<void> pickBirthDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 18),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Select Date of Birth',
    );
    if (picked != null) {
      birthDate.value = picked;
      birthDateError.value = ''; // clear error once user picks a valid date
    }
  }

  // ✅ ADD THIS — validates before allowing submit
  bool _validateBirthDate() {
    final error = AgeCalculator.validateBirthDate(birthDate.value);
    birthDateError.value = error ?? '';
    return error == null;
  }

  ///signup
  void signup() async {
    try {
      // 1. Form validation first (do not open loader if fields are invalid)
      if (signupFormKey.currentState == null ||
          !signupFormKey.currentState!.validate()) {
        return;
      }

      // ✅ ADD THIS — 1.5: Birth date validation (blocks submit if missing/invalid)
      if (!_validateBirthDate()) {
        return;
      }

      // 2. Privacy policy check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: "Accept Privacy Policy",
          message:
              "Please agree to the privacy policy and terms and conditions",
        );
        return;
      }

      // 3. Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your internet connection and try again.',
        );
        return;
      }

      // 4. Start loading dialog only after all validations pass
      TFullScreenLoader.openLoadingDialog(
        TText.loading,
        TAnimation.docerAnimation,
      );

      // 5. Register user in Firebase Authentication using UseCase
      final user = await Get.find<RegisterUseCase>().call(
        email.text.trim(),
        password.text.trim(),
      );

      if (user == null) {
        throw 'Registration failed. User is empty.';
      }

      // 6. Save authentication user data in Firebase Firestore
      final newUser = UserModel(
        id: user.id,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNo: phoneNo.text.trim(),
        profilePicture: '',
        birthDate: birthDate.value, // ✅ fixed: uses birthDate.value now
        isMinor: isMinorFlag,
      );

      final userRepository = UserRepository.instance;
      try {
        await userRepository.saveUserRecord(newUser);
      } catch (e) {
        try {
          await firebase.FirebaseAuth.instance.currentUser?.delete();
        } catch (_) {}
        rethrow;
      }

      // 7. Stop loading dialog before navigating
      TFullScreenLoader.stopLoading();

      // 8. Show success message
      TLoaders.successSnackBar(
        title: "Success",
        message: "User registered successfully",
      );

      // 9. Navigate to verify email screen
      Get.offAll(() => VerifyEmailScreen(email: email.text.trim()));
    } on firebase.FirebaseAuthException catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: "Oh snap!",
        message: TFirebaseAuthException(e.code).message,
      );
    } catch (e) {
      // Stop loading dialog on exception
      TFullScreenLoader.stopLoading();
      // Show error message
      TLoaders.errorSnackBar(
        title: "Oh snap!",
        message: e is String ? e : 'Something went wrong, please try again.',
      );
    }
  }
}
