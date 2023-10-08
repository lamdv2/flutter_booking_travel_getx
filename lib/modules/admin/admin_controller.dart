import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final nameTourController = TextEditingController();
  final descriptionController = TextEditingController();
  final idCityController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
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

  Future<void> createTour() async {
    await _db.collection('historyModel').add({
      'nameTour': 'userId',
      'description': 'tourId',
      'idCity': 'true',
      'startDate': 'true',
      'endDate': 'true',
      'price': 'true',
      'images': 'true',
      'duration': 'true',
      'accommodation': 'true',
      'itinerary': 'true',
      'includedServices': 'true',
      'excludedServices': 'true',
      'reviews': 'true',
      'rating': 'true',
      'active': true,
      'status': 'true',
      'specialOffers': 'true',
    });
  }

  Future<void> getCreateTourData(String userId) async {}

  Future<List<TourModel>?> getTourCreate(TourModel tourModel) async {
    // final snapShot = await _db
    //     .collection('tourModel')
    //     .add(tourModel);

    List<TourModel> listTourModel = [];

    return listTourModel;
  }

  createUser(TourModel tourModel) async {
    await FirebaseFirestore.instance
        .collection('userModel')
        .add(tourModel.toJson())
        .whenComplete(
          () => Get.snackbar(
            "Success",
            "Your account have been created!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorConstants.blue.withOpacity(.1),
            colorText: ColorConstants.blue,
          ),
        )
        .catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.red.withOpacity(.1),
        colorText: ColorConstants.red,
      );
    });
  }
}
