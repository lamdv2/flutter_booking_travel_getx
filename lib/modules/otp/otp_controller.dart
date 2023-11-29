import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile/profile_controller.dart';

class OtpController extends GetxController {
  final AuthController _authController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());

  Future<void> verifyOTP(
      String otp, UserModel userModel, TourModel tourModel) async {
    bool isVerified = await _authController.verifyOTP(otp);
    if (isVerified) {
      Get.offAndToNamed(
        Routes.BOOKING_PAYMENT_SCREEN,
        arguments: tourModel,
      );
      Get.snackbar(
        'Successfully',
        'OTP Verification Successfully',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      profileController.updateUserProfile(userModel);
    } else {
      Get.snackbar(
        'OTP Verification Failed',
        'Please enter a valid OTP.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
