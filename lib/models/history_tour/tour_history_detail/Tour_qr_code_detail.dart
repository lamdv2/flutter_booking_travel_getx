import 'package:doan_clean_achitec/models/history_tour/history_tour_controller.dart';
import 'package:doan_clean_achitec/models/history_tour/tour_history_detail/button.dart';
import 'package:doan_clean_achitec/models/history_tour/tour_history_detail/preytty_qr_code.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TourQRCodeDetail extends StatelessWidget {
  final GlobalKey<State> globalKey = GlobalKey<State>();
  final HistoryTourController historyTourController =
      Get.put(HistoryTourController());
  final TourModel? tourModel = Get.arguments;
  TourQRCodeDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final double length = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorConstants.gray600,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          tourModel?.nameTour ?? '',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          tourModel?.nameTour ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrettyQrAnimatedView(
                          qrImage: QrImage(
                            QrCode.fromData(
                              data: tourModel?.nameTour ?? '',
                              errorCorrectLevel: QrErrorCorrectLevel.H,
                            ),
                          ),
                          decoration: historyTourController.decoration,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            RoundButton(
              title: "Take ScreenShot",
              wid: length,
              onPress: () {
                historyTourController.captureAndSaveScreenshot(globalKey);
              },
            ),
          ],
        ),
      ),
    );
  }
}
