import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingRiveCheck extends StatelessWidget {
  final RiveAnimationController? controller;

  const LoadingRiveCheck({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getSize(250),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.grayTextField,
        borderRadius: BorderRadius.circular(
          getSize(16),
        ),
      ),
      alignment: Alignment.center,
      child: RiveAnimation.asset(
        'assets/icons/riv/ic_checkerror.riv',
        // artboard: "Search",
        animations: const ['idle', 'curves'],

        onInit: (p0) {
          controller?.isActive;
        },
      ),
    );
  }
}
