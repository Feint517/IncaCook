import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/features/authentication/controllers/signup_flow_controller.dart';
import 'package:incacook/features/authentication/presentation/widgets/signup_flow/signup_step_layout.dart';
import 'package:incacook/features/authentication/presentation/widgets/signup_flow/signup_text_field.dart';

/// Confirm-your-name step for the NoProfile signup path.
///
/// Shown between legalAcceptance and roleSelection when the wizard
/// entered through `seedAsSignedIn` (e.g. first-time Google sign-in)
/// — basicInfo was skipped so we'd otherwise reach Gate 2 with empty
/// firstName/lastName, which the backend rejects with a length-≥2
/// validator. The fields are pre-filled from JWT claims when present;
/// the user can edit either freely (Google names are often wrong /
/// missing — single-word accounts ship no `family_name`).
class CompleteNamePage extends GetView<SignupFlowController> {
  const CompleteNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupStepLayout(
      title: AppTexts.signupCompleteNameTitle,
      description: AppTexts.signupCompleteNameSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SignupTextField(
                  controller: controller.firstNameTextController,
                  label: AppTexts.signupFirstNameLabel,
                  hint: AppTexts.signupFirstNameHint,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const Gap(AppSizes.sm + 4),
              Expanded(
                child: SignupTextField(
                  controller: controller.lastNameTextController,
                  label: AppTexts.signupLastNameLabel,
                  hint: AppTexts.signupLastNameHint,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
