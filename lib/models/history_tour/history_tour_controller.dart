import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/models/history_tour/tour_history_detail/preytty_qr_code.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rive/rive.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class HistoryTourController extends GetxController {
  final _db = FirebaseFirestore.instance;

  HomeController homeController = Get.find();
  GlobalKey<State> globalKey = GlobalKey<State>();

  final getAllListHistory = Rxn<List<TourModel>>([]);
  final getAllListHistoryToDate = Rxn<List<HistoryModel>>([]);

  Rx<bool> isShowLoading = true.obs;
  SMITrigger? check;
  SMITrigger? error;
  SMITrigger? reset;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  late QrImage qrImage;
  late PrettyQrDecoration decoration;

  @override
  void onInit() {
    super.onInit();
    // ignore: non_const_call_to_literal_constructor
    decoration = PrettyQrDecoration(
      // ignore: non_const_call_to_literal_constructor
      shape: PrettyQrSmoothSymbol(color: ColorConstants.green),
      // ignore: invalid_use_of_visible_for_testing_member
      image: PrettyQrSettings.kDefaultPrettyQrDecorationImage,
    );
    getAllTourModelData(homeController.userModel.value?.id ?? "");
  }

// Get All Tour

  Future<void> getAllTourModelData(String userId) async {
    getAllListHistory.value?.clear();
    getAllListHistory.value = await getTourHistory(userId);
  }

  Future<List<TourModel>?> getTourHistory(String userId) async {
    final snapShot = await _db
        .collection('historyModel')
        .where('idUser', isEqualTo: userId)
        .get();

    final listTourHistoryData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();
    getAllListHistoryToDate.value = listTourHistoryData;

    List<TourModel> listTourModel = [];

    if (listTourHistoryData.isNotEmpty) {
      for (var item in listTourHistoryData) {
        final snapShotTour =
            await _db.collection('tourModel').doc(item.idTour).get();

        if (snapShotTour.exists) {
          listTourModel.add(TourModel.fromJson(snapShotTour));
        } else {
          listTourModel = [];
        }
      }
    }

    return listTourModel;
  }

  Future<void> refreshHistory() async {
    getAllTourModelData(homeController.userModel.value?.id ?? "");
  }

  Future<void> captureAndSaveScreenshot(globalKey) async {
    Uint8List? screenshotData = await captureScreenshot(globalKey);
    if (screenshotData != null) {
      final result = await ImageGallerySaver.saveImage(screenshotData);

      if (result['isSuccess']) {
        Get.snackbar('Success!!!', 'Save Success!');
      } else {}
    }
  }

  Future<Uint8List?> captureScreenshot(globalKey) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List uint8list = byteData!.buffer.asUint8List();
      return uint8list;
    } catch (e) {
      // print("Error capturing screenshot: $e");
      return null;
    }
  }

  String timestampToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  void indicatorRive() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (getAllListHistory.value != null &&
            getAllListHistory.value!.isNotEmpty) {
          // check?.fire();
          Future.delayed(const Duration(seconds: 1), () {
            isShowLoading.value = false;
          });
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            // error?.fire();
            isShowLoading.value = false;
          });
        }
      },
    );
  }

  void loadIndicatorRive() {
    isShowLoading.value = true;
    indicatorRive();
  }
}
