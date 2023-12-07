import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/otp/otp_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 20),
                child: HeaderWidget(
                  titleHeader: "Verification",
                  onTap: (snack) => Get.back(),
                ),
              ),
              SizedBox(
                height: getSize(46),
              ),
              Text(
                "Enter the code to your number",
                style: AppStyles.botTitle000Size14Fw400FfMont,
              ),
              SizedBox(
                height: getSize(24),
              ),
              Text(
                userModel.phoneNub,
                style: AppStyles.black000Size18Fw600FfMont,
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
                height: getSize(40),
              ),
              SizedBox(
                child: ElevatedButton(
                  child: const Text("NEXT"),
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
    );
  }
}
