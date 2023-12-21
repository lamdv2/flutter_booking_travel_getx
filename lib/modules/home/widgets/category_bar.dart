// ignore_for_file: must_be_immutable

import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBar extends StatelessWidget {
  CategoryBar({
    super.key,
  });

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> menuList = [
      StringConst.all.tr,
      StringConst.popular.tr,
      "New".tr,
      "Sale".tr,
      "Close here".tr
    ];

    return Container(
      margin: const EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kMediumPadding,
      ),
      child: SizedBox(
        height: getSize(48),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                homeController.categoryIndex.value = index;
              },
              child: Obx(
                () => Container(
                  width: getSize(96),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: kDefaultPadding),
                  decoration: homeController.categoryIndex.value == index
                      ? const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorConstants.primaryButton,
                              Gradients.lightBlue1,
                            ],
                          ),
                          borderRadius: kSmallBorderRadius,
                        )
                      : BoxDecoration(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.darkCard
                              : ColorConstants.lightCard,
                          borderRadius: kSmallBorderRadius,
                        ),
                  child: Text(
                    menuList[index].toString(),
                    style: TextStyle(
                      fontSize: getSize(16),
                      fontWeight: FontWeight.w500,
                      color: homeController.categoryIndex.value == index
                          ? ColorConstants.white
                          : appController.isDarkModeOn.value
                              ? ColorConstants.lightCard
                              : ColorConstants.black,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
