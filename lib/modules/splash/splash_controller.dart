import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(const Duration(seconds: 2));
    await LocalStorageHelper.initLocalStorageHelper();

    final checkIntroScreen =
        LocalStorageHelper.getValue(stringConst.checkIntro) as bool?;
    final user = FirebaseAuth.instance.authStateChanges();

    try {
      if (checkIntroScreen != null && checkIntroScreen) {
        if (user != null) {
          Get.offNamed(Routes.HOME);
        } else {
          Get.offNamed(Routes.AUTH);
        }
      } else {
        LocalStorageHelper.setValue(stringConst.checkIntro, true);
        Get.offNamed(Routes.INTRO);
      }
    } catch (e) {
      Get.offNamed(Routes.INTRO);
    }
  }
}
