import 'package:flutter/material.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/dimension_constants.dart';
import '../../../shared/widgets/stateful/title.dart';

class TitleDes extends StatelessWidget {
  const TitleDes({
    super.key,
    required this.largeTitle,
    required this.seeAll,
    this.onTap,
  });

  final String largeTitle;
  final String seeAll;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleHome(title: largeTitle),
        InkWell(
          onTap: onTap ?? () {},
          child: Text(
            seeAll,
            style: const TextStyle(
              color: ColorConstants.primaryButton,
              fontSize: kIconRadius,
            ),
          ),
        ),
      ],
    );
  }
}
