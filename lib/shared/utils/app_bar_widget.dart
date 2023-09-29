import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/dimension_constants.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.leading,
    this.titles,
    this.actions,
    this.backgroundColor,
    this.iconBgrColor,
    this.onTap,
  }) : super(key: key);

  double? height;

  Widget? leading;

  String? titles;

  Color? backgroundColor = ColorConstants.white;

  Color? iconBgrColor;

  List<Widget>? actions;

  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? ColorConstants.white,
      leading: leading ??
          Padding(
            padding: const EdgeInsets.only(
              left: 18,
              top: 9,
              bottom: 9,
            ),
            child: InkWell(
              onTap: onTap != null ? () => onTap : () => Get.back(),
              borderRadius: BorderRadius.circular(kIconRadius),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 2,
                  top: 2,
                  bottom: 2,
                  right: 2,
                ),
                child: Container(
                  padding: EdgeInsets.all(getSize(kItemPadding)),
                  decoration: BoxDecoration(
                    color: iconBgrColor ?? ColorConstants.grayTextField,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(kIconRadius),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AssetHelper.icoNextLeft,
                    colorFilter: const ColorFilter.mode(
                      ColorConstants.titleSearch,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
      title: Text(
        titles ?? '',
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: AppStyles.black000Size30Fw600FfMont,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(height ?? getVerticalSize(getSize(70)));
  }
}
