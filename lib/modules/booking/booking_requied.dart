// ignore_for_file: must_be_immutable

import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingRequiedScreen extends GetView<BookingRequestController> {
  BookingRequiedScreen({super.key});

  final TourModel? tourModel = Get.arguments;
  AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.setPrice(tourModel?.price ?? 0);
    return Scaffold(
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: getSize(60),
          bottom: getSize(40),
          right: getSize(36),
          left: getSize(36),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: getSize(48),
                bottom: getSize(80),
                right: getSize(24),
                left: getSize(24),
              ),
              decoration: BoxDecoration(
                color: appController.isDarkModeOn.value
                    ? ColorConstants.darkCard
                    : ColorConstants.lightCard,
                borderRadius: BorderRadius.circular(
                  getSize(8),
                ),
              ),
              child: ListView(
                children: [
                  Text(
                    tourModel?.nameTour ?? '',
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size18Fw600FfMont
                        : AppStyles.black000Size18Fw600FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  Text(
                    "${StringConst.startAt.tr} ${tourModel?.duration ?? 'Hotel'}",
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size14Fw400FfMont
                        : AppStyles.black000Size14Fw400FfMont,
                  ),
                  SizedBox(height: getSize(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${StringConst.price.tr}:',
                        style: appController.isDarkModeOn.value
                            ? AppStyles.white000Size14Fw400FfMont
                            : AppStyles.black000Size14Fw400FfMont,
                      ),
                      Text(
                        'VND ${tourModel?.price}',
                        style: appController.isDarkModeOn.value
                            ? AppStyles.white000Size16Fw500FfMont
                            : AppStyles.black000Size16Fw500FfMont,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(50),
                  ),
                  Text(
                    StringConst.serviceExcluded.tr,
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size18Fw500FfMont
                        : AppStyles.black000Size18Fw500FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  tourModel!.excludedServices!.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: tourModel!.excludedServices!
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.only(bottom: getSize(16)),
                                  child: Text(
                                    e,
                                    style: appController.isDarkModeOn.value
                                        ? AppStyles.white000Size14Fw400FfMont
                                        : AppStyles.black000Size14Fw400FfMont,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Text(
                          StringConst.noData.tr,
                          style: appController.isDarkModeOn.value
                              ? AppStyles.white000Size14Fw400FfMont
                              : AppStyles.black000Size14Fw400FfMont,
                        ),
                  SizedBox(height: getSize(32)),
                  Text(
                    StringConst.paymentMethod.tr,
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size18Fw500FfMont
                        : AppStyles.black000Size18Fw500FfMont,
                  ),
                  SizedBox(height: getSize(24)),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => controller.setStatusQRcode(),
                            child: Container(
                              padding: EdgeInsets.all(
                                getSize(10),
                              ),
                              decoration: BoxDecoration(
                                color: controller.isCheckQR.value
                                    ? ColorConstants.primaryButton
                                    : ColorConstants.grayTextField,
                                borderRadius: BorderRadius.circular(
                                  getSize(16),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AssetHelper.icScan,
                                    height: getSize(36),
                                    width: getSize(36),
                                    color: controller.isCheckQR.value
                                        ? ColorConstants.lightCard
                                        : ColorConstants.darkAppBar,
                                  ),
                                  SizedBox(height: getSize(28)),
                                  Text(
                                    StringConst.qrCode.tr,
                                    style: controller.isCheckQR.value
                                        ? AppStyles.white000Size12Fw400FfMont
                                        : AppStyles.black000Size12Fw400FfMont,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getSize(20),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => controller.setStatusBanking(),
                            child: Container(
                              padding: EdgeInsets.all(
                                getSize(10),
                              ),
                              decoration: BoxDecoration(
                                color: controller.isCheckBanking.value
                                    ? ColorConstants.primaryButton
                                    : ColorConstants.grayTextField,
                                borderRadius: BorderRadius.circular(
                                  getSize(16),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AssetHelper.icDocument,
                                    height: getSize(36),
                                    width: getSize(36),
                                    color: controller.isCheckBanking.value
                                        ? ColorConstants.lightCard
                                        : ColorConstants.darkAppBar,
                                  ),
                                  SizedBox(height: getSize(28)),
                                  Text(
                                    StringConst.banking.tr,
                                    style: controller.isCheckBanking.value
                                        ? AppStyles.white000Size12Fw400FfMont
                                        : AppStyles.black000Size12Fw400FfMont,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getSize(20),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => controller.setStatusVisaCard(),
                            child: Container(
                              padding: EdgeInsets.all(
                                getSize(10),
                              ),
                              decoration: BoxDecoration(
                                color: controller.isVisaCard.value
                                    ? ColorConstants.primaryButton
                                    : ColorConstants.grayTextField,
                                borderRadius: BorderRadius.circular(
                                  getSize(16),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AssetHelper.icWallet,
                                    height: getSize(36),
                                    width: getSize(36),
                                    color: controller.isVisaCard.value
                                        ? ColorConstants.lightCard
                                        : ColorConstants.darkAppBar,
                                  ),
                                  SizedBox(height: getSize(28)),
                                  Text(
                                    StringConst.cash.tr,
                                    style: controller.isVisaCard.value
                                        ? AppStyles.white000Size12Fw400FfMont
                                        : AppStyles.black000Size12Fw400FfMont,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getSize(48)),
                  Text(
                    StringConst.choosePeople.tr,
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size18Fw500FfMont
                        : AppStyles.black000Size18Fw500FfMont,
                  ),
                  SizedBox(height: getSize(24)),
                  Padding(
                    padding: EdgeInsets.only(bottom: getSize(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringConst.adult.tr,
                                  style: appController.isDarkModeOn.value
                                      ? AppStyles.white000Size14Fw500FfMont
                                      : AppStyles.black000Size14Fw500FfMont,
                                ),
                                SizedBox(height: getSize(4)),
                                Text(
                                  StringConst.from141cmtall.tr,
                                  style: appController.isDarkModeOn.value
                                      ? AppStyles.white000Size12Fw400FfMont
                                      : AppStyles.black000Size12Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                SizedBox(height: getSize(4)),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'VND ',
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles
                                                .white000Size12Fw400FfMont
                                            : AppStyles
                                                .black000Size12Fw400FfMont,
                                      ),
                                      TextSpan(
                                        text:
                                            '${controller.adultPrice.toInt()}',
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles
                                                .white000Size14Fw500FfMont
                                            : AppStyles
                                                .blue000Size14Fw500FfMont,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.adultNumb.value =
                                          controller.setMinus(
                                        controller.adultNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icMinus,
                                      color: ColorConstants.green,
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  SizedBox(
                                    width: getSize(32),
                                    child: Text(
                                      "${controller.adultNumb.toInt()}",
                                      textAlign: TextAlign.center,
                                      style: appController.isDarkModeOn.value
                                          ? AppStyles.white000Size16Fw400FfMont
                                          : AppStyles.black000Size16Fw400FfMont,
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  GestureDetector(
                                    onTap: () {
                                      controller.adultNumb.value =
                                          controller.setPlus(
                                        controller.adultNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icPlus,
                                      color: ColorConstants.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getSize(16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringConst.children.tr,
                                  style: appController.isDarkModeOn.value
                                      ? AppStyles.white000Size14Fw500FfMont
                                      : AppStyles.black000Size14Fw500FfMont,
                                ),
                                SizedBox(height: getSize(4)),
                                Text(
                                  StringConst.to140cmtallorless.tr,
                                  style: appController.isDarkModeOn.value
                                      ? AppStyles.white000Size12Fw400FfMont
                                      : AppStyles.black000Size12Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                SizedBox(height: getSize(4)),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'VND ',
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles
                                                .white000Size12Fw400FfMont
                                            : AppStyles
                                                .black000Size12Fw400FfMont,
                                      ),
                                      TextSpan(
                                        text:
                                            '${controller.childrenPrice.toInt()}',
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles
                                                .white000Size14Fw500FfMont
                                            : AppStyles
                                                .blue000Size14Fw500FfMont,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.childrenNumb.value =
                                          controller.setMinus(
                                        controller.childrenNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icMinus,
                                      color: ColorConstants.green,
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  SizedBox(
                                    width: getSize(32),
                                    child: Text(
                                      "${controller.childrenNumb.toInt()}",
                                      textAlign: TextAlign.center,
                                      style: appController.isDarkModeOn.value
                                          ? AppStyles.white000Size16Fw400FfMont
                                          : AppStyles.black000Size16Fw400FfMont,
                                    ),
                                  ),
                                  SizedBox(width: getSize(10)),
                                  GestureDetector(
                                    onTap: () {
                                      controller.childrenNumb.value =
                                          controller.setPlus(
                                        controller.childrenNumb.value ?? 0,
                                      );
                                      controller.calcuPrice();
                                    },
                                    child: SvgPicture.asset(
                                      AssetHelper.icPlus,
                                      color: ColorConstants.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    AssetHelper.icCloseSquare,
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.gray400
                        : ColorConstants.grey800,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: getSize(16),
              left: getSize(24),
              right: getSize(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '${controller.totalPrice.toInt()} ',
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
                    textBtn: StringConst.continue_.tr,
                    onTap: () {
                      if (controller.adultNumb.value == 0 &&
                          controller.childrenNumb.value == 0) {
                        Get.snackbar(
                          StringConst.warning.tr,
                          StringConst.youneedtochoosethenumberofpeople.tr,
                        );
                      } else {
                        Get.toNamed(
                          Routes.BOOKING_OPTION_SCREEN,
                          arguments: {
                            'arg1': tourModel,
                            'arg2': controller.paymentMothod.value,
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
