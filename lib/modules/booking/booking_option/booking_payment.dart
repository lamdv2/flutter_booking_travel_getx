// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/booking/booking_option/booking_option_controller.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/constants/app_style.dart';
import '../../../../shared/utils/app_bar_widget.dart';
import '../../auth/user_controller.dart';
import '../booking_controller.dart';

class BookingPaymentScreen extends GetView<BookingOptionController> {
  BookingPaymentScreen({super.key});

  final AppController appController = Get.find();
  final UserController userController = Get.put(UserController());
  final BookingController bookingController = Get.put(BookingController());
  final HomeController homeController = Get.find();
  final BookingRequestController bookingRequestController =
      Get.put(BookingRequestController());

  final TourModel? tourModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Payment Booking".tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.lightBackground,
      ),
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.darkCard
                        : ColorConstants.lightCard,
                    child: Padding(
                      padding: EdgeInsets.all(getSize(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConst.paymentBanking.tr,
                            style: appController.isDarkModeOn.value
                                ? AppStyles.white000Size18Fw600FfMont
                                : AppStyles.black000Size18Fw600FfMont,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                          SizedBox(
                            height: getSize(8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "5621 000 246 6118",
                                style: appController.isDarkModeOn.value
                                    ? AppStyles.white000Size16Fw400FfMont
                                    : AppStyles.black000Size16Fw400FfMont,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  const String bidvAppUrl =
                                      'https://play.google.com/store/apps/details?id=com.vnpay.bidv';
                                  try {
                                    await launch(bidvAppUrl);
                                  } catch (e) {
                                    return;
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getSize(8),
                                    horizontal: getSize(10),
                                  ),
                                  decoration: BoxDecoration(
                                    gradient:
                                        Gradients.defaultGradientBackground,
                                    borderRadius:
                                        BorderRadius.circular(kTopPadding),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    StringConst.banking.tr,
                                    style: AppStyles.white000Size16Fw500FfMont,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getSize(2),
                          ),
                          Text(
                            "BIDV DO VAN LAM",
                            style: appController.isDarkModeOn.value
                                ? AppStyles.white000Size16Fw400FfMont
                                : AppStyles.black000Size16Fw400FfMont,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  Container(
                    width: double.infinity,
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.darkCard
                        : ColorConstants.lightCard,
                    child: Padding(
                      padding: EdgeInsets.all(getSize(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConst.scanQRCode.tr,
                            style: appController.isDarkModeOn.value
                                ? AppStyles.white000Size18Fw600FfMont
                                : AppStyles.black000Size18Fw600FfMont,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                          SizedBox(
                            height: getSize(24),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fbidv_dovanlam.jpg?alt=media&token=7929a623-8adc-4b41-ad00-514542802fe3",
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  Container(
                    width: double.infinity,
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.darkCard
                        : ColorConstants.lightCard,
                    child: Padding(
                      padding: EdgeInsets.all(getSize(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConst.banking.tr,
                            style: appController.isDarkModeOn.value
                                ? AppStyles.white000Size18Fw600FfMont
                                : AppStyles.black000Size18Fw600FfMont,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                          SizedBox(
                            height: getSize(24),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async => await launch(
                                      'https://play.google.com/store/apps/details?id=com.vnpay.Agribank3g',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getSize(8)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorConstants.blue
                                              .withOpacity(.5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fagribank-logo-1CEEE70C76-seeklogo.com.png?alt=media&token=1f6ed96c-ff56-40a8-9df1-d01e2c12ece7",
                                          height: getSize(64),
                                          width: getSize(64),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getSize(24),
                                  ),
                                  GestureDetector(
                                    onTap: () async => await launch(
                                      'https://play.google.com/store/apps/details?id=com.vietinbank.ipay',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getSize(8)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorConstants.blue
                                              .withOpacity(.5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fviettinbank.jpg?alt=media&token=bfccb256-289a-48f6-b3f8-18fa42e6dfcb",
                                          height: getSize(64),
                                          width: getSize(64),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getSize(24),
                                  ),
                                  GestureDetector(
                                    onTap: () async => await launch(
                                      'https://play.google.com/store/apps/details?id=com.VCB',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getSize(8)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorConstants.blue
                                              .withOpacity(.5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fvietcombank-logo.jpg?alt=media&token=faf7c9bf-5063-4fd9-811e-5cb5b104daa6",
                                          height: getSize(64),
                                          width: getSize(64),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getSize(24),
                                  ),
                                  GestureDetector(
                                    onTap: () async => await launch(
                                      'https://play.google.com/store/apps/details?id=com.vnpay.bidv',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getSize(8)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorConstants.blue
                                              .withOpacity(.5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Flogo-bidv-20220426071253.jpg?alt=media&token=60da452f-c8bf-44c6-899f-20ec1cf72ae3",
                                          height: getSize(64),
                                          width: getSize(64),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getSize(24),
                                  ),
                                  GestureDetector(
                                    onTap: () async => await launch(
                                      'https://play.google.com/store/apps/details?id=com.mbmobile',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getSize(8)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorConstants.blue
                                              .withOpacity(.5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2F62ce8018d5cacb6b28727421_MB%20bank%20logo.jpg?alt=media&token=0c5c23ef-0bec-4189-8a3c-4af895ea59d0",
                                          height: getSize(64),
                                          width: getSize(64),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getSize(24),
                                  ),
                                  GestureDetector(
                                    onTap: () async => await launch(
                                      'https://play.google.com/store/apps/details?id=vn.com.techcombank.bb.app',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getSize(8)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorConstants.blue
                                              .withOpacity(.5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Flogo-techcombank-inkythuatso-10-15-11-46.jpg?alt=media&token=8d37493c-4b19-4c40-8d53-c4e9be7714a7",
                                          height: getSize(64),
                                          width: getSize(64),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getSize(24),
                                  ),
                                  GestureDetector(
                                    onTap: () async => await launch(
                                      'https://play.google.com/store/apps/details?id=com.vnpay.vpbankonline',
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(getSize(8)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorConstants.blue
                                              .withOpacity(.5),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fvpbank.png?alt=media&token=a671084b-5409-4993-9c87-3798745396d9",
                                          height: getSize(64),
                                          width: getSize(64),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getSize(24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(96),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: getSize(84),
                padding: EdgeInsets.all(getSize(16)),
                color: appController.isDarkModeOn.value
                    ? ColorConstants.darkCard
                    : ColorConstants.lightCard,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${bookingRequestController.totalPrice.toInt()} ',
                              style: AppStyles.blue000Size16Fw500FfMont,
                            ),
                            TextSpan(
                              text: 'VND ',
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.white000Size14Fw400FfMont
                                  : AppStyles.black000Size14Fw400FfMont,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ButtonWidget(
                      textBtn: StringConst.finish.tr,
                      onTap: () async {
                        await bookingController.bookingTour(
                          homeController.userModel.value?.id ?? '',
                          tourModel?.idTour ?? '',
                          bookingController
                              .formatDateTime(DateTime.now().toString()),
                          'waiting',
                          bookingRequestController.adultNumb.value ?? 0,
                          bookingRequestController.childrenNumb.value ?? 0,
                          bookingRequestController.totalPrice.value ?? 0,
                        );
                        Get.offAndToNamed(Routes.HISTORY_TOUR_SCREEN);
                      },
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
