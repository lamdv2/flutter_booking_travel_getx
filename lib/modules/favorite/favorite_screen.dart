import 'dart:math';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/favorite/favorite.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/DestinationItem.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/item_favourite.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/item_favourite_tour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../shared/utils/size_utils.dart';

// ignore: must_be_immutable
class FavoriteScreen extends GetView<FavoriteController> {
  FavoriteScreen({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.darkAppBar
              : ColorConstants.primaryButton,
          iconBgrColor: ColorConstants.lightAppBar,
          titles: "Favourite",
        ),
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      labelColor: appController.isDarkModeOn.value
                          ? ColorConstants.primaryButton
                          : ColorConstants.primaryButton,
                      unselectedLabelColor: ColorConstants.gray600,
                      indicatorColor: appController.isDarkModeOn.value
                          ? ColorConstants.primaryButton
                          : ColorConstants.primaryButton,
                      tabs: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Tab(text: 'Tour'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Tab(text: 'Destination'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(getSize(4.0)),
                      child: Obx(
                        () => TourWidget(
                            listTourModel:
                                controller.getListTourFavourite.value ?? []),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(getSize(4.0)),
                      child: Obx(
                        () => DesWidget(
                          listDes: controller.getListDestination.value ?? [],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // child: SingleChildScrollView(
  //   child: Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Column(
  //       children: [
  //         Text(
  //           StringConst.favorite.tr,
  //           style: const TextStyle(
  //             fontSize: 22,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         ListDestination(size: size),
  //       ],
  //     ),
  //   ),
  // ),

  double randomHeight() {
    var random = Random();
    return random.nextInt(2) == 0 ? 192 : 220;
  }
}

class DesWidget extends StatelessWidget {
  final List<CityModel> listDes;

  const DesWidget({
    super.key,
    required this.listDes,
  });

  @override
  Widget build(BuildContext context) {
    return listDes.isEmpty
        ? Center(
            child: SizedBox(
              height: getSize(200),
              child: Lottie.asset(
                AssetHelper.imgLottieNodate,
                width: getSize(200),
                height: getSize(200),
                fit: BoxFit.fill,
              ),
            ),
          )
        : MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: listDes.length,
            itemBuilder: (context, index) {
              double randomItemHeight = 0;
              index % 2 == 0 ? randomItemHeight = 220 : randomItemHeight = 192;
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(4),
                child: ItemFavourite(
                  heightSize: randomItemHeight,
                  desModel: listDes[index],
                ),
              );
            },
          );
  }
}

class TourWidget extends StatelessWidget {
  final List<TourModel> listTourModel;

  const TourWidget({
    super.key,
    required this.listTourModel,
  });

  @override
  Widget build(BuildContext context) {
    return listTourModel.isEmpty
        ? Center(
            child: SizedBox(
              height: getSize(200),
              child: Lottie.asset(
                AssetHelper.imgLottieNodate,
                width: getSize(200),
                height: getSize(200),
                fit: BoxFit.fill,
              ),
            ),
          )
        : MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: listTourModel.length,
            itemBuilder: (context, index) {
              double randomItemHeight = 0;
              index % 2 == 0 ? randomItemHeight = 220 : randomItemHeight = 192;
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(4),
                child: ItemFavouriteTour(
                  heightSize: randomItemHeight,
                  tourModel: listTourModel[index],
                ),
              );
            },
          );
  }
}
