// ignore_for_file: must_be_immutable

import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/rate/components/app_header.dart';
import 'package:doan_clean_achitec/modules/rate/components/main_button.dart';
import 'package:doan_clean_achitec/modules/rate/components/multiline_input.dart';
import 'package:doan_clean_achitec/modules/rate/components/proportionate.dart';
import 'package:doan_clean_achitec/modules/rate/components/ride_stat.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/dimension_constants.dart';

class RateScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  RateScreen({Key? key});

  var rating = 0.0;
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        titles: "Feedback".tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AppHeader(),
            Positioned(
                top: -380,
                left: -187,
                child: Opacity(
                    opacity: 0.9, child: Image.asset('assets/icons/bg.png'))),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding * 2),
                child: Column(
                  children: [
                    const SizedBox(height: kDefaultPadding * 2),
                    Image.asset(
                      'assets/icons/driver.jpg',
                      width: getScreenPropotionWidth(166, size),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Welcome to TourBooking!',
                      style: TextStyle(
                          color: ColorConstants.kTextLightColor, fontSize: 14),
                    ),
                    const Text(
                      'Your Feedback is Valuable',
                      style: TextStyle(
                          color: ColorConstants.kTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Divider(
                      color: ColorConstants.kTextLightColor,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const TourStats(),
                    const SizedBox(height: kDefaultPadding),
                    const Divider(
                      color: ColorConstants.kTextLightColor,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Rate Your Tour Experience',
                      style: TextStyle(
                        color: ColorConstants.kTextLightColor,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'How would you rate your recent tour?',
                      style: TextStyle(
                        color: ColorConstants.kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    // SmoothStarRating(
                    //   rating: rating,
                    //   size: 40,
                    //   filledIconData: Icons.star,
                    //   halfFilledIconData: Icons.star_half,
                    //   defaultIconData: Icons.star_border,
                    //   starCount: 5,
                    //   allowHalfRating: false,
                    //   spacing: 2.0,
                    //   onRatingChanged: (value) {
                    //     setState(() {
                    //       rating = value;
                    //     });
                    //   },
                    // ),
                    const SizedBox(height: kDefaultPadding),
                    const MultilineInput(),
                    const SizedBox(height: kDefaultPadding),
                    const MainButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
