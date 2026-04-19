import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vinted_v2/core/common/widgets/navigation/navigation_controller.dart';
import 'package:vinted_v2/core/constants/colors.dart';
import 'package:vinted_v2/core/constants/sizes.dart';

class NavigationMenu extends GetView<NavigationController> {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavigationController());

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          margin: const EdgeInsets.all(AppSizes.lg),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(controller, 0, Iconsax.home, "Home"),
              _buildNavItem(controller, 2, Iconsax.add, "Create"),
              _buildNavItem(controller, 3, Iconsax.message, "Messages"),
              _buildNavItem(controller, 1, Iconsax.user, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    NavigationController controller,
    int index,
    IconData icon,
    String label,
  ) {
    final isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.selectedIndex.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : AppColors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.secondary : Colors.white,
        ),
      ),
    );
  }
}
