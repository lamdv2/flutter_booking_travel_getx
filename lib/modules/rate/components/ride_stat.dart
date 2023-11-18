import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class TourStats extends StatelessWidget {
  const TourStats({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TourInfo(
          title: 'Duration:',
          value: '2 days',
        ),
        TourInfo(
          title: 'Price:',
          value: '\$299.99',
        ),
        TourInfo(
          title: 'Distance:',
          value: '150 km',
        ),
      ],
    );
  }
}

class TourInfo extends StatelessWidget {
  const TourInfo({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ColorConstants.kTextLightColor,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: ColorConstants.kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
