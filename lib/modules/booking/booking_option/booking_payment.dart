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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: ColorConstants.lightCard,
                    child: Padding(
                      padding: EdgeInsets.all(getSize(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConst.paymentBanking.tr,
                            style: AppStyles.black000Size18Fw600FfMont,
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
                                style: AppStyles.black000Size16Fw400FfMont,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  const String bidvAppUrl =
                                      'https://play.google.com/store/apps/details?id=com.vnpay.bidv';
                                  try {
                                    // ignore: deprecated_member_use
                                    await launch(bidvAppUrl);
                                    // ignore: empty_catches
                                  } catch (e) {}
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
                            style: AppStyles.black000Size16Fw400FfMont,
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
                    color: ColorConstants.lightCard,
                    child: Padding(
                      padding: EdgeInsets.all(getSize(20)),
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConst.scanQRCode.tr,
                            style: AppStyles.black000Size18Fw600FfMont,
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
                color: ColorConstants.lightCard,
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
                              style: AppStyles.black000Size14Fw400FfMont,
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
