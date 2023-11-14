import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/search/search_controller.dart';
import 'package:doan_clean_achitec/modules/search/tab_search.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/DestinationItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../shared/widgets/stateful/search_widget.dart';

class SearchScreen extends GetView<SearchDesController> {
  SearchScreen({super.key});

  final AppController appController = Get.find();
  final SearchDesController controller = Get.put(SearchDesController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () => controller.getAllCityModelData(),
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
                      },
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  Obx(
                    () => controller.isCheckOnClickSearch.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Wrap(
                                  spacing: 8.0,
                                  children: controller.chipList.map((data) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.SEARCH_TOUR_SCREEN,
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
                              ),
                              SizedBox(
                                height: getSize(500),
                                child: TabSearchWidget(),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height -
                                getSize(200),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                      arguments:
                                          controller.listCitys.value[index],
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.all(4),
                                      child: DestinationItem(
                                        heightSize: randomItemHeight,
                                        textDes: controller
                                            .listCitys.value[index].nameCity,
                                        img: controller.listCitys.value[index]
                                                .imageCity ??
                                            "",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
