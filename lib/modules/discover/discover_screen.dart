import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Scaffold(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
