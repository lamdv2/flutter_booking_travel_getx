import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/modules/history_tour/tour_history_detail/preytty_qr_code.dart';
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

  final getAllListHistory = Rxn<List<TourModel>>([]);
  final getListHisWaiting = Rxn<List<TourModel>>([]);
  final getListUpComing = Rxn<List<TourModel>>([]);
  final getListHisHappenning = Rxn<List<TourModel>>([]);
  final getListHisCompleted = Rxn<List<TourModel>>([]);
  final getListHisCancel = Rxn<List<TourModel>>([]);

  final getAllListHistoryToDate = Rxn<List<HistoryModel>>([]);
  final getListHisWaitingToDate = Rxn<List<HistoryModel>>([]);
  final getListHisUpComingToDate = Rxn<List<HistoryModel>>([]);
  final getListHisHappenningToDate = Rxn<List<HistoryModel>>([]);
  final getListHisCompletedToDate = Rxn<List<HistoryModel>>([]);
  final getListHisCancelToDate = Rxn<List<HistoryModel>>([]);

  final listTourCurrentTabs = Rxn<List<TourModel>>([]);
  final listTourCurrentTabsToDate = Rxn<List<HistoryModel>>([]);

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
    getAllTourModelData();
  }

// Get All Tour

  Future<void> getAllTourModelData() async {
    String userId = homeController.userModel.value?.id ?? "";

    getAllListHistory.value?.clear();
    getListHisWaiting.value?.clear();
    getListUpComing.value?.clear();
    getListHisHappenning.value?.clear();
    getListHisCompleted.value?.clear();
    getListHisCancel.value?.clear();

    getAllListHistory.value = await getTourHistory(userId);
    getListHisWaiting.value = await getTourHistoryByStatus(userId, 'waiting');
    await getTourHistoryByStatus(userId, 'done');
    getListHisCancel.value = await getTourHistoryByStatus(userId, 'canceled');
  }

  Future<List<TourModel>?> getTourHistory(String userId) async {
    final snapShot = await _db
        .collection('historyModel')
        .where('idUser', isEqualTo: userId)
        .get();

    final listTourHistoryData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();
    getAllListHistoryToDate.value?.clear();
    getAllListHistoryToDate.value = listTourHistoryData;

    List<TourModel> listTourModel = [];

    if (listTourHistoryData.isNotEmpty) {
      for (int i = 0; i < listTourHistoryData.length; i++) {
        final snapShotTour = await _db
            .collection('tourModel')
            .doc(listTourHistoryData[i].idTour)
            .get();

        if (snapShotTour.exists) {
          listTourModel.add(TourModel.fromJson(snapShotTour));
        } else {
          listTourModel = [];
        }
      }
    }

    return listTourModel;
  }

  Future<HistoryModel> getHistoryByIdTour(String idTour) async {
    final snapShot = await _db
        .collection('historyModel')
        .where('idUser', isEqualTo: homeController.userModel.value?.id ?? "")
        .where('idTour', isEqualTo: idTour)
        .get();

    if (snapShot.docs.length == 1) {
      final historyModelByIdTour = HistoryModel.fromJson(snapShot.docs.single);
      return historyModelByIdTour;
    } else {
      return HistoryModel.fromJson(snapShot.docs.first);
    }
  }

  Future<List<TourModel>?> getTourHistoryByStatus(
      String userId, String status) async {
    final snapShot = await _db
        .collection('historyModel')
        .where('idUser', isEqualTo: userId)
        .where('status', isEqualTo: status)
        .get();

    final listTourHistoryData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();

    List<TourModel> listTourModel = [];
    List<TourModel> listTourModelTamp = [];

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

    if (status == 'waiting') {
      getListHisWaitingToDate.value?.clear();
      getListHisWaitingToDate.value = listTourHistoryData;
    } else if (status == 'done') {
      getListHisUpComingToDate.value = [];
      getListHisHappenningToDate.value = [];
      getListHisCompletedToDate.value = [];
      final now = Timestamp.now();

      listTourModelTamp = [];
      for (int i = 0; i < listTourModel.length; i++) {
        if (listTourModel[i].startDate!.millisecondsSinceEpoch >
            now.millisecondsSinceEpoch) {
          getListHisUpComingToDate.value?.add(listTourHistoryData[i]);
          getListUpComing.value?.add(listTourModel[i]);
        } else if (listTourModel[i].startDate!.millisecondsSinceEpoch <=
                now.millisecondsSinceEpoch &&
            listTourModel[i].endDate!.millisecondsSinceEpoch >=
                now.millisecondsSinceEpoch) {
          getListHisHappenningToDate.value?.add(listTourHistoryData[i]);
          getListHisHappenning.value?.add(listTourModel[i]);
        } else if (listTourModel[i].startDate!.millisecondsSinceEpoch <
            now.millisecondsSinceEpoch) {
          getListHisCompletedToDate.value?.add(listTourHistoryData[i]);
          getListHisCompleted.value?.add(listTourModel[i]);
        }
      }
    } else if (status == 'canceled') {
      getListHisCancelToDate.value?.clear();
      getListHisCancelToDate.value = listTourHistoryData;
    }

    return listTourModel;
  }

  Future<void> refreshHistory() async {
    getAllTourModelData();
  }

  Future<void> captureAndSaveScreenshot(globalKey) async {
    Uint8List? screenshotData = await captureScreenshot(globalKey);
    if (screenshotData != null) {
      final result = await ImageGallerySaver.saveImage(screenshotData);

      if (result['isSuccess']) {
        Get.snackbar('Success!!!', 'Save Success!');
      } else {
        Get.snackbar('Success!!!', 'fails!');
      }
    }
  }

  saveLocalImage(globalKey) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
        await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      try {
        final result =
            await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        if (result != null &&
            result.containsKey('isSuccess') &&
            result['isSuccess'] == true) {
          Get.snackbar('Success!!!', 'Save Success!');
        } else {
          Get.snackbar('Error', 'Save Failed: ${result['errorMessage']}');
        }
      } catch (e) {
        Get.snackbar('Error', 'Save Failed: $e');
      }
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

  Future<void> updateUserProfile(HistoryModel historyModel) async {
    await _db
        .collection('historyModel')
        .doc(historyModel.id)
        .update(historyModel.toJson())
        .then((value) {
      Get.snackbar("Success!", 'You canceled tour successfully',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.black87);
      Future.wait([
        getAllTourModelData(),
      ]);
    }).catchError((onError) {
      Get.snackbar("Error!!!", 'Cancel tour error: ${onError.toString()}',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.black87);
    });
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

  String timestampToStringStart(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd-MM').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  String timestampToStringEnd(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  void getCurrentHisTab(String status) {
    if (status == 'waiting') {
      listTourCurrentTabs.value?.clear();
      listTourCurrentTabs.value?.addAll(getListHisWaiting.value ?? []);
      listTourCurrentTabsToDate.value?.clear();
      listTourCurrentTabsToDate.value
          ?.addAll(getListHisWaitingToDate.value ?? []);
    } else if (status == 'coming') {
      listTourCurrentTabs.value?.clear();
      listTourCurrentTabs.value?.addAll(getListUpComing.value ?? []);
      listTourCurrentTabsToDate.value?.clear();
      listTourCurrentTabsToDate.value
          ?.addAll(getListHisUpComingToDate.value ?? []);
    } else if (status == 'happenning') {
      listTourCurrentTabs.value?.clear();
      listTourCurrentTabs.value?.addAll(getListHisHappenning.value ?? []);
      listTourCurrentTabsToDate.value?.clear();
      listTourCurrentTabsToDate.value
          ?.addAll(getListHisHappenningToDate.value ?? []);
    } else if (status == 'completed') {
      listTourCurrentTabs.value?.clear();
      listTourCurrentTabs.value?.addAll(getListHisCompleted.value ?? []);
      listTourCurrentTabsToDate.value?.clear();
      listTourCurrentTabsToDate.value
          ?.addAll(getListHisCompletedToDate.value ?? []);
    } else if (status == 'canceled') {
      listTourCurrentTabs.value?.clear();
      listTourCurrentTabs.value?.addAll(getListHisCancel.value ?? []);
      listTourCurrentTabsToDate.value?.clear();
      listTourCurrentTabsToDate.value
          ?.addAll(getListHisCancelToDate.value ?? []);
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

  void clearData() {
    getAllListHistory.value = [];
    getListHisWaiting.value = [];
    getListUpComing.value = [];
    getListHisHappenning.value = [];
    getListHisCompleted.value = [];
    getListHisCancel.value = [];

    getAllListHistoryToDate.value = [];
    getListHisWaitingToDate.value = [];
    getListHisUpComingToDate.value = [];
    getListHisHappenningToDate.value = [];
    getListHisCompletedToDate.value = [];
    getListHisCancelToDate.value = [];

    listTourCurrentTabs.value = [];
    listTourCurrentTabsToDate.value = [];
  }
}
