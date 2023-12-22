import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AboutAppScreen extends StatelessWidget {
  final AppController appController = Get.find();

  AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: StringConst.aboutApp.tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Lottie.asset('assets/icons/img_travel.json',
                      height: getSize(240))),
              const SizedBox(height: 10),
              Text(
                'Dream Travel',
                style: appController.isDarkModeOn.value
                    ? AppStyles.white000Size24Fw600FfMont
                    : AppStyles.black000Size24Fw500FfMont,
              ),
              Text(
                ' 1.0.0',
                style: AppStyles.gray600Size14Fw500FfMont,
              ),
              const SizedBox(height: 32),
              Text(
                StringConst.embark.tr,
                style: TextStyle(
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.gray100
                      : ColorConstants.grey800,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  StringConst.unlockAWorld.tr,
                  style: appController.isDarkModeOn.value
                      ? AppStyles.white000Size18Fw600FfMont
                      : AppStyles.black000Size18Fw600FfMont,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringConst.effortless.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      StringConst.discoverPlan.tr,
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      StringConst.exculusive.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      StringConst.access.tr,
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      StringConst.discoverLocal.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      StringConst.immerse.tr,
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      StringConst.capture.tr,
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      StringConst.shareAndConnect.tr,
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                StringConst.experienceTheWorld.tr,
                style: appController.isDarkModeOn.value
                    ? AppStyles.white000Size18Fw600FfMont
                    : AppStyles.black000Size18Fw600FfMont,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
