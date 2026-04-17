// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart' show Iconsax;
// import 'package:vinted_v2/core/constants/colors.dart';
// import 'package:vinted_v2/core/constants/sizes.dart';
// import 'package:vinted_v2/core/utils/device/device_utility.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.showBackArrow = false,
//     this.leadingIcon,
//     this.actions,
//     this.leadingOnPressed,
//   });

//   final Widget? title;
//   final bool showBackArrow;
//   final IconData? leadingIcon;
//   final List<Widget>? actions;
//   final VoidCallback? leadingOnPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: DeviceUtils.getStatusBarHeight(),
//         bottom: 0,
//         left: AppSizes.md,
//         right: AppSizes.md,
//       ),
//       height: DeviceUtils.getAppBarHeight() + DeviceUtils.getStatusBarHeight(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: leadingOnPressed ?? () {},
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                 child: Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.secondary.withValues(alpha: 0.3),
//                     border: Border.all(
//                       color: AppColors.white.withValues(alpha: 0.2),
//                       width: 1,
//                     ),
//                   ),
//                   child: const Icon(Iconsax.user, color: AppColors.white),
//                 ),
//               ),
//             ),
//           ),
//           if (title != null)
//             DefaulAppTextstyle(
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                 color: AppColors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.black.withValues(alpha: 0.3),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: title,
//               ),
//             )
//           else
//             const Spacer(),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Iconsax.notification, color: AppColors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize {
//     final statusBarHeight = DeviceUtils.getStatusBarHeight();
//     final appBarContentHeight = AppSizes.appBarHeight;
//     return Size.fromHeight(statusBarHeight + appBarContentHeight);
//   }
// }
