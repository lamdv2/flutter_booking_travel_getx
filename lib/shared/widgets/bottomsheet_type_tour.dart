import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BottomSheetTypeTour extends StatelessWidget {
  List<String> dataSheet;
  BottomSheetTypeTour({
    super.key,
    required this.dataSheet,
  });

  final SearchDesController controller = Get.find();
  final AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + getSize(20)),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(24),
                    vertical: getSize(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getSize(84),
                      ),
                      Text(
                        "Tickets for entertainment and sightseeing",
                        style: appController.isDarkModeOn.value
                            ? AppStyles.white000Size14Fw500FfMont
                            : AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServicePlay.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                                controller
                                    .isCheckChooseType(data.typeNub)
                                    .value;
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        "Events and exhibitions",
                        style: AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServiceEvent.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                                controller
                                    .isCheckChooseType(data.typeNub)
                                    .value;
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        "Outdoor activities",
                        style: AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServiceAct.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        "Local culture",
                        style: AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServiceCultural.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        "Tourism",
                        style: AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServiceTravel.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        "Culinary experience",
                        style: AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServiceFood.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        "Accommodation",
                        style: AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServiceHotel.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        "Travel services",
                        style: AppStyles.black000Size15Fw500FfMont,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children:
                              controller.typeServiceOther.value!.map((data) {
                            return GestureDetector(
                              onTap: () {
                                controller.setTypeServiceChip(data.typeNub);
                              },
                              child: Chip(
                                label: Text(
                                  data.valueType,
                                  style: controller
                                          .isCheckChooseType(data.typeNub)
                                          .value
                                      ? AppStyles.white000Size13Fw400FfMont
                                      : appController.isDarkModeOn.value
                                          ? AppStyles.white000Size13Fw400FfMont
                                          : AppStyles.black000Size13Fw400FfMont,
                                ),
                                backgroundColor: controller
                                        .isCheckChooseType(data.typeNub)
                                        .value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : const Color(0xFFedf1f7),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: getSize(100),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: getSize(16),
                left: 0,
                right: 0,
                child: Container(
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.darkCard
                      : ColorConstants.white,
                  padding: EdgeInsets.all(getSize(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.cancel,
                          size: getSize(30),
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.lightStatusBar
                              : ColorConstants.titleSearch,
                        ),
                      ),
                      Text(
                        "Type Service",
                        style: appController.isDarkModeOn.value
                            ? AppStyles.white000Size16Fw500FfMont
                            : AppStyles.black000Size16Fw600FfMont,
                      ),
                      SvgPicture.asset(
                        AssetHelper.icDelete,
                        colorFilter: ColorFilter.mode(
                          appController.isDarkModeOn.value
                              ? ColorConstants.lightStatusBar
                              : ColorConstants.titleSearch,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.fitHeight,
                        width: getSize(30),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.darkCard
                      : ColorConstants.white,
                  child: Column(
                    children: [
                      Divider(
                        thickness: 0.5,
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.btnCanCel
                            : ColorConstants.gray.withOpacity(0.8),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: getSize(12),
                          bottom: getSize(20),
                          left: getSize(20),
                          right: getSize(20),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            controller.getTourSearchType();
                            Get.back();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryButton,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: getSize(16),
                            ),
                            child: Text(
                              StringConst.confirmation.tr,
                              style: AppStyles.white000Size14Fw500FfMont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
