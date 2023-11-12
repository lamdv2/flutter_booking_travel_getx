import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final double wid;
  final VoidCallback onPress;

  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    this.wid = 70,
    required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 30,
        width: wid,
        decoration: BoxDecoration(
            color: ColorConstants.buttonColor,
            borderRadius: BorderRadius.circular(3)),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: TextStyle(color: ColorConstants.whiteColor),
                  )),
      ),
    );
  }
}
