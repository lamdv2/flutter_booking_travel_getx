import 'package:doan_clean_achitec/modules/rate/components/rounded_button.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          StringConst.submit.tr,
          style: const TextStyle(
              color: ColorConstants.lightBlueNon,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        const SizedBox(width: kDefaultPadding),
        RoundedButton(
            icon: const Icon(Icons.arrow_forward),
            iconColor: Colors.white,
            bgColor: ColorConstants.lightBlueNon,
            tap: () {})
      ],
    );
  }
}
