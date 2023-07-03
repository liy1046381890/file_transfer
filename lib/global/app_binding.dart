import 'package:file_transfer/global/themeLogic.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBinding extends Bindings {
  @override
  Future dependencies() async {
    await Get.putAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    }, permanent: true);
    Get.put<ThemeLogic>(ThemeLogic());
  }
}
