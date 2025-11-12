// ignore_for_file: deprecated_member_use
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import 'icon_style.dart';

class BuildSettingsItem extends StatelessWidget {
  final String? imageAsset;
  final IconStyle? iconStyle;
  final Widget? widgetTitle;
  final Widget? subWidget1;
  final Widget? subWidget2;
  final Widget? subWidget3;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool? isShowTrailing;
  final bool? isDisableColor;
  final bool? isDeleteColor;
  final bool? isIconLanguage;
  final Function()? onLongPress;

  final AppController appController = Get.find();

  BuildSettingsItem({
    super.key,
    this.imageAsset,
    this.iconStyle,
    this.widgetTitle,
    this.subWidget1,
    this.subWidget2,
    this.subWidget3,
    this.backgroundColor,
    this.trailing,
    this.isShowTrailing,
    this.isDisableColor = false,
    this.leading,
    this.onTap,
    this.isDeleteColor = false,
    this.isIconLanguage = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        onLongPress: onLongPress,
        dense: true,
        onTap: onTap,
        leading: leading ??
            ((iconStyle != null && iconStyle!.withBackground!)
                ? Container(
                    decoration: BoxDecoration(
                      color: iconStyle!.backgroundColor,
                      borderRadius:
                          BorderRadius.circular(iconStyle!.borderRadius!),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      imageAsset ?? AssetHelper.icInfoSquare,
                      width: 18,
                      height: 18,
                      color: iconStyle!.iconsColor,
                    ),
                  )
                : imageAsset != null
                    ? SvgPicture.asset(
                        imageAsset ?? AssetHelper.icInfoSquare,
                        width: 18,
                        height: 18,
                        color: isDeleteColor == false
                            ? isDisableColor == false
                                ? appController.isDarkModeOn.value
                                    ? ColorConstants.lightAppBar
                                    : ColorConstants.grey800
                                : null
                            : ColorConstants.red,
                      )
                    : null),
        title: (widgetTitle != null) ? widgetTitle : null,
        subtitle: (subWidget1 != null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  subWidget1 ?? const SizedBox(),
                  if (subWidget2 != null)
                    const SizedBox(
                      height: 8,
                    ),
                  if (subWidget2 != null) subWidget2 ?? const SizedBox(),
                  if (subWidget3 != null)
                    const SizedBox(
                      height: 8,
                    ),
                  if (subWidget3 != null) subWidget3 ?? const SizedBox(),
                ],
              )
            : null,
        trailing: (trailing != null)
            ? trailing
            : (isShowTrailing == false)
                ? null
                : isIconLanguage == false
                    ? SvgPicture.asset(
                        AssetHelper.icoNextRight,
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.lightAppBar
                            : ColorConstants.gray600,
                        width: 18,
                        height: 18,
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.language,
                          color: ColorConstants.primaryButton,
                        ),
                      ),
      ),
    );
  }
}
