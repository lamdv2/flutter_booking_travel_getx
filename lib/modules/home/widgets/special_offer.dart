import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';
import 'special_offer_card.dart';
import 'title_des.dart';

class SpecialOffers extends StatelessWidget {
  SpecialOffers({
    Key? key,
  }) : super(key: key);
  final HomeController homecontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleDes(
          largeTitle: 'Special for you',
          seeAll: StringConst.seeAll.tr,
          onTap: () {
            homecontroller.currentIndex.value = 2;
          },
        ),
        SizedBox(height: getSize(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: AssetHelper.city_5,
                category: "Ha Noi",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: AssetHelper.city_6,
                category: "Ha Long",
                numOfBrands: 40,
                press: () {},
              ),
              SpecialOfferCard(
                image: AssetHelper.city_2,
                category: "Da Nang",
                numOfBrands: 24,
                press: () {},
              ),
              SizedBox(width: getSize(20)),
            ],
          ),
        ),
      ],
    );
  }
}
