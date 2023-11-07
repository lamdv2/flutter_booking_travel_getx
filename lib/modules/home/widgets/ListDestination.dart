import 'package:flutter/material.dart';

import '../../../shared/utils/size_utils.dart';
import '../../../shared/widgets/stateful/DestinationItem.dart';

class ListDestination extends StatefulWidget {
  const ListDestination({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ListDestination> createState() => _ListDestinationState();
}

class _ListDestinationState extends State<ListDestination> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 1,
          child: Column(
            children: [
              DestinationItem(
                heightSize: 220,
                textDes: 'Korea',
              ),
              DestinationItem(
                heightSize: 220,
                textDes: 'Japan',
              ),
              DestinationItem(
                heightSize: 140,
                textDes: 'Turkey',
              ),
              DestinationItem(
                heightSize: 220,
                textDes: 'China',
              ),
              DestinationItem(
                heightSize: 220,
                textDes: 'Thailand',
              ),
            ],
          ),
        ),
        SizedBox(
          width: getSize(16),
        ),
        const Expanded(
          flex: 1,
          child: Column(
            children: [
              DestinationItem(
                heightSize: 140,
                textDes: 'VietNam',
              ),
              DestinationItem(
                heightSize: 220,
                textDes: 'Chicago',
              ),
              DestinationItem(
                heightSize: 140,
                textDes: 'Sydney',
              ),
              DestinationItem(
                heightSize: 140,
                textDes: 'Hawaii',
              ),
              DestinationItem(
                heightSize: 220,
                textDes: 'Bangkok',
              ),
              DestinationItem(
                heightSize: 140,
                textDes: 'Dubai',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
