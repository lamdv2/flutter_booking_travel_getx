import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/home/widgets/ListDestination.dart';
import 'package:doan_clean_achitec/modules/home/widgets/carousel_slide.dart';
import 'package:doan_clean_achitec/modules/home/widgets/category_bar.dart';
import 'package:doan_clean_achitec/modules/home/widgets/home_header.dart';
import 'package:doan_clean_achitec/modules/home/widgets/title_des.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final HomeController homecontroller = Get.find();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            HomeHeader(
              size: size,
              avatar: true,
            ),
            const CategoryBar(),
            CarouselSliderDes(size: size),
            SizedBox(
              height: getSize(32),
            ),
            TitleDes(
              largeTitle: 'Popular Destinations',
              seeAll: 'See All',
              onTap: () {
                homecontroller.currentIndex.value = 2;
              },
            ),
            ListDestination(size: size),
          ],
        ),
      ),
    );
  }
}
