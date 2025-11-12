import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialOfferCard extends StatelessWidget {
  SpecialOfferCard({
    super.key,
    required this.tourModel,
  });

  final TourModel tourModel;

  final SearchDesController searchDesController =
      Get.put(SearchDesController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getSize(20)),
      child: GestureDetector(
        onTap: () async {
          if (tourModel.active) {
            await searchDesController.setHistoryCurrentTour(tourModel);
            await searchDesController.getHistoryCurrentTour();
            Get.toNamed(
              Routes.TOUR_DETAILS,
              arguments: tourModel,
            );
          } else {
            Get.snackbar(
              StringConst.notification.tr,
              "${StringConst.theTourIsOnHold.tr}!",
            );
          }
        },
        child: SizedBox(
          width: getSize(242),
          height: getSize(160),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                tourModel.images != null && tourModel.images!.isNotEmpty
                    ? CachedNetworkImage(
                        width: getSize(242),
                        height: getSize(160),
                        fit: BoxFit.cover,
                        imageUrl: tourModel.images?.first ?? "",
                      )
                    : Image.asset(
                        width: getSize(242),
                        height: getSize(160),
                        AssetHelper.imgPrevHotel01,
                        fit: BoxFit.cover,
                      ),
                Container(
                  width: getSize(242),
                  height: getSize(160),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF343434).withOpacity(0.4),
                        const Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(15.0),
                    vertical: getSize(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tourModel.nameTour,
                        style: TextStyle(
                            fontSize: getSize(18),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: getSize(4),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tourModel.rating}",
                            style: const TextStyle(color: ColorConstants.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: getSize(4),
                          ),
                          const StarWidget(),
                        ],
                      )
                    ],
                  ),
                ),
                tourModel.active
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(getSize(8)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.white.withOpacity(.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(getSize(8)),
                            child: Text(
                              StringConst.comingSoon.tr,
                              style: AppStyles.blue000Size14Fw500FfMont,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
