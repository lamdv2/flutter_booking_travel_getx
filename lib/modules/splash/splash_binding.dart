import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/history_tour/history_tour.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/modules/splash/splash_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<UserController>(UserController());
    Get.lazyPut(() => TourController());
    Get.lazyPut(() => HistoryTourController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchDesController());
  }
}
