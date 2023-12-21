import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/modules/detail_place/detail_place.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/home/widgets/title_des.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/widgets/sevice_item_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/tour_sight_seeing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../models/city/city_model.dart';
import '../../shared/utils/size_utils.dart';
import '../profile/image_full_screen.dart';

class DetailPlaceScreen extends GetView<DetailPlaceController> {
  DetailPlaceScreen({super.key});
  final CityModel? cityModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String dayTimeNow = controller.formatDateTime(DateTime.now());
    controller.fetchDataWeather(cityModel?.nameCity ?? "");

    controller.getAllTourModelData(cityModel?.idCity ?? "");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cityModel?.nameCity ?? '',
                        style: TextStyle(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.lightCard
                                : ColorConstants.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(kIconRadius),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 2,
                            top: 2,
                            bottom: 2,
                            right: 2,
                          ),
                          child: Container(
                            width: getSize(40),
                            height: getSize(40),
                            padding: EdgeInsets.all(getSize(kItemPadding)),
                            decoration: const BoxDecoration(
                              color: ColorConstants.grayTextField,
                              borderRadius: BorderRadius.all(
                                Radius.circular(kIconRadius),
                              ),
                            ),
                            child: SvgPicture.asset(
                              AssetHelper.icoNextLeft,
                              colorFilter: const ColorFilter.mode(
                                ColorConstants.titleSearch,
                                BlendMode.srcIn,
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    StringConst.letsExplore.tr,
                    style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.lightCard
                            : ColorConstants.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  SizedBox(
                    height: getSize(240),
                    child: Center(
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              height: size.height / 3.5,
                              width: size.width,
                              decoration: cityModel?.imageCity == ''
                                  ? const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        image:
                                            AssetImage(AssetHelper.city_bgr_1),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : BoxDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          cityModel?.imageCity! ?? '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: kSmallBorderRadius,
                                    ),
                            ),
                          ),
                          Positioned(
                            top: 24,
                            left: size.width / 3.3,
                            child: Text(
                              dayTimeNow,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 58,
                            left: size.width / 2.6,
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetHelper.icoSun,
                                  color: ColorConstants.white,
                                  width: getSize(24),
                                  height: getSize(24),
                                ),
                                Text(
                                  "  ${controller.temperatureCelsius.toInt()} °C",
                                  style: TextStyle(
                                    fontSize: getSize(24),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            // top: 180,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: getSize(8),
                              ),
                              height: getSize(60),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorConstants.darkGray.withOpacity(.6),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(getSize(8)),
                                  bottomRight: Radius.circular(getSize(8)),
                                ),
                              ),
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        StringConst.wind.tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${controller.windSpeed} m/s",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        StringConst.humidity.tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${controller.humidity}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Cloudiness".tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${controller.cloudiness} %",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        StringConst.pressure.tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${controller.pressure} hpa",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
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
                  SingleChildScrollView(
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
                          width: getSize(10),
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
                          width: getSize(10),
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
                          width: getSize(10),
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
                  SizedBox(
                    height: getSize(28),
                  ),
                  TitleDes(
                    largeTitle: StringConst.sightseeing.tr,
                    seeAll: StringConst.seeAll.tr,
                    onTap: () {
                      Get.toNamed(Routes.TOUR);
                    },
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  controller.getListTour.value != null &&
                          controller.getListTour.value!.isNotEmpty
                      ? SizedBox(
                          height: getSize(280),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.getListTour.value?.length ?? 0,
                            itemBuilder: (BuildContext context, int rowIndex) {
                              return Row(
                                children: [
                                  if (rowIndex > 0)
                                    SizedBox(
                                      width: getSize(16),
                                    ),
                                  TourSightSeeingWidget(
                                    tourModel:
                                        controller.getListTour.value![rowIndex],
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Lottie.asset(
                            AssetHelper.imgLottieNodate,
                            width: getSize(200),
                            height: getSize(200),
                            fit: BoxFit.fill,
                          ),
                        ),
                  SizedBox(
                    height: getSize(28),
                  ),
                  Text(
                    StringConst.topPickArticles.tr,
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size18Fw500FfMont
                        : AppStyles.black000Size18Fw500FfMont,
                  ),
                  cityModel?.listArt != null && cityModel!.listArt!.isNotEmpty
                      ? SizedBox(
                          height: getSize(200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: cityModel?.listArt?.length ?? 0,
                            itemBuilder: (BuildContext context, int rowIndex) {
                              return Row(
                                children: [
                                  if (rowIndex > 0)
                                    SizedBox(
                                      width: getSize(16),
                                    ),
                                  GestureDetector(
                                    onTap: () => Get.to(
                                      FullImageScreen(
                                        imageUrl:
                                            cityModel?.listArt?[rowIndex] ?? "",
                                      ),
                                    ),
                                    child: Container(
                                      height: getSize(180),
                                      width: size.width / 3 * 2,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                            cityModel?.listArt?[rowIndex] ?? '',
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                height: getSize(180),
                                width: size.width / 3 * 2,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(AssetHelper.city_3),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 16, left: 16, bottom: 16),
                                height: getSize(180),
                                width: size.width / 3 * 2,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(AssetHelper.city_1),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(16),
                                height: getSize(180),
                                width: size.width / 3 * 2,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(AssetHelper.city_2),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ],
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
