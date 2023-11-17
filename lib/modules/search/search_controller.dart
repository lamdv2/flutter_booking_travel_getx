import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/search/search_tour.dart';
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
  final getAllTourSearchScreen = Rxn<List<TourModel>>([]);
  final getAllTourSearchRoot = Rxn<List<TourModel>>([]);

  final getAllListImageTour = Rxn<List<String>>([]);
  final getAllListImageTourScreen = Rxn<List<String>>([]);
  final getListHistorySearch = Rxn<List<String>>([]);
  final getListSearchTour = Rxn<List<SearchTour>>([]);
  final Rxn<List<TypeSearch>> getListSearchTourChoose =
      Rxn<List<TypeSearch>>([]);
  final includeAllSearch = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    getAllCityModelData();
    getAllTourSearchData('');
    getAllSearch();
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

  RxList<String> historySearchList = [
    'Đà Nẵng',
    'Hà nội',
    'tour đà lạt',
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

  void setDestination(String value) {
    if (getListSearchTourChoose.value != null &&
        getListSearchTourChoose.value!.isNotEmpty) {
      List<TypeSearch> newList = List.from(getListSearchTourChoose.value!);

      for (var item in newList) {
        if (item.valueType == value && item.isCheck) {
          getListSearchTourChoose.value?.removeWhere(
            (item) => item.valueType == value && item.isCheck,
          );
        } else {
          getListSearchTourChoose.value?.add(
            TypeSearch(isCheck: true, valueType: value),
          );
        }
      }
    } else {
      getListSearchTourChoose.value?.add(
        TypeSearch(isCheck: true, valueType: value),
      );
    }
    getAllSearch();
    update();
  }

  bool isCheckChooseDes(String value) {
    if (getListSearchTourChoose.value != null &&
        getListSearchTourChoose.value!.isNotEmpty) {
      for (var item in getListSearchTourChoose.value!) {
        if (item.valueType == value && item.isCheck) {
          return true;
        }
      }
    }
    return false;
  }

  // Get All Search
  Future<void> getAllSearch() async {
    final snapShot = await _db.collection('searchTour').get();
    final searchTourData =
        snapShot.docs.map((doc) => SearchTour.fromJson(doc)).toList();

    searchTourData.sort((a, b) => (b.count ?? 0).compareTo(a.count ?? 0));

    if (searchTourData.isNotEmpty && searchTourData.length >= 8) {
      final top8SearchTour = searchTourData.take(8).toList();
      if (top8SearchTour.isNotEmpty) {
        getListSearchTour.value = top8SearchTour;
      }
    } else {
      getListSearchTour.value = searchTourData;
    }
  }

  void addSearchTour(String valueSearch) async {
    await updateSearchTour(valueSearch);
  }

  Future<void> updateSearchTour(String value) async {
    if (value.isNotEmpty) {
      CollectionReference searchTourCollection = _db.collection('searchTour');

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await searchTourCollection.doc(value).get()
              as DocumentSnapshot<Map<String, dynamic>>;

      if (documentSnapshot.exists) {
        int currentCount = documentSnapshot.data()!['count'] ?? 0;
        await searchTourCollection
            .doc(value)
            .update({'count': currentCount + 1});
      } else {
        await searchTourCollection.doc(value).set({'value': value, 'count': 1});
      }
    } else {}
  }

  void onFocusChange() {
    isCheckOnClickSearch.value = true;
  }

  void getTourSearch(String des) async {
    getAllTourSearch.value = await getAllTourFillSearch(des);
  }

  String getResult() {
    String result = '';
    if (getListSearchTourChoose.value != null &&
        getListSearchTourChoose.value!.isNotEmpty) {
      List<TypeSearch> newList = List.from(getListSearchTourChoose.value!);

      for (var item in newList) {
        result = "$result ${item.valueType}";
      }
    }
    return result;
  }

  void getTourSearchAll(String des) async {
    getAllTourSearchScreen.value = await getAllTourFillSearch(des);
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

    if (filteredTours.isNotEmpty) {
      getAllListImageTour.value = [];

      for (var item in filteredTours) {
        List<String>? images = item.images;

        if (images != null && images.isNotEmpty) {
          String imageTour = await getImageStorage(images.first);
          getAllListImageTour.value?.add(imageTour);
        }
      }
    }

    return filteredTours;
  }

  @override
  void dispose() {
    super.dispose();
    searchEditingController.dispose();
    focusNodeSearch.removeListener(onFocusChange);
    searchEditingController.removeListener(() {
      onFocusChange();
    });

    focusNodeSearch.dispose();
  }
}
