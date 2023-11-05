import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/google_map/google_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../constants/app_style.dart';
import '../../constants/assets_helper.dart';
import '../../constants/colors.dart';
import '../../utils/size_utils.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({
    super.key,
    this.hintText,
    this.textEditingController,
    this.onChanged,
  });

  final String? hintText;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appController.isDarkModeOn.value
            ? ColorConstants.darkCard
            : ColorConstants.lightCard,
        borderRadius: BorderRadius.circular(14),
      ),
      padding:
          EdgeInsets.symmetric(horizontal: getSize(16), vertical: getSize(4)),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetHelper.icoSearch,
            height: getSize(18),
            width: getSize(18),
            colorFilter: ColorFilter.mode(
              appController.isDarkModeOn.value
                  ? ColorConstants.white
                  : ColorConstants.titleSearch,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            width: getSize(16),
          ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.titleSearch),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: getSize(9),
                ),
                alignLabelWithHint: true,
              ),
              style: AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.white
                      : ColorConstants.titleSearch),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: getSize(16),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.GOOGLE_MAP_SCREEN),
            child: SvgPicture.asset(
              AssetHelper.icoMaps,
              height: getSize(20),
              width: getSize(20),
              colorFilter: ColorFilter.mode(
                appController.isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.graySecond,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
