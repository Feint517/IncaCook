import 'package:get/get.dart';
import 'package:vinted_v2/core/utils/helpers/network_manager.dart';
import 'package:vinted_v2/core/utils/services/location_service.dart';
import 'package:vinted_v2/core/utils/services/permission_service.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    // Get.put(PermissionService());
    // Get.put(LocationService());
  }
}
