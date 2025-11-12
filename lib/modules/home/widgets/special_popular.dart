import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../search/search_controller.dart';
import '../home_controller.dart';
import 'special_offer_card.dart';
import 'title_des.dart';

class SpecialPopular extends StatelessWidget {
  SpecialPopular({
    super.key,
  });
  final HomeController homecontroller = Get.find();
  final TourController tourController = Get.put(TourController());
  final SearchDesController searchDesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          TitleDes(
            largeTitle: "Tours popular".tr,
            seeAll: StringConst.seeAll.tr,
            onTap: () {
              Get.toNamed(Routes.TOUR);
            },
          ),
          SizedBox(height: getSize(20)),
          SizedBox(
            height: getSize(160),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tourController.getListTourTop10Popular.value != null &&
                      tourController.getListTourTop10Popular.value!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tourController
                              .getListTourTop10Popular.value?.length ??
                          0,
                      itemBuilder: (BuildContext context, int rowIndex) {
                        return SpecialOfferCard(
                          tourModel: tourController
                              .getListTourTop10Popular.value![rowIndex],
                        );
                      },
                    )
                  : Lottie.asset(
                      AssetHelper.imgLottieNodate,
                      width: getSize(200),
                      height: getSize(200),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
