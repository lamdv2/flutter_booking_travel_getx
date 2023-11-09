import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/models/history_tour/history_tour_controller.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

import '../../shared/shared.dart';

// ignore: must_be_immutable
class HistoryScreen extends GetView<HistoryTourController> {
  HistoryScreen({super.key});

  UserController userController = Get.put(UserController());
  HomeController homeController = Get.put(HomeController());

  AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadIndicatorRive();
      controller.getAllTourModelData(homeController.userModel.value?.id ?? "");
    });

    return Scaffold(
      appBar: CustomAppBar(
        titles: StringConst.history.tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshHistory(),
        child: Obx(
          () => controller.isShowLoading.value
              ? Center(
                  child: SizedBox(
                    height: getSize(120),
                    width: getSize(120),
                    child: RiveAnimation.asset(
                      "assets/icons/riv/ic_checkerror.riv",
                      onInit: (artboard) {
                        StateMachineController stateMachineController =
                            controller.getRiveController(artboard);
                        controller.check = stateMachineController
                            .findSMI("Check") as SMITrigger;
                        controller.error = stateMachineController
                            .findSMI("Error") as SMITrigger;
                        controller.reset = stateMachineController
                            .findSMI("Reset") as SMITrigger;
                      },
                    ),
                  ),
                )
              : controller.getAllListHistory.value != null &&
                      controller.getAllListHistory.value!.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: getSize(16),
                          horizontal: getSize(24),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.getAllListHistory.value?.length ?? 2,
                          itemBuilder: (BuildContext context, int rowIndex) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.TOUR_QR_CODE_DETAIL,
                                    arguments: controller
                                        .getAllListHistory.value?[rowIndex]);
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getSize(12)),
                                child: _buildItemHistory(
                                  tourModel: controller
                                      .getAllListHistory.value?[rowIndex],
                                  historyModel: controller
                                      .getAllListHistoryToDate.value?[rowIndex],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              AssetHelper.imgLottieNodate,
                              width: getSize(200),
                              height: getSize(200),
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getSize(48.0),
                              ),
                              child: Text(
                                'Looks like you haven\'t booked any tours yet. Booking your first tour right now!',
                                style: AppStyles.black000Size14Fw400FfMont
                                    .copyWith(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.lightAppBar
                                      : ColorConstants.darkBackground,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: getSize(64),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.TOUR);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    AssetHelper.imgLottieArrowRight,
                                    width: getSize(32),
                                    height: getSize(32),
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    width: getSize(16),
                                  ),
                                  InkWell(
                                    child: Text(
                                      'See Tour',
                                      style: AppStyles.blueSize16Fw400FfMont,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class _buildItemHistory extends StatelessWidget {
  TourModel? tourModel;
  HistoryModel? historyModel;
  _buildItemHistory({
    required this.tourModel,
    required this.historyModel,
  });

  HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.lightCard,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tourModel?.nameTour ?? 'Tour Đà Nẵng - Hội An',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.black000Size16Fw500FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  historyModel?.bookingDate == null
                      ? "failing"
                      : historyTourController.timestampToString(
                          historyModel?.bookingDate ?? Timestamp.now()),
                  style: AppStyles.black000Size14Fw400FfMont,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '${tourModel?.price} VND',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.blue000Size14Fw400FfMont,
                ),
              ],
            ),
          ),
          SizedBox(
            width: getSize(30),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getSize(14)),
              child: Image.asset(
                AssetHelper.city_1,
                height: getSize(77),
                width: getSize(77),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
