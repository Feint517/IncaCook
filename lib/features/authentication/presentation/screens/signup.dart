import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:vinted_v2/core/common/widgets/appbar/appbar.dart';
import 'package:vinted_v2/core/common/widgets/login_signup/form_divider.dart';
import 'package:vinted_v2/core/common/widgets/login_signup/social_buttons.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';
import 'package:vinted_v2/features/authentication/domain/user_type.dart';
import 'package:vinted_v2/features/authentication/presentation/widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key, required this.userType});

  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: const CustomAppBar(showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* title
              Text(
                AppTexts.signUpTitile,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(AppSizes.spaceBtwSections),

              //* form
              SignupForm(userType: userType),
              const Gap(AppSizes.spaceBtwSections),

              //* divider
              FormDivider(dividerText: AppTexts.orSignUpWith.capitalize!),
              const Gap(AppSizes.spaceBtwSections),

              //* social buttons
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
