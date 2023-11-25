import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/tour/tour_model.dart';

class DetailPlaceController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final getListTour = Rxn<List<TourModel>>();

  Future<void> getAllTourModelData(String idCity) async {
    final snapShot = await _db
        .collection('tourModel')
        .where('idCity', isEqualTo: idCity)
        .get();
    final listTourData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    getListTour.value = listTourData;
  }
}
