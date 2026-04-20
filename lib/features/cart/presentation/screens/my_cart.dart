import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vinted_v2/core/common/widgets/appbar/appbar.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';
import 'package:vinted_v2/features/cart/controllers/cart_controller.dart';
import 'package:vinted_v2/features/cart/presentation/widgets/cart_footer.dart';
import 'package:vinted_v2/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:vinted_v2/features/cart/presentation/widgets/cart_seller_card.dart';
import 'package:vinted_v2/features/cart/presentation/widgets/empty_cart_state.dart';
import 'package:vinted_v2/features/cart/presentation/widgets/order_summary_block.dart';
import 'package:vinted_v2/features/home/domain/food_listing.dart';
import 'package:vinted_v2/features/orders/domain/delivery_details.dart';
import 'package:vinted_v2/features/orders/domain/fulfillment_options.dart';
import 'package:vinted_v2/features/orders/presentation/screens/delivery_address.dart';
import 'package:vinted_v2/features/orders/presentation/screens/order_summary.dart';
import 'package:vinted_v2/features/orders/presentation/widgets/fulfillment_choice_sheet.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  Future<void> _continueToFulfillment(
    BuildContext context,
    FoodListing seller,
  ) async {
    final options = FulfillmentOptions(
      deliveryAvailable:
          seller.fulfillment == Fulfillment.delivery ||
          seller.fulfillment == Fulfillment.both,
      deliveryMinMinutes: 25,
      deliveryMaxMinutes: 40,
      deliveryFee: AppTexts.cartShippingFee,
      pickupAvailable:
          seller.fulfillment == Fulfillment.pickup ||
          seller.fulfillment == Fulfillment.both,
      pickupNeighborhood: 'Bastille, Paris 11ème',
    );

    final selection = await FulfillmentChoiceSheet.resolve(
      context,
      options: options,
    );
    if (selection == null || !context.mounted) return;

    DeliveryDetails? deliveryDetails;
    if (selection.choice == FulfillmentChoice.delivery) {
      deliveryDetails = await Get.to<DeliveryDetails>(
        () => const DeliveryAddressScreen(),
      );
      if (deliveryDetails == null || !context.mounted) return;
    }

    await Get.to<void>(
      () => OrderSummaryScreen(
        selection: selection,
        options: options,
        deliveryDetails: deliveryDetails,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          AppTexts.cartTitleFr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [Obx(() => _CartBadge(count: cart.itemCount))],
      ),
      body: Obx(() {
        if (cart.isEmpty) {
          return EmptyCartState(onGoHome: () => Get.back<void>());
        }

        final seller = cart.sellerReference!;
        return Stack(
          children: [
            Positioned.fill(
              // child: SingleChildScrollView(
              //   padding: const EdgeInsets.all(AppSizes.md),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              //       for (final item in cart.items) ...[
              //         Dismissible(
              //           key: ValueKey(item.id),
              //           direction: DismissDirection.endToStart,
              //           background: const _DismissBackground(),
              //           onDismissed: (_) => cart.removeItem(item.id),
              //           child: CartItemCard(
              //             item: item,
              //             onIncrement: () => cart.incrementQuantity(item.id),
              //             onDecrement: () => cart.decrementQuantity(item.id),
              //             onRemove: () => cart.removeItem(item.id),
              //           ),
              //         ),
              //         const Gap(AppSizes.sm + 4),
              //       ],
              //     ],
              //   ),
              // ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.md,
                  left: AppSizes.md,
                  right: AppSizes.md,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Dismissible(
                      key: ValueKey(item.id),
                      direction: DismissDirection.endToStart,
                      background: const _DismissBackground(),
                      onDismissed: (_) => cart.removeItem(item.id),
                      child: CartItemCardDismissible(
                        item: item,
                        onIncrement: () => cart.incrementQuantity(item.id),
                        onDecrement: () => cart.decrementQuantity(item.id),
                        onRemove: () => cart.removeItem(item.id),
                      ),
                    );
                  },
                  separatorBuilder: (_, _) => const Gap(AppSizes.sm + 4),
                  itemCount: cart.itemCount,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CartFooter(
                enabled: cart.items.every((i) => i.isAvailable),
                onContinue: () => _continueToFulfillment(context, seller),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground();

  @override
  Widget build(BuildContext context) {
    const danger = Color(0xFFE53935);
    return Container(
      decoration: BoxDecoration(
        color: danger.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: AppSizes.lg),
      child: const Icon(Iconsax.trash, color: danger, size: 28),
    );
  }
}

class _CartBadge extends StatelessWidget {
  const _CartBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.lg * 1.8,
      height: AppSizes.lg * 1.8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Iconsax.shopping_cart,
              color: AppColors.secondary,
              size: AppSizes.lg - 2,
            ),
          ),
          if (count > 0)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
