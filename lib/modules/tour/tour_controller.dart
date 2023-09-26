import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:get/get.dart';

class TourController extends GetxController {
  final _db = FirebaseFirestore.instance;

  List<String> detailsHotelList = ["Overview", "Itinerary", "Review & Rating"];

  RxBool isCheckSearch = false.obs;
  RxString idTour = ''.obs;
  RxList<TourModel> getListTour = RxList<TourModel>();
  final getListTourData = Rxn<List<TourModel>>();

  Future<TourModel> getTourDetailsById(String id) async {
    final snapShot = await _db.collection('tourModel').doc(id).get();

    if (snapShot.exists) {
      return TourModel.fromJson(snapShot);
    } else {
      throw Exception("Error: not exists!!!");
    }
  }

  Future<void> editTourDetailsById(TourModel updatedTour) async {
    try {
      await _db
          .collection('tourModel')
          .doc(updatedTour.idTour)
          .update(updatedTour.toJson());
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  Future<void> updateTour(TourModel updatedTour) async {
    try {
      final tourRef = _db.collection('tourModel').doc(updatedTour.idTour);
      final tourData = updatedTour.toJson();
      await tourRef.update(tourData);
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  Future<List<TourModel>> getAllTourModel() async {
    final snapShot = await _db.collection('tourModel').get();
    final listTourData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    getListTour.assignAll(listTourData);
    return listTourData;
  }

  void viewListTour() {
    getListTour.addAll(getAllTourModel() as Iterable<TourModel>);
  }
}
