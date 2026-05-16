import 'package:get/get.dart';

import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/features/authentication/controllers/signup_flow_controller.dart';
import 'package:incacook/features/authentication/data/models/driver_vehicle_type.dart';
import 'package:incacook/features/authentication/data/models/signup_step.dart';
import 'package:incacook/features/authentication/data/models/user_role.dart';
import 'package:incacook/features/authentication/data/repositories/signup_repository.dart';

/// Local binding for the signup wizard.
///
/// [AuthRepository], [UsersRepository], [ApiClient], and [TokenStorage]
/// are registered globally in `main.dart` so the controller can reach
/// them via `Get.find()`.
///
/// **Seeding via `Get.arguments`.** When navigating from the post-auth
/// router (`PostAuthRouter`), we pass a [SignupFlowArgs] in the route
/// arguments and apply it inside the lazyPut factory below. This keeps
/// the controller's lifecycle tied to the new `/signup` route — earlier
/// versions hand-seeded a `Get.find` instance from the *previous* route
/// (LoginScreen / Splash), which GetX then promptly disposed when the
/// previous route was torn down by `offAllNamed`.
class SignupFlowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupRepository>(SignupRepository.new, fenix: true);
    Get.lazyPut<SignupFlowController>(() {
      final controller = SignupFlowController();
      final args = Get.arguments;
      if (args is SignupFlowArgs) {
        args.applyTo(controller);
      }
      return controller;
    });
  }
}

/// Wizard-entry seed shapes. Routed as `Get.arguments` from
/// [PostAuthRouter.navigateTo].
sealed class SignupFlowArgs {
  const SignupFlowArgs();
  void applyTo(SignupFlowController controller);
}

/// User has a session and a User row but the wizard has more steps to
/// finish. Drops the universal preamble; jumps to [startAt].
class ResumeSignupArgs extends SignupFlowArgs {
  const ResumeSignupArgs({
    required this.role,
    this.startAt,
    this.sellerCategory,
    this.vehicleType,
  });

  final UserRole role;
  final SignupStep? startAt;
  final SellerCategory? sellerCategory;
  final DriverVehicleType? vehicleType;

  @override
  void applyTo(SignupFlowController controller) {
    controller.seedForResume(
      role: role,
      startAt: startAt,
      sellerCategory: sellerCategory,
      vehicleType: vehicleType,
    );
  }
}

/// User has a session but no User row yet — wizard restarts after
/// basicInfo so they pick role + accept legal without re-running
/// `/v1/auth/signup`.
class NoProfileSignupArgs extends SignupFlowArgs {
  const NoProfileSignupArgs();

  @override
  void applyTo(SignupFlowController controller) {
    controller.seedAsSignedIn();
  }
}
