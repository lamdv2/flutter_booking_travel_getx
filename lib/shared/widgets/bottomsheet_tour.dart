import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BottomSheetTour extends StatelessWidget {
  List<String> dataSheet;
  BottomSheetTour({
    super.key,
    required this.dataSheet,
  });

  final SearchDesController controller = Get.find();
  final AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: getSize(16)),
            child: Container(
              width: getSize(60),
              height: getSize(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorConstants.gray500,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.03),
                    spreadRadius: 10,
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(getSize(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.cancel,
                    size: getSize(30),
                    color: ColorConstants.grey800,
                  ),
                ),
                Text(
                  StringConst.destination.tr,
                  style: AppStyles.black000Size16Fw600FfMont,
                ),
                SvgPicture.asset(
                  AssetHelper.icDelete,
                  colorFilter: const ColorFilter.mode(
                    ColorConstants.titleSearch,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.fitHeight,
                  width: getSize(30),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: getSize(10)),
            child: Wrap(
              spacing: 8.0,
              children: dataSheet.map((data) {
                return GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.SEARCH_TOUR_SCREEN, arguments: data);
                  },
                  child: Chip(
                    label: Text(data),
                    backgroundColor: const Color(0xFFedf1f7),
                  ),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
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
                  child: InkWell(
                    onTap: () => controller.getTourSearch(''),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryButton,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: getSize(16),
                      ),
                      child: Text(StringConst.confirmation.tr,
                          style: AppStyles.white000Size14Fw500FfMont,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
