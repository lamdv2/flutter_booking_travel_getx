import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool isDarkModeOn = false.obs;

  void toggleDarkMode() {
    isDarkModeOn.toggle();
  }
}
