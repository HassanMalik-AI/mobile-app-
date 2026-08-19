import 'package:fitai_coach/core/constants/text_strings.dart';
import 'package:fitai_coach/core/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:fitai_coach/core/widgets/style/spacing_styles.dart';
import 'package:fitai_coach/core/widgets/login/login_header.dart';
import 'package:fitai_coach/core/widgets/login/form_divider.dart';
import 'package:fitai_coach/core/widgets/login/login_form.dart';
import 'package:fitai_coach/core/widgets/login/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo & welcome text
              const TLoginHeader(),

              /// Email & password form
              const TLoginForm(),
              const TFormDivider(dividerText: TText.orSignInWith),
              const SizedBox(height: TSize.spaceBtwItems),
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
