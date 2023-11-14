import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/search/type_search.dart';

class SearchDesController extends GetxController {
  final _db = FirebaseFirestore.instance;

  Rx<List<CityModel>> listCitys = Rx([]);
  Rx<List<CityModel>> filterListCityData = Rx([]);
  TextEditingController searchEditingController = TextEditingController();
  TextEditingController searchTourEditingController = TextEditingController();
  FocusNode focusNodeSearch = FocusNode();
  FocusNode focusNodeSearchTour = FocusNode();
  RxBool isCheckOnClickSearch = false.obs;
  Rx<String> textStringSearch = 'abc'.obs;
  final getAllTourSearch = Rxn<List<TourModel>>([]);
  final getAllTourSearchRoot = Rxn<List<TourModel>>([]);
  final getAllListImageTour = Rxn<List<String>>([]);

  @override
  void onInit() {
    super.onInit();
    getAllCityModelData();
    getAllTourSearchData('');
    focusNodeSearch.addListener(onFocusChange);
    searchEditingController.addListener(() {
      onFocusChange();
    });
  }

  RxList<String> chipList = [
    'tokyo',
    'bà nà',
    'hồ tuyền lâm',
    'dubai',
    'bali',
    'bangkok',
    'hawaii',
    'tháp busan',
  ].obs;

  List<String> destination = [
    'tokyo',
    'bà nà',
    'hồ tuyền lâm',
    'dubai',
    'bali',
    'bangkok',
    'hawaii',
    'tháp busan',
  ];

  RxList<TypeSearch> typeServicePlay = [
    TypeSearch(isCheck: false, valueType: 'Places to visit and sightsee'),
    TypeSearch(isCheck: false, valueType: 'Historical sites'),
    TypeSearch(isCheck: false, valueType: 'Sports events'),
  ].obs;

  RxList<TypeSearch> typeServiceEvent = [
    TypeSearch(isCheck: false, valueType: 'Sports event'),
    TypeSearch(isCheck: false, valueType: 'Entertainment'),
  ].obs;

  RxList<TypeSearch> typeServiceAct = [
    TypeSearch(
        isCheck: false, valueType: 'Adventure activities & extreme sports'),
    TypeSearch(isCheck: false, valueType: 'Farm tourism'),
    TypeSearch(isCheck: false, valueType: 'Underwater activities'),
  ].obs;

  RxList<TypeSearch> typeServiceCultural = [
    TypeSearch(isCheck: false, valueType: 'Cultural experience'),
  ].obs;

  RxList<TypeSearch> typeServiceTravel = [
    TypeSearch(isCheck: false, valueType: 'Half day tour/Day tour'),
    TypeSearch(isCheck: false, valueType: 'Multi-day tour'),
  ].obs;

  RxList<TypeSearch> typeServiceFood = [
    TypeSearch(isCheck: false, valueType: 'Retaurant'),
    TypeSearch(isCheck: false, valueType: 'Desserts & drinks'),
  ].obs;

  RxList<TypeSearch> typeServiceHotel = [
    TypeSearch(isCheck: false, valueType: 'Hotel'),
  ].obs;

  RxList<TypeSearch> typeServiceOther = [
    TypeSearch(
      isCheck: false,
      valueType: 'Thiết bị du lịch & các dịch vụ liên quan',
    ),
  ].obs;

  RxList<TypeSearch> date = [
    TypeSearch(isCheck: false, valueType: 'date'),
  ].obs;

  // Get All Tour Search

  Future<void> getAllTourSearchData(String des) async {
    final snapShot = await _db.collection('tourModel').get();
    final listTourSearchData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    if (listTourSearchData.isNotEmpty) {
      clearDataTourSearch();
      getAllTourSearchRoot.value = listTourSearchData;
      getAllTourSearch.value = listTourSearchData;

      List<String> listTamp = [];

      for (int i = 0; i < listTourSearchData.length; i++) {
        String imageTour = await getImageStorage(
          (listTourSearchData[i].images != null &&
                  listTourSearchData[i].images!.isNotEmpty)
              ? listTourSearchData[i].images!.first
              : '/assets/images/city_7.jpg',
        );

        listTamp.add(imageTour);
      }

      if (listTamp.isNotEmpty) {
        getAllListImageTour.value = [];
        getAllListImageTour.value = listTamp;
      }
    }
  }

  void clearDataTourSearch() {
    getAllTourSearchRoot.value = [];
    getAllTourSearch.value = [];
  }

  Future<String> getImageStorage(String nameImage) async {
    Reference ref = FirebaseStorage.instance.ref().child(nameImage);
    try {
      final result = await ref.getMetadata();

      // ignore: unnecessary_null_comparison
      if (result != null) {
        String downloadUrl = await ref.getDownloadURL();
        return downloadUrl;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  String timestampToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  String timestampToStringHour(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate =
          DateFormat('dd-MM-yyyy  HH:mm:ss').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
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

  void onFocusChange() {
    isCheckOnClickSearch.value = true;
  }

  void getTourSearch(String des) async {
    getAllTourSearch.value = await getAllTourFillSearch(des);
  }

  Future<List<TourModel>> getAllTourFillSearch(String des) async {
    List<TourModel> filteredTours = [];

    if (getAllTourSearchRoot.value != null &&
        getAllTourSearchRoot.value!.isNotEmpty) {
      filteredTours = getAllTourSearchRoot.value!.where((tour) {
        String tourName = tour.nameTour.toLowerCase();
        List<String> searchTerms = des.toLowerCase().split(' ');

        return searchTerms.every((term) => tourName.contains(term));
      }).toList();
    }

    return filteredTours;
  }

  @override
  void dispose() {
    super.dispose();
    searchEditingController.dispose();
    focusNodeSearch.removeListener(onFocusChange);
    focusNodeSearch.dispose();
  }
}
