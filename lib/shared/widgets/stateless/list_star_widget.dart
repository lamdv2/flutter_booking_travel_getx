import 'package:doan_clean_achitec/shared/widgets/stateless/star_half_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/star_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/app_style.dart';

class ListStarWidget extends StatelessWidget {
  const ListStarWidget({Key? key, required this.desti}) : super(key: key);

  final double desti;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (desti >= 4) ...List.generate(4, (index) => const StarWidget()),
        if (desti > 4 && desti < 5) const StarHalfWidget(),
        if (desti == 5) ...List.generate(5, (index) => const StarWidget()),
        if (desti < 4) ...List.generate(3, (index) => const StarWidget()),
        if (desti > 3 && desti < 4) const StarHalfWidget(),
        Text(
          ' ($desti)',
          style: AppStyles.black000Size12Fw400FfMont,
        ),
      ],
    );
  }
}
