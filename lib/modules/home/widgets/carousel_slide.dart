import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../shared/constants/app_style.dart';
import '../../../shared/constants/assets_helper.dart';
import '../../../shared/constants/dimension_constants.dart';

class CarouselSliderDes extends StatelessWidget {
  CarouselSliderDes({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          initialPage: 0,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          viewportFraction: 0.7,
        ),
        items: homeController.listCitys.value.map((itemCity) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_PLACE, arguments: itemCity);
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: itemCity.imageCity!.isNotEmpty
                          ? BoxDecoration(
                              color: ColorConstants.lightBlueNon,
                              borderRadius: kBigBorderRadius,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  itemCity.imageCity ?? '',
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AssetHelper.des1),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: kSmallBorderRadius,
                            ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Gradients.darkGreyNon,
                            Gradients.darkGreyMid,
                            Gradients.darkGrey,
                          ],
                        ),
                        borderRadius: kBigBorderRadius,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: kTenPadding,
                                  bottom: kDefaultPadding,
                                ),
                                child: Text(
                                  itemCity.nameCity,
                                  style: AppStyles.white000Size18FfMont,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.only(
                              right: kMinPadding,
                              bottom: kTopPadding,
                            ),
                            child: LikeButton(
                              onTap: (isLiked) async {
                                // setState(() {
                                //   desList.isFavorite = !desList.isFavorite;
                                // });
                                return Future.value(!isLiked);
                              },
                              isLiked: false,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              size: 40,
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: isLiked ? Colors.red : Colors.white,
                                  size: 24,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
