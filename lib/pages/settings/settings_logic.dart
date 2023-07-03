import 'package:file_transfer/global/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLogic extends GetxController {
  final serverMode = ServerMode.share.obs;
  final port = 5555.obs; // todo 端口限制
  final projection = ProjectionMode.native.obs;

  //auth
  final pwd = "123456".obs;

  /// todo rsa
  final tab = Tabview.savePath.obs;
  final savePath = "".obs;

  late final SharedPreferences sp;

  @override
  onInit() {
    super.onInit();
    sp = Get.find<SharedPreferences>();
    Get.log("SettingsLogic init");
  }

  @override
  onReady() {
    super.onReady();
    Get.log("SettingsLogic onReady");
  }

  @override
  onClose() {
    Get.log("SettingsLogic close");
    super.onClose();
  }
}
