import 'package:get/get.dart';
import 'package:homemade/core/controllers/theme_controller.dart';
import 'package:homemade/core/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ThemeController());
    // Get.put(PermissionService());
    // Get.put(LocationService());
  }
}
