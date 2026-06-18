import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incacook/core/constants/sizes.dart';
import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/controllers/user_controller.dart';
import 'package:incacook/core/utils/device/device_utility.dart';

class SellerHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SellerHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final userController = UserController.instance;
    return Container(
      padding: EdgeInsets.only(
        top: DeviceUtils.getStatusBarHeight(),
        left: AppSizes.md,
        right: AppSizes.md,
      ),
      height: DeviceUtils.getAppBarHeight() + DeviceUtils.getStatusBarHeight(),
      child: Row(
        children: [
          Flexible(
            // Dynamic greeting from the connected user (same source as the
            // profile screen) — never a hardcoded name.
            child: Obx(
              () => Text(
                '${AppTexts.clientHomeAppbarTitle} ${userController.greetingName}',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: onSurface,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    final statusBarHeight = DeviceUtils.getStatusBarHeight();
    return Size.fromHeight(statusBarHeight + AppSizes.appBarHeight);
  }
}
