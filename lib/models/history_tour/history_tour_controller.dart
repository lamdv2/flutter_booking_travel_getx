import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:get/get.dart';

class HistoryTourController extends GetxController {
  final _db = FirebaseFirestore.instance;

  UserController userController = Get.put(UserController());

  @override
  void onInit() {
    getTourDetailsById(userController.userModel.value?.id ?? "");
    super.onInit();
  }

  final getAllListHistory = Rxn<List<HistoryModel>>();
  final getListHistoryByUserId = Rxn<List<HistoryModel>>();

// Get All Tour

  Future<void> getAllTourModelData() async {
    final snapShot = await _db.collection('historyModel').get();
    final listTourData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();

    getAllListHistory.value = listTourData;
  }

  Future<void> getTourDetailsById(String userId) async {
    final snapShot = await _db
        .collection('historyModel')
        .where('idUser', isEqualTo: userId)
        .get();

    if (snapShot.docs.isNotEmpty) {
      final historyData =
          snapShot.docs.map((e) => HistoryModel.fromJson(e)).toList();
      getListHistoryByUserId.value = historyData;
    } else {
      getListHistoryByUserId.value = [];
      print("Không tìm thấy dữ liệu lịch sử cho userId: $userId");
    }
  }

  Future<void> refreshHistory() async {
    getTourDetailsById(userController.userModel.value?.id ?? "");
  }
}
