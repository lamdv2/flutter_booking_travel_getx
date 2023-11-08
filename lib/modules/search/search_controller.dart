import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDesController extends GetxController {
  final _db = FirebaseFirestore.instance;

  Rx<List<CityModel>> listCitys = Rx([]);
  Rx<List<CityModel>> filterListCityData = Rx([]);
  TextEditingController searchEditingController = TextEditingController();
  FocusNode focusNodeSearch = FocusNode();
  RxBool isCheckOnClickSearch = false.obs;
  Rx<String> textStringSearch = 'abc'.obs;

  @override
  void onInit() {
    super.onInit();
    getAllCityModelData();
    focusNodeSearch.addListener(onFocusChange);
    searchEditingController.addListener(() {
      onFocusChange();
    });
  }

  List<String> chipList = [
    'tokyo',
    'bà nà',
    'hồ tuyền lâm',
    'dubai',
    'bali',
    'bangkok',
    'hawaii',
    'tháp busan',
  ];

  // Get All Citys

  Future<void> getAllCityModelData() async {
    final snapShot = await _db.collection('cityModel').get();
    final listCityData =
        snapShot.docs.map((doc) => CityModel.fromJson(doc)).toList();

    listCitys.value = listCityData;
    filterListCityData.value = listCityData;
  }

  void onFocusChange() {
    isCheckOnClickSearch.value = true;
  }

  @override
  void dispose() {
    super.dispose();
    searchEditingController.dispose();
    focusNodeSearch.removeListener(onFocusChange);
    focusNodeSearch.dispose();
  }
}
