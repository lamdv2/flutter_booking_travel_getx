import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getSize(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getSize(242),
          height: getSize(160),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                image != ""
                    ? CachedNetworkImage(
                        width: getSize(242),
                        height: getSize(160),
                        fit: BoxFit.cover,
                        imageUrl: image,
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
                        category,
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
                      Text(
                        "$numOfBrands Tours",
                        style: const TextStyle(color: ColorConstants.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
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
