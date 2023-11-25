// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/modules/history_tour/history_tour_controller.dart';
import 'package:doan_clean_achitec/modules/history_tour/tour_history_detail/comment_screen.dart';
import 'package:doan_clean_achitec/modules/history_tour/tour_history_detail/preytty_qr_code.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../shared/constants/app_style.dart';

class TourQRCodeDetail extends StatelessWidget {
  final GlobalKey<State> globalKey = GlobalKey<State>();
  final HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  final AppController appController = Get.find();

  final TourModel? tourModel = Get.arguments['arg1'];
  final String getStatus = Get.arguments['arg2'];
  final HistoryModel? historyModel = Get.arguments['arg3'];

  TourQRCodeDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetHelper.icSend,
                      width: getSize(20),
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.dividerColor
                          : ColorConstants.botTitle,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    Expanded(
                      child: Text(
                        tourModel?.nameTour ?? "",
                        style: AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetHelper.icCalendar,
                      width: getSize(20),
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.dividerColor
                          : ColorConstants.botTitle,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    Text(
                      '${historyTourController.timestampToStringStart(tourModel?.startDate ?? Timestamp.now())} - ${historyTourController.timestampToStringEnd(tourModel?.endDate ?? Timestamp.now())}',
                      style: AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.dividerColor
                            : ColorConstants.botTitle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetHelper.icBuy,
                      width: getSize(20),
                      colorFilter: ColorFilter.mode(
                        appController.isDarkModeOn.value
                            ? ColorConstants.dividerColor
                            : ColorConstants.botTitle,
                        BlendMode.srcIn,
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    Text(
                      '${tourModel?.price}đ',
                      style: AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.dividerColor
                            : ColorConstants.botTitle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tourModel?.nameTour ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PrettyQrAnimatedView(
                            qrImage: QrImage(
                              QrCode.fromData(
                                data: historyModel?.id ?? '',
                                errorCorrectLevel: QrErrorCorrectLevel.H,
                              ),
                            ),
                            decoration: historyTourController.decoration,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(16)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: appController.isDarkModeOn.value
                            ? ColorConstants.darkCard
                            : ColorConstants.primaryButton,
                      ),
                      onPressed: () =>
                          historyTourController.saveLocalImage(globalKey),
                      child: Text(
                        'Take ScreenShot',
                        style: TextStyle(
                          fontSize: 18,
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.lightAppBar
                              : ColorConstants.lightAppBar,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                getStatus == "upcoming"
                    ? Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(16)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                              backgroundColor: appController.isDarkModeOn.value
                                  ? ColorConstants.darkCard
                                  : ColorConstants.primaryButton,
                            ),
                            onPressed: () async {
                              HistoryModel historyModel =
                                  await historyTourController
                                      .getHistoryByIdTour(
                                          tourModel?.idTour ?? '');
                              historyModel.status = 'canceled';
                              historyTourController
                                  .updateUserProfile(historyModel);
                              Get.back();
                            },
                            child: Text(
                              'Cancel tour',
                              style: TextStyle(
                                fontSize: 18,
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.lightAppBar
                                    : ColorConstants.lightAppBar,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                getStatus == "completed"
                    ? Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(16)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                              backgroundColor: appController.isDarkModeOn.value
                                  ? ColorConstants.darkCard
                                  : ColorConstants.primaryButton,
                            ),
                            onPressed: () => Get.to(
                              CommentTourScreen(id: tourModel!.idTour ?? ""),
                            ),
                            child: Text(
                              'Tour review',
                              style: TextStyle(
                                fontSize: 18,
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.lightAppBar
                                    : ColorConstants.lightAppBar,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
