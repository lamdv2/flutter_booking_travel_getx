import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/history/history_model.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  final _db = FirebaseFirestore.instance;

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

    final historyData =
        snapShot.docs.map((e) => HistoryModel.fromJson(e)).toList();
    getListHistoryByUserId.value = historyData;
  }
}
