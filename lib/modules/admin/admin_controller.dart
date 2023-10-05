import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
}
