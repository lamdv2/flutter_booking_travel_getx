import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/dimension_constants.dart';

class MultilineInput extends StatelessWidget {
  const MultilineInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 15,
                offset: const Offset(0.0, 15.0),
                color: ColorConstants.kTextColor.withAlpha(20))
          ]),
      child: const TextField(
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: 2,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Additional comment',
            hintStyle: TextStyle(
              color: ColorConstants.kTextLightColor,
            )),
      ),
    );
  }
}
