import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/search/search_controller.dart';
import 'package:doan_clean_achitec/modules/search/tab_search.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/DestinationItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/widgets/stateful/search_widget.dart';

class SearchScreen extends GetView<SearchDesController> {
  SearchScreen({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          controller.getAllCityModelData();
          controller.getHistoryCurrentTour();
          controller.getHistoryCurrentDestination();
        },
        child: Scaffold(
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.darkBackground
              : ColorConstants.lightBackground,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: getSize(24),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchWidget(
                      hintText: StringConst.searchDestinations.tr,
                      textEditingController: controller.searchEditingController,
                      focusNode: controller.focusNodeSearch,
                      onChanged: (value) {
                        controller.searchEditingController.addListener(() {
                          controller.onFocusChange();
                        });
                        controller.getTourSearchAll(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  ListSearchTour(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListSearchTour extends StatelessWidget {
  const ListSearchTour({
    super.key,
    required this.controller,
  });

  final SearchDesController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isCheckOnClickSearch.value
          ? controller.getAllTourSearchScreen.value != null &&
                  controller.getAllTourSearchScreen.value!.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: getSize(20)),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getSize(20)),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(getSize(24)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .getAllTourSearchScreen.value!.length,
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (rowIndex > 0)
                                        SizedBox(
                                          height: getSize(16),
                                        ),
                                      GestureDetector(
                                        onTap: () => Get.toNamed(
                                          Routes.TOUR_DETAILS,
                                          arguments: controller
                                              .getAllTourSearchScreen
                                              .value?[rowIndex],
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: controller
                                                              .getAllTourSearchScreen
                                                              .value?[rowIndex]
                                                              .images !=
                                                          null &&
                                                      controller
                                                              .getAllTourSearchScreen
                                                              .value?[rowIndex]
                                                              .images !=
                                                          []
                                                  ? CachedNetworkImage(
                                                      height: getSize(84),
                                                      width: getSize(84),
                                                      fit: BoxFit.cover,
                                                      imageUrl: controller
                                                              .getAllTourSearchScreen
                                                              .value?[rowIndex]
                                                              .images
                                                              ?.first ??
                                                          '',
                                                    )
                                                  : Image.asset(
                                                      height: getSize(84),
                                                      width: getSize(84),
                                                      AssetHelper.city_2,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            SizedBox(
                                              width: getSize(16),
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller
                                                        .getAllTourSearchScreen
                                                        .value?[rowIndex]
                                                        .nameTour ??
                                                    '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: getSize(16)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: getSize(16)),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.getListHistorySearch.value != null &&
                            controller.getListHistorySearch.value!.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(20),
                              vertical: getSize(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Lịch sử tìm kiếm',
                                        style:
                                            AppStyles.black000Size16Fw500FfMont,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () =>
                                          controller.clearHistorySearch(),
                                      child: SvgPicture.asset(
                                        AssetHelper.icDelete,
                                        height: getSize(24),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getSize(8),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getSize(8),
                                ),
                                Wrap(
                                  spacing: 8.0,
                                  children: controller.getListHistorySearch
                                              .value!.length >=
                                          8
                                      ? controller
                                          .getListHistorySearch.value!.reversed
                                          .take(8)
                                          .map((data) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.SEARCH_TOUR_SCREEN,
                                                  arguments: data);
                                            },
                                            child: Chip(
                                              label: Text(data),
                                              backgroundColor:
                                                  const Color(0xFFedf1f7),
                                            ),
                                          );
                                        }).toList()
                                      : controller.getListHistorySearch.value!
                                          .map((data) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.SEARCH_TOUR_SCREEN,
                                                  arguments: data);
                                            },
                                            child: Chip(
                                              label: Text(data),
                                              backgroundColor:
                                                  const Color(0xFFedf1f7),
                                            ),
                                          );
                                        }).toList(),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tìm kiếm nhiều nhất',
                          style: AppStyles.black000Size16Fw500FfMont,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(
                        () => Wrap(
                          spacing: 8.0,
                          children: controller.getListSearchTour.value !=
                                      null &&
                                  controller.getListSearchTour.value!.isNotEmpty
                              ? controller.getListSearchTour.value!.map((data) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.SEARCH_TOUR_SCREEN,
                                          arguments: data.value);
                                    },
                                    child: Chip(
                                      label: Text(data.value ?? ''),
                                      backgroundColor: const Color(0xFFedf1f7),
                                    ),
                                  );
                                }).toList()
                              : controller.chipList.map((data) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.SEARCH_TOUR_SCREEN,
                                          arguments: data);
                                    },
                                    child: Chip(
                                      label: Text(data),
                                      backgroundColor: const Color(0xFFedf1f7),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - getSize(84),
                      child: TabSearchWidget(),
                    ),
                  ],
                )
          : SizedBox(
              height: MediaQuery.of(context).size.height - getSize(200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 4,
                  itemCount: controller.listCitys.value.length,
                  itemBuilder: (context, index) {
                    double randomItemHeight = 0;
                    index % 2 == 0
                        ? randomItemHeight = getSize(220)
                        : randomItemHeight = getSize(192);
                    return InkWell(
                      onTap: () => Get.toNamed(
                        Routes.DETAIL_PLACE,
                        arguments: controller.listCitys.value[index],
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        child: DestinationItem(
                          heightSize: randomItemHeight,
                          textDes: controller.listCitys.value[index].nameCity,
                          img:
                              controller.listCitys.value[index].imageCity ?? "",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
