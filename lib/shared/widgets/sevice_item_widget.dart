import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class SeviceItemWidget extends StatelessWidget {
  OnTap? onTap;
  String icon;
  String seviceTitle;
  bool isCheckActive;

  SeviceItemWidget({
    this.onTap,
    required this.icon,
    required this.seviceTitle,
    required this.isCheckActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(20),
      ),
      width: getSize(84),
      decoration: BoxDecoration(
        color:
            isCheckActive ? ColorConstants.primaryButton : ColorConstants.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorConstants.darkGray.withOpacity(.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => onTap,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                icon,
                height: isCheckActive ? getSize(36) : getSize(30),
                width: isCheckActive ? getSize(36) : getSize(30),
                colorFilter: ColorFilter.mode(
                  isCheckActive
                      ? ColorConstants.white
                      : ColorConstants.titleSearch,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            seviceTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: isCheckActive
                ? AppStyles.white000Size12Fw400FfMont
                : AppStyles.black000Size12Fw400FfMont,
          ),
        ],
      ),
    );
  }
}
