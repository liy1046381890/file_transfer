import 'package:file_transfer/global/themeLogic.dart';
import 'package:file_transfer/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('home');
    DateTime? lastClickTime;
    return Scaffold(
      appBar: AppbarWidget(
        pageTitle: "File Transfer",
        leading: IconButton(
          alignment: Alignment.centerRight,
          onPressed: Get.find<ThemeLogic>().changeTheme,
          icon: Obx(() => Icon(Get.find<ThemeLogic>().isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
              color: Colors.amber.shade400)),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => controller.nav2settings(),
            icon: const Icon(Icons.settings, color: Colors.white70),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (lastClickTime == null || DateTime.now().difference(lastClickTime!) > const Duration(milliseconds: 1500)) {
            lastClickTime = DateTime.now();
            Get.rawSnackbar(
              messageText: const Text(
                "再次点击退出应用",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              duration: const Duration(seconds: 1),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey.withOpacity(0.8),
            );
            return false;
          }
          return true;
        },
        child: const SizedBox.shrink(),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {},
        child: const Icon(
          CupertinoIcons.play_circle_fill,
        ),
      ),
    );
  }
}
