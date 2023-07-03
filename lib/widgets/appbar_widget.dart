import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_transfer/global/constants.dart';
import 'package:file_transfer/global/themeLogic.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final Widget? leading;
  final bool? centerTitle;
  final List<Widget>? actions;

  const AppbarWidget({super.key, required this.pageTitle, this.leading, this.centerTitle = false, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Obx(() => Get.find<ThemeLogic>().isDarkMode.value
          ? Container(decoration: barDarkGradient)
          : Container(decoration: barLightGradient)),
      automaticallyImplyLeading: false,
      leading: leading,
      title: ShaderMask(
        shaderCallback: (Rect bounds) {
          return (Get.find<ThemeLogic>().isDarkMode.value ? pbLinearGradient : wwwLinearGradient).createShader(bounds);
        },
        child: Text(pageTitle),
      ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
