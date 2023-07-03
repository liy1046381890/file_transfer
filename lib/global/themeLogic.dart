import 'package:file_transfer/global/constants.dart';
import 'package:get/get.dart';

class ThemeLogic extends GetxController {
  final isDarkMode = Get.isPlatformDarkMode.obs;

  changeTheme() {
    Get.changeTheme(isDarkMode.value ? customLightTheme : customDarkTheme);
    isDarkMode.value = !isDarkMode.value;
  }
}
