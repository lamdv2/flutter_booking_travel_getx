import 'dart:async';

import 'package:doan_clean_achitec/modules/ads/ads_open_app.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  RxBool isDarkModeOn = false.obs;
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool adShown = false;

  @override
  void onInit() {
    appOpenAdManager.loadAd();
    Timer(Duration(seconds: 2), () {
      if (!adShown) {
        appOpenAdManager.showAdIfAvailable();
        adShown = true;
      }
    });
    super.onInit();
  }

  Future<void> loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeOn.value = prefs.getBool('dark_mode_key') ?? false;
    update();
  }

  Future<void> toggleDarkMode() async {
    isDarkModeOn.toggle();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode_key', isDarkModeOn.value);
    update();
  }

  void changeMode() {
    toggleDarkMode();
  }
}
