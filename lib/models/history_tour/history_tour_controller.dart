import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

class HistoryTourController extends GetxController {
  final _db = FirebaseFirestore.instance;

  HomeController homeController = Get.find();

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

  @override
  void onInit() {
    super.onInit();
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
