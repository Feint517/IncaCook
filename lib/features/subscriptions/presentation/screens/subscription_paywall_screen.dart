import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/controllers/user_controller.dart';
import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/features/subscriptions/presentation/widgets/seller_subscription_view.dart';

/// Shown by [SubscriptionGate] to a seller whose monthly subscription is not
/// ACTIVE/TRIALING — i.e. they skipped it during signup, or it later expired /
/// was canceled / lapsed. Uses the SAME RevenueCat flow as the signup step
/// (via [SellerSubscriptionView]); plans + prices depend on the seller's
/// category — no fixed "4 $ / mois".
///
/// On success it refreshes the user from the server; the gate's `Obx` then
/// sees `subscriptionActive == true` and reveals the seller feature behind it
/// (no manual navigation). Stripe is untouched (orders / wallet / payouts).
class SubscriptionPaywallScreen extends StatelessWidget {
  const SubscriptionPaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final category =
        UserController.instance.user.value?.sellerAccount?.category ??
            SellerCategory.faitMaison;

    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.paywallTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: AppSizes.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.paywallSubtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(AppSizes.lg),
              SellerSubscriptionView(
                category: category,
                // Re-pull /users/me so the SubscriptionGate (Obx on
                // sellerAccount.subscriptionActive) reveals the seller home.
                onActivated: () async {
                  await UserController.instance.refreshFromServer();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
