import 'package:doan_clean_achitec/modules/home/widgets/title_des.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/widgets/sevice_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/utils/size_utils.dart';

class DetailPlaceScreen extends StatefulWidget {
  const DetailPlaceScreen({super.key});

  @override
  State<DetailPlaceScreen> createState() => _DetailPlaceScreenState();
}

class _DetailPlaceScreenState extends State<DetailPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ho Chi Minh City",
                      style: TextStyle(
                          color: ColorConstants.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      splashColor: ColorConstants.blur,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          AssetHelper.icoGetBack,
                          width: getSize(32),
                          height: getSize(32),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 16),
                child: Text(
                  "Let's explore new place",
                  style: TextStyle(
                      color: ColorConstants.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: size.height / 3.5,
                width: size.width,
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 10),
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          height: size.height / 3.5,
                          width: size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: AssetImage(AssetHelper.city_bgr_1),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: size.width / 3.3,
                        child: const Text(
                          "Fri, 22 May 2023",
                          style: TextStyle(
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
                            SvgPicture.asset(
                              AssetHelper.icArrowLeft,
                              color: ColorConstants.white,
                              width: getSize(24),
                              height: getSize(24),
                            ),
                            Text(
                              "  36",
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
                        child: SizedBox(
                          height: size.height / 22,
                          width: size.width,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Wind",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "13 Km/h",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Humidity",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "25",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Visibility",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "10 Km",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Pressure",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "1010 mb",
                                    style: TextStyle(
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
                height: getSize(16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SeviceItemWidget(
                    onTap: (snack) {
                      Get.toNamed(Routes.HOTEL);
                    },
                    icon: AssetHelper.icoHotel,
                    seviceTitle: 'Hotels',
                  ),
                  SeviceItemWidget(
                    onTap: (GetSnackBar snack) {
                      Get.toNamed(Routes.HOTEL);
                    },
                    icon: AssetHelper.icoPlane,
                    seviceTitle: 'Flights',
                  ),
                  SeviceItemWidget(
                    onTap: (GetSnackBar snack) {
                      Get.toNamed(Routes.HOTEL);
                    },
                    icon: AssetHelper.icoRestau,
                    seviceTitle: 'Restau',
                  ),
                  SeviceItemWidget(
                    onTap: (GetSnackBar snack) {
                      Get.toNamed(Routes.HOTEL);
                    },
                    icon: AssetHelper.icoCar,
                    seviceTitle: 'Cars',
                  ),
                ],
              ),
              SizedBox(
                height: getSize(24),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(20),
                ),
                child: TitleDes(
                  largeTitle: 'Sightseeing',
                  seeAll: 'See All',
                  onTap: () {
                    Get.toNamed(Routes.TOUR);
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16, left: 16),
                      height: size.height / 6,
                      width: size.width / 1.9,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AssetHelper.city_7),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, left: 16),
                      height: size.height / 6,
                      width: size.width / 1.9,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AssetHelper.city_8),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      height: size.height / 6,
                      width: size.width / 1.9,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AssetHelper.city_6),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      height: size.height / 6,
                      width: size.width / 1.9,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AssetHelper.city_5),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16),
                child: Text(
                  "Top-pick Articles",
                  style: TextStyle(
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                      height: size.height / 5,
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
                      margin:
                          const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                      height: size.height / 5,
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
                      height: size.height / 5,
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
    );
  }
}
