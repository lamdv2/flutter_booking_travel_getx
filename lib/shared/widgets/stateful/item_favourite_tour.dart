// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

import '../../../models/city/city_model.dart';
import '../stateless/star_widget.dart';

class ItemFavouriteTour extends StatelessWidget {
  const ItemFavouriteTour({
    super.key,
    required this.tourModel,
    required this.heightSize,
  });

  final TourModel tourModel;
  final double heightSize;

  @override
  Widget build(BuildContext context) {
    bool isFavor = false;

    return Container(
      height: heightSize,
      margin: const EdgeInsets.only(
        top: 16,
      ),
      decoration: tourModel.images != null && tourModel.images!.isNotEmpty
          ? tourModel.images!.first.isNotEmpty
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetHelper.des1),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: kSmallBorderRadius,
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      tourModel.images!.first,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: kSmallBorderRadius,
                )
          : const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetHelper.des1),
                fit: BoxFit.cover,
              ),
              borderRadius: kSmallBorderRadius,
            ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 40, left: kItemPadding),
            child: Text(
              tourModel.nameTour,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(bottom: kTopPadding, left: kItemPadding),
            height: 24,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StarWidget(),
                Text(
                  "${tourModel.rating ?? 0}",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 46,
              height: 46,
              child: LikeButton(
                onTap: (isLiked) async {
                  // setState(() {
                  //   isFavor = !isFavor;
                  // });
                  return Future.value(!isLiked);
                },
                isLiked: isFavor,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                size: 40,
                circleColor: const CircleColor(
                    start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    FontAwesomeIcons.solidHeart,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 18,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
