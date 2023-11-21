import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/dimension_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key, required this.textBtn, this.onTap, this.color, this.gradient})
      : super(key: key);

  final String textBtn;
  final Function()? onTap;
  final Color? color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getSize(kTopPadding),
          horizontal: getSize(kDefaultPadding),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kTopPadding),
          gradient: gradient == null
              ? Gradients.defaultGradientBackground
              : Gradients.defaultGradientButtonCancel,
        ),
        alignment: Alignment.center,
        child: Text(
          textBtn,
          style: color == null
              ? AppStyles.white000Size18Fw500FfMont
              : const TextStyle(
                  fontSize: 18,
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
        ),
      ),
    );
  }
}
