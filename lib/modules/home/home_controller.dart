import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/city/city_model.dart';
import '../../models/history/history_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.wait([getUserDetails(userController.userEmail.value)]);
    getAllCityModelData();
  }

  RxInt currentIndex = 0.obs;
  final _db = FirebaseFirestore.instance;
  final userModel = Rxn<UserModel>();

  final UserController userController = Get.find();

  final getAllListHistory = Rxn<List<HistoryModel>>();
  final getListHistoryByUserId = Rxn<List<HistoryModel>>();
  final scaffoldHomeKey = GlobalKey<ScaffoldState>();

  Rx<List<CityModel>> listCitys = Rx([]);
  Rx<List<CityModel>> filterListCityData = Rx([]);

  Future<void> getUserDetails(String email) async {
    final snapShot = await _db
        .collection('userModel')
        .where('email', isEqualTo: email)
        .get();

    if (snapShot.docs.isNotEmpty) {
      userModel.value =
          snapShot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    }
  }

  getUserData() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      return getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Login to continue !!!');
    }
  }

  // Get All Citys

  Future<void> getAllCityModelData() async {
    final snapShot = await _db.collection('cityModel').get();
    final listCityData =
        snapShot.docs.map((doc) => CityModel.fromJson(doc)).toList();

    listCitys.value = listCityData;
    filterListCityData.value = listCityData;
  }

  void openDrawer() {
    scaffoldHomeKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldHomeKey.currentState?.closeDrawer();
  }
}
