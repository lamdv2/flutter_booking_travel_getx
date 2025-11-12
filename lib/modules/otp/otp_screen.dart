import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/otp/otp_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../dark_mode.dart';
import '../../models/tour/tour_model.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final OtpController _otpController = Get.find();
  // ignore: prefer_typing_uninitialized_variables
  var otp;
  final UserModel userModel = Get.arguments['arg1'];
  final TourModel tourModel = Get.arguments['arg2'];
  final String statusPayment = Get.arguments['arg3'];
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final defaultThemePinput = PinTheme(
      width: getSize(56),
      height: getSize(64),
      textStyle: TextStyle(
        fontSize: 22,
        color: ColorConstants.black,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      appBar: CustomAppBar(
        titles: "Verification",
        iconBgrColor: ColorConstants.lightCard,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Column(
              children: [
                SizedBox(
                  height: getSize(24),
                ),
                Text(
                  "Enter the code to your number",
                  style: appController.isDarkModeOn.value
                      ? AppStyles.white000Size14Fw400FfMont
                      : AppStyles.botTitle000Size14Fw400FfMont,
                ),
                SizedBox(
                  height: getSize(24),
                ),
                Text(
                  userModel.phoneNub,
                  style: appController.isDarkModeOn.value
                      ? AppStyles.white000Size18Fw600FfMont
                      : AppStyles.black000Size18Fw600FfMont,
                ),
                SizedBox(
                  height: getSize(60),
                ),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultThemePinput,
                  focusedPinTheme: defaultThemePinput.copyWith(
                    decoration: defaultThemePinput.decoration!.copyWith(
                      border: Border.all(color: Colors.green),
                    ),
                  ),
                  onCompleted: (value) {
                    otp = value;
                    _otpController.verifyOTP(
                      value,
                      userModel,
                      tourModel,
                      statusPayment,
                    );
                  },
                ),
                SizedBox(
                  height: getSize(64),
                ),
                SizedBox(
                  child: ElevatedButton(
                    child: Text(
                      "NEXT",
                      style: appController.isDarkModeOn.value
                          ? AppStyles.white000Size14Fw600FfMont
                          : AppStyles.black000Size14Fw600FfMont,
                    ),
                    onPressed: () => _otpController.verifyOTP(
                      otp,
                      userModel,
                      tourModel,
                      statusPayment,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
