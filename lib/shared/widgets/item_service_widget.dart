import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/sevice_item_widget.dart';
import 'package:flutter/material.dart';

class ItemServiceWidget extends StatelessWidget {
  ItemServiceWidget({Key? key}) : super(key: key);

  final List<Map<String, String>> listUtility = [
    {
      'icon': AssetHelper.icoRestau,
      'name': 'Tour',
    },
    {
      'icon': AssetHelper.icCalling,
      'name': 'Hotel',
    },
    {
      'icon': AssetHelper.icBag,
      'name': 'Food',
    },
    {
      'icon': AssetHelper.icShieldDone,
      'name': 'Chill',
    },
  ];

  Widget _buildItemUtilityHotel(String icon, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SeviceItemWidget(
          icon: icon,
          seviceTitle: name,
          isCheckActive: false,
        ),
        SizedBox(
          width: getSize(16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listUtility
            .map((item) => _buildItemUtilityHotel(item['icon']!, item['name']!))
            .toList(),
      ),
    );
  }
}
