import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WifiLogic extends GetxController {
  final wifi = ''.obs;
  final wifiAP = ''.obs;
  
  StreamSubscription? _streamSubscription;
  static const EventChannel _eventChannel = EventChannel('com.example.file_transfer/wifiState');

  @override
  void onInit() {
    super.onInit();
    _streamSubscription = _eventChannel.receiveBroadcastStream().listen((event) {
      final Map<dynamic, dynamic> map = event;
      for (String key in map.keys) {
        switch (key) {
          case 'wifi':
            wifi.value = map['wifi'] as String;
            break;
          case 'wifiAP':
            wifiAP.value = map['wifiAP'] as String;
            break;
        }
      }
    }, onError: (error) {
      Get.printError(info: 'event error: $error');
    }, cancelOnError: true);
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}