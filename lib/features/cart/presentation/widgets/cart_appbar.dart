import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vinted_v2/core/common/widgets/custon_shapes/container/circular_container.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';
import 'package:vinted_v2/core/constants/text_strings.dart';
import 'package:vinted_v2/core/utils/device/device_utility.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key, this.onSearchTap});

  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: DeviceUtils.getStatusBarHeight(),
        left: AppSizes.md,
        right: AppSizes.md,
      ),
      child: SizedBox(
        height: AppSizes.appBarHeight,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const CustomCircularContainer(
                size: 44,
                backgroundColor: AppColors.white,
                child: Icon(
                  Iconsax.arrow_left,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
            ),
            const Gap(AppSizes.md),
            Text(
              AppTexts.cartTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onSearchTap,
              child: const CustomCircularContainer(
                size: 44,
                backgroundColor: AppColors.white,
                child: Icon(
                  Iconsax.search_normal_1,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppSizes.appBarHeight + DeviceUtils.getStatusBarHeight());
}
