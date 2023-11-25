import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/dimension_constants.dart';

// ignore: must_be_immutable
class TourSightSeeingWidget extends StatelessWidget {
  TourModel tourModel;

  TourSightSeeingWidget({
    required this.tourModel,
    super.key,
  });

  final TourController tourController = Get.put(TourController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getSize(280),
      width: getSize(200),
      decoration: tourModel.images!.isNotEmpty && tourModel.images != null
          ? BoxDecoration(
              color: ColorConstants.lightBlueNon,
              borderRadius: kMinBorderRadius,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  tourModel.images?.first ?? '',
                ),
              ),
            )
          : const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetHelper.des1),
                fit: BoxFit.cover,
              ),
              borderRadius: kMinBorderRadius,
            ),
      alignment: Alignment.bottomLeft,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(
              getSize(16),
            ),
            decoration: BoxDecoration(
              color: ColorConstants.titleSearch.withOpacity(.4),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  tourModel.nameTour,
                  style: AppStyles.white000Size13FfMont
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: getFontSize(8),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetHelper.icoMaps,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.btnCanCel,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: getFontSize(8),
                    ),
                    Text(
                      tourController.getNameCityById(tourModel.idCity ?? ""),
                      style: AppStyles.white000Size12Fw500FfMont,
                    ),
                  ],
                ),
                SizedBox(
                  height: getFontSize(8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'VND ${tourModel.price}',
                        style: AppStyles.white000Size12Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetHelper.icoStarSvg,
                          width: getSize(16),
                          colorFilter: const ColorFilter.mode(
                            ColorConstants.yellow,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: getFontSize(4),
                        ),
                        Text(
                          "${tourModel.rating ?? 0}",
                          style: AppStyles.white000Size13FfMont,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
