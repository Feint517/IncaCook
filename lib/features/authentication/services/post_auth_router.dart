import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:incacook/core/common/widgets/navigation/navigation_menu.dart';
import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/core/models/auth/onboarding_state.dart';
import 'package:incacook/core/models/auth/user.dart';
import 'package:incacook/core/network/api_response.dart';
import 'package:incacook/features/authentication/controllers/signup_flow_binding.dart';
import 'package:incacook/features/authentication/data/models/driver_vehicle_type.dart';
import 'package:incacook/features/authentication/data/models/signup_step.dart';
import 'package:incacook/features/authentication/data/models/user_role.dart';
import 'package:incacook/features/authentication/data/repositories/users_repository.dart';
import 'package:incacook/features/client/presentation/client_nav_tabs.dart';
import 'package:incacook/features/delivery/presentation/screens/delivery_home.dart';
import 'package:incacook/features/seller/presentation/seller_nav_tabs.dart';

/// Outcome of "where should this authenticated user land?". The signin
/// + cold-start bootstrap flows both compute this against the same two
/// endpoints — see `docs/signup-flow.md` §4 — and then hand off to
/// [PostAuthRouter.navigateTo] for the actual navigation.
sealed class PostAuthRoute {
  const PostAuthRoute();
}

/// Wizard is fully done (`onboarding.next == null`). Land in the role's
/// home screen.
class PostAuthRoleHome extends PostAuthRoute {
  const PostAuthRoleHome(this.role);
  final UserRole role;
}

/// User finished Gate 2 (User row exists) but the wizard has more steps.
/// Seeds the signup controller and jumps to [startAt].
class PostAuthResumeSignup extends PostAuthRoute {
  const PostAuthResumeSignup({
    required this.role,
    required this.startAt,
    this.sellerCategory,
    this.vehicleType,
  });
  final UserRole role;
  final SignupStep? startAt;
  final SellerCategory? sellerCategory;
  final DriverVehicleType? vehicleType;
}

/// User has a session but never completed Gate 2 (no User row). The
/// wizard restarts from after basicInfo so they pick role + accept legal
/// without re-signing-up. Today the user still has to retype the
/// universal preamble fields; a future mini-flow can fix that.
class PostAuthNoProfile extends PostAuthRoute {
  const PostAuthNoProfile();
}

/// Decides where an authenticated user should land, and (separately)
/// performs the navigation. Split so callers can surface errors on the
/// current screen instead of always navigating away.
///
/// Registered globally in `main.dart` so both the bootstrap splash
/// (cold start) and the signin controller (live login) hit the same
/// rules.
class PostAuthRouter extends GetxService {
  PostAuthRouter({UsersRepository? usersRepository})
      : _usersRepository = usersRepository ?? Get.find<UsersRepository>();

  static PostAuthRouter get instance => Get.find();

  final UsersRepository _usersRepository;

  /// Throws [ApiFailure] for anything but 404. A 404 is the "no profile
  /// yet" signal — `/users/me/onboarding` and `/users/me` both depend
  /// on the User row.
  Future<PostAuthRoute> decide() async {
    try {
      // Parallel: onboarding gives us `next`, /users/me gives us the
      // role-specific sub-type fields (`category`, `vehicleType`) we
      // need so [SignupFlowController.steps] computes the right list
      // when resuming. `eagerError: true` so a 404 from either short-
      // circuits the wait instead of waiting on the other.
      final results = await Future.wait<Object>([
        _usersRepository.fetchOnboarding(),
        _usersRepository.getMe(),
      ], eagerError: true);
      final onboarding = results[0] as OnboardingState;
      final me = results[1] as User;
      if (onboarding.next == null) {
        return PostAuthRoleHome(onboarding.role);
      }
      return PostAuthResumeSignup(
        role: onboarding.role,
        startAt: signupStepFromOnboardingKey(
          onboarding.next!,
          onboarding.role,
        ),
        sellerCategory: me.sellerAccount?.category,
        vehicleType: me.driverAccount?.vehicleType,
      );
    } on ApiFailure catch (e) {
      if (e.statusCode == 404) return const PostAuthNoProfile();
      rethrow;
    }
  }

  void navigateTo(PostAuthRoute route) {
    switch (route) {
      case PostAuthRoleHome(:final role):
        Get.offAll<void>(() => _homeForRole(role));
      case PostAuthResumeSignup(
          :final role,
          :final startAt,
          :final sellerCategory,
          :final vehicleType,
        ):
        // Route through the named /signup so its GetPage binding fires
        // *for the new route* — the controller's lifecycle is tied to
        // SignupShellScreen, not to whatever route called us.
        Get.offAllNamed<void>(
          '/signup',
          arguments: ResumeSignupArgs(
            role: role,
            startAt: startAt,
            sellerCategory: sellerCategory,
            vehicleType: vehicleType,
          ),
        );
      case PostAuthNoProfile():
        // Auth account exists, IncaCook profile doesn't. Drop basicInfo
        // (signup endpoint already happened) but keep OTP/biometric/
        // legal/role — those are needed for Gate 2.
        Get.offAllNamed<void>(
          '/signup',
          arguments: const NoProfileSignupArgs(),
        );
    }
  }

  Widget _homeForRole(UserRole role) {
    switch (role) {
      case UserRole.buyer:
        return const NavigationMenu(tabs: kClientNavTabs);
      case UserRole.seller:
        return const NavigationMenu(tabs: kSellerNavTabs);
      case UserRole.driver:
        return DeliveryHomeScreen();
    }
  }
}
