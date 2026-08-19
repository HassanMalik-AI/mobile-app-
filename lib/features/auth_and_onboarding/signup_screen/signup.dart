import 'package:fitai_coach/core/widgets/style/spacing_styles.dart';
import 'package:fitai_coach/core/constants/sizes.dart';
import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:fitai_coach/core/widgets/login/form_divider.dart';
import 'package:fitai_coach/core/widgets/login/social_buttons.dart';
import 'package:fitai_coach/core/widgets/signup/signup_form.dart';
import 'package:fitai_coach/core/widgets/signup/signup_header.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, title, subtitle — dark/light handled inside the widget.
              const TSignupHeader(),
              const SizedBox(height: TSize.spaceBtwItems),

              // First name, last name, email, phone, password fields.
              const TSignupForm(),
              const SizedBox(height: TSize.spaceBtwItems),

              // Already have an account? -> back to login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text(
                      TText.alreadyHaveAnAccount,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(TText.signIn),
                  ),
                ],
              ),
              const SizedBox(height: TSize.spaceBtwSections / 2),

              // Reused from login screen — no duplication.
              const TFormDivider(dividerText: TText.orSignUpWith),
              const SizedBox(height: TSize.spaceBtwItems / 2),
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
