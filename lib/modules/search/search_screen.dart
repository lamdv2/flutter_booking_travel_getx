import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/search/search_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/DestinationItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../shared/widgets/stateful/search_bar.dart';

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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: getSize(8),
                  ),
                  SearchBarWidget(hintText: StringConst.searchDestinations.tr),
                  SizedBox(
                    height: getSize(8),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - getSize(200),
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
                              textDes:
                                  controller.listCitys.value[index].nameCity,
                              img:
                                  controller.listCitys.value[index].imageCity ??
                                      "",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getSize(28),
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
