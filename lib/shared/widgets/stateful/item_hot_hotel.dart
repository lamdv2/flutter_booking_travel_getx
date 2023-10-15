import 'package:flutter/material.dart';

import '../../constants/app_style.dart';
import '../../utils/size_utils.dart';

// ignore: must_be_immutable
class ItemTopHotel extends StatelessWidget {
  String nameHotel;
  String imgHotel;
  ItemTopHotel({
    super.key,
    required this.nameHotel,
    required this.imgHotel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(getSize(16)),
          child: Image.asset(
            imgHotel,
            width: getSize(64),
            height: getSize(64),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getSize(16),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: getSize(64)),
          child: Tooltip(
            message: nameHotel,
            preferBelow: false,
            child: Text(
              nameHotel,
              style: AppStyles.black000Size14Fw400FfMont,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
      ],
    );
  }
}
