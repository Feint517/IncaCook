import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/features/authentication/controllers/signup_flow_controller.dart';
import 'package:incacook/features/authentication/presentation/widgets/signup_flow/signup_step_layout.dart';
import 'package:incacook/features/subscriptions/presentation/widgets/seller_subscription_view.dart';

/// Final seller step (10/10): pick the monthly subscription via RevenueCat.
/// The RevenueCat logic lives in the reusable [SellerSubscriptionView] (shared
/// with the post-login paywall). Here it just unlocks the bottom-bar "Terminer"
/// (gated on [SignupFlowController.subscriptionActive]) once active.
class SellerSubscriptionPage extends StatelessWidget {
  const SellerSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupFlowController>();
    final category = controller.sellerCategory.value ?? SellerCategory.faitMaison;
    return SignupStepLayout(
      title: AppTexts.signupSubscriptionTitle,
      description: AppTexts.signupSubscriptionSubtitle,
      child: SellerSubscriptionView(
        category: category,
        onActivated: () async => controller.subscriptionActive.value = true,
      ),
    );
  }
}
