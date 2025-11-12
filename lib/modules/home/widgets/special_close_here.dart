import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../../search/search_controller.dart';
import '../home_controller.dart';
import 'special_offer_card.dart';
import 'title_des.dart';

class SpecialCloseHere extends StatelessWidget {
  SpecialCloseHere({
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
            largeTitle: "Tours close here".tr,
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
              child: tourController.getListTourTop10CloseHere.value != null &&
                      tourController.getListTourTop10CloseHere.value!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          tourController.getListTourTop10CloseHere.value?.length ?? 0,
                      itemBuilder: (BuildContext context, int rowIndex) {
                        return SpecialOfferCard(
                          tourModel: tourController
                              .getListTourTop10CloseHere.value![rowIndex],
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
