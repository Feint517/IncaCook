import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinted_v2/features/home/presentation/screens/home.dart';
import 'package:vinted_v2/features/profile/presentation/screens/profile.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const Center(child: Text("Create Screen")),
    const Center(child: Text("Cart Screen")),
  ];
}
