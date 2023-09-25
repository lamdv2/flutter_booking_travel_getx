import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/sevice_item_widget.dart';
import 'package:flutter/material.dart';

class ItemUtilityDetailHotelWidget extends StatelessWidget {
  ItemUtilityDetailHotelWidget({Key? key}) : super(key: key);

  final List<Map<String, String>> listUtility = [
    {
      'icon': AssetHelper.icoRestau,
      'name': 'Restaurant',
    },
    {
      'icon': AssetHelper.icoHotel,
      'name': 'Wifi',
    },
    {
      'icon': AssetHelper.icoBooking,
      'name': 'Currency\nExchange',
    },
    {
      'icon': AssetHelper.heart,
      'name': '24-hour\nFront Desk',
    },
    {
      'icon': AssetHelper.icoHamburgerMenu,
      'name': 'More',
    },
  ];

  Widget _buildItemUtilityHotel(String icon, String name) {
    return Row(
      children: [
        SeviceItemWidget(icon: icon, seviceTitle: name),
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
