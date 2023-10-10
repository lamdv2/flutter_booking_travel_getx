import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final nameTourController = TextEditingController();
  final descriptionController = TextEditingController();
  final idCityController = TextEditingController();
  final startDateController = TextEditingController();
  late final endDateController = TextEditingController();
  final priceController = TextEditingController();
  final imagesController = TextEditingController();
  final durationController = TextEditingController();
  final accommodationController = TextEditingController();
  final itineraryController = TextEditingController();
  final includedServicesController = TextEditingController();
  final excludedServicesController = TextEditingController();
  final reviewsController = TextEditingController();
  final ratingController = TextEditingController();
  final activeController = TextEditingController();
  final statusController = TextEditingController();
  final specialOffersController = TextEditingController();

  RxString selectedValue = '50HCM'.obs;
  final getListTour = Rxn<List<TourModel>>();

  Future<void> createTour(TourModel tourModel) async {
    await FirebaseFirestore.instance
        .collection('tourModel')
        .add(tourModel.toJson())
        .whenComplete(
      () {
        Get.snackbar(
          "Success",
          "New tour added!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorConstants.blue.withOpacity(.1),
          colorText: ColorConstants.blue,
        );
        clearController();
      },
    ).catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.red.withOpacity(.1),
        colorText: ColorConstants.red,
      );
    });
  }

  String timestampToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  void clearController() {
    nameTourController.clear();
    descriptionController.clear();
    idCityController.clear();
    startDateController.clear();
    endDateController.clear();
    priceController.clear();
    imagesController.clear();
    durationController.clear();
    accommodationController.clear();
    itineraryController.clear();
    includedServicesController.clear();
    excludedServicesController.clear();
    reviewsController.clear();
    ratingController.clear();
    activeController.clear();
    statusController.clear();
    specialOffersController.clear();
  }

  // Refresh Tour List

  Future<void> refreshTourList() async {
    getAllTourModelData();
  }

  // Get All Tour

  Future<void> getAllTourModelData() async {
    final snapShot = await _db.collection('tourModel').get();
    final listTourData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    getListTour.value = listTourData;
  }

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

  // Delete Tour By Id

  Future<void> deleteTourById(String idTour) async {
    try {
      await _db.collection('tourModel').doc(idTour).delete();
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  // format datetime

  Timestamp formatDateTime(String startDateText) {
    DateTime startDate;

    try {
      final inputFormat = DateFormat('dd MMM yyyy');
      startDate = inputFormat.parse(startDateText);
    } catch (e) {
      startDate = DateTime.now();
    }
    return Timestamp.fromDate(startDate);
  }
}
