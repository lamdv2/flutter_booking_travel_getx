import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/select_date.dart';
import 'package:doan_clean_achitec/shared/widgets/bottomsheet_tour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../shared/widgets/bottomsheet_type_tour.dart';
import '../../shared/widgets/stateful/search_widget_tour.dart';

class SearchTourScreen extends GetView<SearchDesController> {
  SearchTourScreen({super.key});

  final AppController appController = Get.find();
  final String? dataSearch = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      controller.searchEditingController.text = dataSearch ?? "";
      controller.searchTourEditingController.text = dataSearch ?? "";
      controller.getTourSearch(dataSearch ?? "");
    });

    return Obx(
      () => RefreshIndicator(
        onRefresh: () => controller.getAllTourSearchData(dataSearch ?? ""),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: appController.isDarkModeOn.value
                ? ColorConstants.darkBackground
                : ColorConstants.lightBackground,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getSize(16),
                      ),
                      SearchWidgetTour(
                        hintText: StringConst.searchDestinations.tr,
                        textEditingController:
                            controller.searchTourEditingController,
                        focusNode: controller.focusNodeSearchTour,
                        onChanged: (value) {
                          controller.getTourSearch(value);
                          controller.searchTourEditingController.text = value;
                        },
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showDestination(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getSize(8),
                                    horizontal: getSize(12),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: ColorConstants.gray500,
                                      width: .5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Destination",
                                        style:
                                            AppStyles.black000Size13Fw400FfMont,
                                      ),
                                      SizedBox(
                                        width: getSize(4),
                                      ),
                                      SvgPicture.asset(
                                        AssetHelper.icArrowDown2,
                                        width: getSize(18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getSize(12),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showTypeTour(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getSize(8),
                                    horizontal: getSize(12),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: ColorConstants.gray500,
                                      width: .5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Type tour",
                                        style:
                                            AppStyles.black000Size13Fw400FfMont,
                                      ),
                                      SizedBox(
                                        width: getSize(4),
                                      ),
                                      SvgPicture.asset(
                                        AssetHelper.icArrowDown2,
                                        width: getSize(18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getSize(12),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showDate(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getSize(8),
                                    horizontal: getSize(12),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: ColorConstants.gray500,
                                      width: .5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Date",
                                        style:
                                            AppStyles.black000Size13Fw400FfMont,
                                      ),
                                      SizedBox(
                                        width: getSize(4),
                                      ),
                                      SvgPicture.asset(
                                        AssetHelper.icArrowDown2,
                                        width: getSize(18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getSize(20),
                      ),
                      Obx(
                        () => controller.getAllTourSearch.value!.isNotEmpty
                            ? SingleChildScrollView(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                          .getAllTourSearch.value?.length ??
                                      2,
                                  itemBuilder:
                                      (BuildContext context, int rowIndex) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: getSize(12),
                                      ),
                                      child: buildItemTourSearch(
                                        tourModel: controller
                                            .getAllTourSearch.value?[rowIndex],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const NoData(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDestination(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BottomSheetTour(dataSheet: controller.destination);
      },
    );
  }

  void _showTypeTour(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
            child: BottomSheetTypeTour(dataSheet: controller.destination));
      },
    );
  }

  void _showDate(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SelectDateScreen();
      },
    );
  }
}

class NoData extends StatelessWidget {
  const NoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(64),
      ),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AssetHelper.imgLottieNodate,
                width: getSize(200),
                height: getSize(200),
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class buildItemTourSearch extends GetView<SearchDesController> {
  TourModel? tourModel;

  buildItemTourSearch({
    super.key,
    required this.tourModel,
  });

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.TOUR_DETAILS, arguments: tourModel),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.lightCard,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(getSize(8)),
              child: tourModel?.images != null && tourModel?.images != []
                  ? CachedNetworkImage(
                      height: getSize(200),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: tourModel?.images?.first ?? '',
                    )
                  : Image.asset(
                      height: getSize(200),
                      width: double.infinity,
                      AssetHelper.imgPrevHotel01,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(20),
                vertical: getSize(16),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    tourModel?.nameTour ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: AppStyles.black000Size16Fw500FfMont,
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetHelper.icStar,
                        width: getSize(20),
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.dividerColor
                            : ColorConstants.yellow,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Text(
                        '${tourModel?.rating.toString()} (${tourModel?.reviews != null && tourModel!.reviews!.isNotEmpty ? tourModel?.reviews?.length : 0})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.titleSearchSize14Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetHelper.icCalendar,
                        width: getSize(20),
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.dividerColor
                            : ColorConstants.botTitle,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Text(
                        '${controller.timestampToString(
                          tourModel?.startDate ?? Timestamp.now(),
                        )} - ${controller.timestampToString(
                          tourModel?.endDate ?? Timestamp.now(),
                        )}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.titleSearchSize14Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetHelper.icBuy,
                        width: getSize(20),
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.dividerColor
                            : ColorConstants.botTitle,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Text(
                        '${tourModel?.price} VND',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyles.blue000Size14Fw400FfMont,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class buildItemHistory extends StatelessWidget {
  TourModel? tourModel;

  buildItemHistory({this.tourModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.grayTextField,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tourModel?.nameTour ?? 'Tour Đà Nẵng - Hội An',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.black000Size16Fw500FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  'abc',
                  style: AppStyles.black000Size14Fw400FfMont,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '${tourModel?.price} VND',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.blue000Size14Fw400FfMont,
                ),
              ],
            ),
          ),
          SizedBox(
            width: getSize(30),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getSize(14)),
              child: Image.asset(
                AssetHelper.city_1,
                height: getSize(77),
                width: getSize(77),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
