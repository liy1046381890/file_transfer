import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_transfer/global/app_binding.dart';
import 'package:file_transfer/global/constants.dart';
import 'package:file_transfer/global/routes.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
    return ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'file_transfer',
            theme: Get.isPlatformDarkMode ? customDarkTheme : customLightTheme,
            darkTheme: customDarkTheme,
            themeMode: ThemeMode.light,
            initialRoute: AppRoutes.home,
            unknownRoute: AppRoutes.unknownPage,
            getPages: AppRoutes.getPages,
            defaultTransition: Transition.cupertino,
          );
        });
  }
}
