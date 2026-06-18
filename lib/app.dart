import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incacook/bindings/general_bindings.dart';
import 'package:incacook/core/controllers/theme_controller.dart';
import 'package:incacook/core/utils/theme/theme.dart';
import 'package:incacook/features/authentication/controllers/signup_flow_binding.dart';
import 'package:incacook/features/authentication/presentation/screens/signup_flow/signup_shell_screen.dart';
import 'package:incacook/features/bootstrap/presentation/screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeController.mode.value,
        theme: CustomAppTheme.lightTheme,
        darkTheme: CustomAppTheme.darkTheme,
        initialBinding: GeneralBindings(),
        getPages: [
          GetPage<void>(
            name: '/signup',
            page: () => const SignupShellScreen(),
            binding: SignupFlowBinding(),
            transition: Transition.fadeIn,
          ),
        ],
        // Safety net: an unmatched route (e.g. an OAuth callback deep link
        // that slips through to the router) lands on the splash, which
        // re-bootstraps — instead of GetX null-crashing in route middleware.
        unknownRoute: GetPage<void>(
          name: '/_unknown',
          page: () => const SplashScreen(),
        ),
        // Splash hands off to OnBoarding / Welcome / role home / resumed
        // signup based on stored session + /users/me/onboarding.
        home: const SplashScreen(),
      ),
    );
  }
}
