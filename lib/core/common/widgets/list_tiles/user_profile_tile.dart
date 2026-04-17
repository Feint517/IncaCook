// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:pharma/common/widgets/custon_shapes/container/circular_image.dart';
// import 'package:pharma/utils/constants/colors.dart';

// class UserProfileTile extends StatelessWidget {
//   const UserProfileTile({
//     super.key,
//     required this.onPressed,
//   });

//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     // final controller = UserController.instance;
//     return ListTile(
//       leading: Obx(
//         () {
//           final networkImage = controller.user.value
//               .profilePicture; //? check if there's a profile picture in the user model
//           final image = networkImage.isNotEmpty ? networkImage : AppImages.avatar;
//           return CustomCircularImage(
//             //! keep the values 48 so that the email doesn't take an extra line
//             image: image,
//             width: 48,
//             height: 48,
//             isNetworkImage: networkImage.isNotEmpty,
//           );
//         },
//       ),
//       title: Text(
//         controller.user.value.fullName,
//         style: Theme.of(context)
//             .textTheme
//             .headlineSmall!
//             .apply(color: TColors.white),
//       ),
//       subtitle: Text(
//         controller.user.value.email,
//         style:
//             Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
//       ),
//       trailing: IconButton(
//         onPressed: onPressed,
//         icon: const Icon(Iconsax.edit),
//         color: TColors.white,
//       ),
//     );
//   }
// }
