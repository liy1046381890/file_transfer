import 'package:file_transfer/pages/home/home_binding.dart';
import 'package:file_transfer/pages/home/home_view.dart';
import 'package:file_transfer/pages/settings/settings_binding.dart';
import 'package:file_transfer/pages/settings/settings_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const home = '/home';
  static const settings = '/settings';
  static const unknown = '/404';
  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
  ];
  static final GetPage unknownPage = GetPage(
    name: unknown,
    page: () => const HomePage(),
    binding: HomeBinding(),
  );
}
