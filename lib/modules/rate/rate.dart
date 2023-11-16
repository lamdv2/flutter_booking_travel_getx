import 'package:doan_clean_achitec/modules/rate/components/app_header.dart';
import 'package:doan_clean_achitec/modules/rate/components/main_button.dart';
import 'package:doan_clean_achitec/modules/rate/components/multiline_input.dart';
import 'package:doan_clean_achitec/modules/rate/components/proportionate.dart';
import 'package:doan_clean_achitec/modules/rate/components/ride_stat.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../../shared/constants/dimension_constants.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AppHeader(),
            Positioned(
                top: -380,
                left: -187,
                child:
                    Opacity(opacity: 0.9, child: Image.asset('assets/icons/bg.png'))),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding * 2),
                child: Column(
                  children: [
                    CustomAppBar(),
                    const SizedBox(height: kDefaultPadding * 2),
                    Image.asset(
                      'assets/icons/driver.png',
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
                    SmoothStarRating(
                      rating: rating,
                      size: 40,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      starCount: 5,
                      allowHalfRating: false,
                      spacing: 2.0,
                      onRatingChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
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
