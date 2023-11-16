import 'package:doan_clean_achitec/modules/rate/components/rounded_button.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/dimension_constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedButton(
          icon: const Icon(Icons.arrow_back),
          iconColor: ColorConstants.kPrimaryColor,
          bgColor: Colors.white,
          tap: () {},
        ),
        const SizedBox(width: kDefaultPadding),
        const Text(
          'You are in place!',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        )
      ],
    );
  }
}
