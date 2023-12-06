import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/sevice_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemServiceWidget extends StatelessWidget {
  const ItemServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SeviceItemWidget(
              onTap: (GetSnackBar snack) {
                Get.toNamed(Routes.HOTEL);
              },
              icon: AssetHelper.icWallet,
              seviceTitle: StringConst.tours.tr,
              isCheckActive: true,
            ),
            SizedBox(
              width: getSize(24),
            ),
            SeviceItemWidget(
              onTap: (snack) {
                Get.toNamed(Routes.HOTEL);
              },
              icon: AssetHelper.icoHotel,
              seviceTitle: StringConst.hotels.tr,
              isCheckActive: false,
            ),
            SizedBox(
              width: getSize(24),
            ),
            SeviceItemWidget(
              onTap: (GetSnackBar snack) {
                Get.toNamed(Routes.HOTEL);
              },
              icon: AssetHelper.icoPlane,
              seviceTitle: StringConst.flights.tr,
              isCheckActive: false,
            ),
            SizedBox(
              width: getSize(24),
            ),
            SeviceItemWidget(
              onTap: (GetSnackBar snack) {
                Get.toNamed(Routes.HOTEL);
              },
              icon: AssetHelper.icoRestau,
              seviceTitle: StringConst.restaurants.tr,
              isCheckActive: false,
            ),
          ],
        ),
      ),
    );
  }
}
