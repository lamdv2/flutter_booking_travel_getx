import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/dimension_constants.dart';
import 'package:doan_clean_achitec/shared/constants/image_helper.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/button_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/item_utility_detail_hotel_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/dash_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/google_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TourDetailsScreen extends StatelessWidget {
  const TourDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    final TourController tourController = Get.find();

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: ImageHelper.loadFromAsset(AssetHelper.hotel_3,
                boxFit: BoxFit.fill),
          ),
          Positioned(
            top: getSize(kMediumPadding * 2),
            left: getSize(kPadding),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: getSize(36),
                width: getSize(36),
                padding: EdgeInsets.all(getSize(kItemPadding)),
                decoration: const BoxDecoration(
                  color: ColorConstants.white,
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
          Positioned(
            top: kMediumPadding * 2,
            right: kPadding,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(getSize(kItemPadding)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(kDefaultPadding)),
                ),
                child: const Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            maxChildSize: 0.85,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: getSize(kMediumPadding)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 2),
                    topRight: Radius.circular(kDefaultPadding * 2),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: kDefaultPadding),
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                              Radius.circular(kDefaultPadding)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(kDefaultPadding),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Mường Thanh",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$${123}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.botTitle,
                                    ),
                                  ),
                                  Text(
                                    '/night',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getSize(kDefaultPadding),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetHelper.icoDestination,
                                width: getSize(
                                  kPadding,
                                ),
                              ),
                              SizedBox(
                                width: getSize(kItemPadding),
                              ),
                              const Text(
                                "34 Hải Châu, Đà Nẵng",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getSize(kTopPadding),
                          ),
                          const DashLineWidget(),
                          SizedBox(
                            height: getSize(kTopPadding),
                          ),
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                AssetHelper.icoStar,
                                width: getSize(
                                  kTop32Padding,
                                ),
                                boxFit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: getSize(
                                  kTopPadding,
                                ),
                              ),
                              const Text(
                                '${4.5}/5 ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '(${123456} review)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueGrey.shade500,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.primaryButton),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getSize(kItemPadding),
                          ),
                          const DashLineWidget(),
                          SizedBox(
                            height: getSize(32),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tourController.detailsHotelList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   selectedIndex = index;
                                    // });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    decoration: selectedIndex == index
                                        ? const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Gradients.lightBlue1,
                                                Gradients.lightBlue2,
                                              ],
                                            ),
                                            borderRadius: kDefaultBorderRadius,
                                          )
                                        : BoxDecoration(
                                            color: ColorConstants.transparent,
                                            borderRadius: kDefaultBorderRadius,
                                          ),
                                    child: Text(
                                      tourController.detailsHotelList[index]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: selectedIndex == index
                                            ? ColorConstants.white
                                            : ColorConstants.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: getSize(kMediumPadding),
                          ),
                          const Text(
                            'Information',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: getSize(kDefaultPadding),
                          ),
                          const Text(
                            'You will find every comfort because many of the '
                            'services that the hotel offers for travellers and of'
                            'course the hotel is very comfortable.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: getSize(kDefaultPadding),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ItemUtilityDetailHotelWidget(),
                          ),
                          SizedBox(
                            height: getSize(kPadding),
                          ),
                          const Text(
                            'Trip Plan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: getSize(kDefaultPadding),
                          ),
                          const Text(
                            'You will find every comfort because many of the '
                            'services that the hotel offers for travellers and of'
                            'course the hotel is very comfortable.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: getSize(kPadding),
                          ),
                          const Text(
                            'Photo Gallary',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 300,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                    bottom: 8,
                                  ),
                                  child: Image.asset(
                                    AssetHelper.city_1,
                                    fit: BoxFit.fitWidth,
                                    width: 50,
                                    height: 50,
                                  ),
                                );
                              },
                              itemCount: 6,
                            ),
                          ),
                          SizedBox(
                            height: getSize(kDefaultPadding),
                          ),
                          const Text(
                            'Location',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: getSize(kDefaultPadding),
                          ),
                          const Text(
                            'Located in the famous neighborhood of Seoul, '
                            'Grand Luxury’s is set in a building built in the'
                            '2010s.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: getSize(kDefaultPadding),
                          ),
                          Positioned(
                            child: GestureDetector(
                              onDoubleTap: () {
                                // Get.toNamed(page)
                              },
                              child: const GoogleMapWidget(),
                            ),
                          ),
                          SizedBox(
                            height: getSize(kMediumPadding),
                          ),
                          ButtonWidget(
                            textBtn: 'Select Room',
                            onTap: () {
                              // Get.toNamed(page)
                            },
                          ),
                          SizedBox(
                            height: getSize(kMediumPadding),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
