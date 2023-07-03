import 'package:flutter/material.dart';
import 'package:file_transfer/widgets/appbar_widget.dart';
import 'package:get/get.dart';
import 'settings_logic.dart';

class SettingsPage extends GetView<SettingsLogic> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('SettingsPage');
    return Scaffold(
      appBar: AppbarWidget(
        pageTitle: "Settings",
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
        ),
      ),
      body: const SizedBox.shrink(),
    );
  }
}
