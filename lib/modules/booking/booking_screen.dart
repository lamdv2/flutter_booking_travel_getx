import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Booking",
        iconBgrColor: ColorConstants.grayTextField,
        onTap: (snack) => homeController.currentIndex.value = 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                "Choose your favorite hotel and enjoy the service",
                style: AppStyles.botTitle000Size12Fw400FfMont,
              ),
              SizedBox(
                height: getSize(46),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.grayTextField,
                  borderRadius: BorderRadius.circular(getSize(14)),
                ),
                padding: EdgeInsets.all(getSize(16)),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetHelper.icoDestination),
                    SizedBox(
                      width: getSize(16),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Destination",
                          style: AppStyles.black000Size12Fw400FfMont,
                        ),
                        SizedBox(
                          height: getSize(8.0),
                        ),
                        Text(
                          "Ho Chi Minh, Viet Nam",
                          style: AppStyles.black000Size16Fw500FfMont,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(46),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.grayTextField,
                  borderRadius: BorderRadius.circular(getSize(14)),
                ),
                padding: EdgeInsets.all(getSize(16)),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetHelper.icoHotelChoose),
                    SizedBox(
                      width: getSize(16),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Room and Guest",
                          style: AppStyles.black000Size12Fw400FfMont,
                        ),
                        SizedBox(
                          height: getSize(8.0),
                        ),
                        Text(
                          "2 Guest, 1 Room",
                          style: AppStyles.black000Size16Fw500FfMont,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(46),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.grayTextField,
                  borderRadius: BorderRadius.circular(getSize(14)),
                ),
                padding: EdgeInsets.all(getSize(16)),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetHelper.icoCalender),
                    SizedBox(
                      width: getSize(16),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Date",
                          style: AppStyles.black000Size12Fw400FfMont,
                        ),
                        SizedBox(
                          height: getSize(8.0),
                        ),
                        Text(
                          "13 Jul - 22 Jul 2023",
                          style: AppStyles.black000Size16Fw500FfMont,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(46),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: getSize(48),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(16)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: ColorConstants.primaryButton,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.HOTEL);
                    },
                    child: const Text(
                      "Search",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(46),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: getSize(48),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(16)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: ColorConstants.btnCanCel,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.LOADING_IMAGE);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
