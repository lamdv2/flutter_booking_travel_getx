// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/modules/rate/components/app_header.dart';
import 'package:doan_clean_achitec/modules/rate/components/main_button.dart';
import 'package:doan_clean_achitec/modules/rate/components/multiline_input.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/constants/dimension_constants.dart';

class RateScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  RateScreen({Key? key});

  var rating = 0.0;
  final AppController appController = Get.find();
  final HomeController homeController = Get.find();
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Feedback".tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
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
                    homeController.userModel.value != null &&
                            homeController.userModel.value?.imgAvatar != null &&
                            homeController.userModel.value?.imgAvatar != ""
                        ? GestureDetector(
                            onTap: () async {
                              profileController.showFullImageDialog(
                                  context,
                                  homeController.userModel.value?.imgAvatar ??
                                      "");
                            },
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: CachedNetworkImageProvider(
                                homeController.userModel.value?.imgAvatar ?? "",
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: ColorConstants.white,
                            child: Container(
                              width: getSize(96),
                              height: getSize(96),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    appController.isDarkModeOn.value
                                        ? ColorConstants.white
                                        : ColorConstants.accent1,
                                    BlendMode.srcIn,
                                  ),
                                  image: const AssetImage(
                                    AssetHelper.imgUserProfileNon,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Welcome to TourBooking!',
                      style: TextStyle(
                          color: ColorConstants.kTextLightColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: getSize(120),
                    ),
                    Text(
                      'How would you rate your recent tour?',
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.gray400
                            : ColorConstants.kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: kTop28Padding),
                    MultilineInput(),
                    const SizedBox(height: kDefaultPadding),
                    GestureDetector(
                      onTap: () {
                        String feedback =
                            profileController.feedbackController.text;
                        launchEmailApp(
                          feedback,
                          "${homeController.userModel.value?.firstName ?? ""} ${homeController.userModel.value?.lastName ?? ""}",
                        );
                      },
                      child: const MainButton(),
                    ),
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

void launchEmailApp(String feedback, String nameUser) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'dreamtravelappmobile@gmail.com',
    queryParameters: {
      'subject': 'Feedback of user $nameUser',
      'body': feedback,
    },
  );

  if (await canLaunch(emailLaunchUri.toString())) {
    await launch(emailLaunchUri.toString());
  } else {
    print('Could not launch email app');
  }
}
