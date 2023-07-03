import 'package:file_transfer/global/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeLogic extends GetxController {
  late final SharedPreferences sp;

  nav2settings() {
    Get.toNamed(AppRoutes.settings);
  }

  @override
  onInit() {
    super.onInit();
    sp = Get.find<SharedPreferences>();
    Get.log("home init");
    Get.log(Get.currentRoute);
  }

  @override
  onReady() {
    super.onReady();
    Get.log("home onReady");
  }

  @override
  onClose() {
    Get.log("home close");
    super.onClose();
  }
}
