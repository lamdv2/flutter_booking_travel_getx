import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.tap,
  });

  final Icon icon;
  final Color iconColor, bgColor;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        color: bgColor,
      ),
      child: IconButton(
        icon: icon,
        onPressed: tap,
        color: iconColor,
      ),
    );
  }
}
