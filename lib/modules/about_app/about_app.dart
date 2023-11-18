import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AboutAppScreen extends StatelessWidget {
  final AppController appController = Get.find();

  AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "About app".tr,
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
                style: AppStyles.black000Size24Fw500FfMont,
              ),
              Text(
                ' 1.0.0',
                style: AppStyles.gray600Size14Fw500FfMont,
              ),
              const SizedBox(height: 32),
              Text(
                'Embark on a Journey with Our App',
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
                  "Unlock a World of Possibilities",
                  style: AppStyles.black000Size18Fw600FfMont,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Effortless Trip Planning",
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Discover, plan, and book seamlessly. Your all-in-one travel companion.",
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Exclusive Deals and Offers",
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Access special discounts with our top-rated partners.",
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Discover Local Gems",
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Immerse in local culture with curated recommendations.",
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Capture Every Moment",
                      style: AppStyles.gray600Size16Fw500FfMont,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Share and connect with a community of fellow travelers.",
                      style: AppStyles.gray600Size14Fw400FfMont,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Experience the World Like Never Before",
                style: AppStyles.black000Size18Fw600FfMont,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
