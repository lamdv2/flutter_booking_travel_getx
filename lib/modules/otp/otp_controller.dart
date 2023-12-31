import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/modules/booking/booking.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/string_constants.dart';
import '../profile/profile_controller.dart';

class OtpController extends GetxController {
  final AuthController _authController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());
  final BookingController bookingController = Get.put(BookingController());

  Future<void> verifyOTP(
    String otp,
    UserModel userModel,
    TourModel tourModel,
    String statusPayment,
  ) async {
    bool isVerified = await _authController.verifyOTP(otp);
    if (isVerified) {
      if (statusPayment == "qrcode" || statusPayment == "banking") {
        Get.offAndToNamed(
          Routes.BOOKING_PAYMENT_SCREEN,
          arguments: tourModel,
        );
      } else if (statusPayment == "visacard") {
        Get.offAndToNamed(
          Routes.PAY_STRIPE_SCREEN,
          arguments: tourModel,
        );
      }
      Get.snackbar(
        StringConst.success.tr,
        StringConst.otpVerificationSuccessfully.tr,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      profileController.updateUserProfile(userModel);
    } else {
      Get.snackbar(
        StringConst.otpVerificationFailed.tr,
        StringConst.pleaseEnterAValidOTP.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
