import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/search/search_tour.dart';
import 'package:doan_clean_achitec/models/search/type_service_search.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
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
  final getAllTourSearchTamp = Rxn<List<TourModel>>([]);
  final getAllTourSearchScreen = Rxn<List<TourModel>>([]);
  final getAllTourSearchRoot = Rxn<List<TourModel>>([]);

  final getAllListImageTour = Rxn<List<String>>([]);
  final getAllListImageTourScreen = Rxn<List<String>>([]);
  final getListHistorySearch = Rxn<List<String>>([]);
  final getListHistoryCurrentTour = Rxn<List<TourModel>>([]);
  final getListHistoryCurrentDes = Rxn<List<CityModel>>([]);
  final getListSearchTour = Rxn<List<SearchTour>>([]);
  final Rxn<List<TypeSearch>> getListSearchTourChoose =
      Rxn<List<TypeSearch>>([]);
  final includeAllSearch = Rxn<String>();
  final dateSelected = RxnString();

  @override
  void onInit() {
    super.onInit();
    getAllCityModelData();
    createTypeService();
    getAllTourSearchData('');
    getAllSearch();
    getHistoryCurrentDestination();
    getHistoryCurrentTour();
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

  final Rxn<List<TypeServiceSearch>> listTypeSearchService =
      Rxn<List<TypeServiceSearch>>([]);

  void createTypeService() {
    listTypeSearchService.value = [
      TypeServiceSearch(
        isCheck: false,
        typeNub: 0,
        valueType: 'Places to visit and sightsee',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 1,
        valueType: 'Historical sites',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 2,
        valueType: 'Sports events',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 3,
        valueType: 'Sports event',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 4,
        valueType: 'Entertainment',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 5,
        valueType: 'Adventure activities & extreme sports',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 6,
        valueType: 'Farm tourism',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 7,
        valueType: 'Underwater activities',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 8,
        valueType: 'Cultural experience',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 9,
        valueType: 'Half day tour/Day tour',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 10,
        valueType: 'Multi-day tour',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 11,
        valueType: 'Retaurant',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 12,
        valueType: 'Desserts & drinks',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 13,
        valueType: 'Hotel',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 14,
        valueType: 'Travel equipment & related services',
      ),
    ];
  }

  RxList<TypeServiceSearch> typeServicePlay = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 0,
      valueType: 'Places to visit and sightsee',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 1,
      valueType: 'Historical sites',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 2,
      valueType: 'Sports events',
    ),
  ].obs;

  RxList<TypeServiceSearch> typeServiceEvent = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 3,
      valueType: 'Sports event',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 4,
      valueType: 'Entertainment',
    ),
  ].obs;

  RxList<TypeServiceSearch> typeServiceAct = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 5,
      valueType: 'Adventure activities & extreme sports',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 6,
      valueType: 'Farm tourism',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 7,
      valueType: 'Underwater activities',
    ),
  ].obs;

  RxList<TypeServiceSearch> typeServiceCultural = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 8,
      valueType: 'Cultural experience',
    ),
  ].obs;

  RxList<TypeServiceSearch> typeServiceTravel = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 9,
      valueType: 'Half day tour/Day tour',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 10,
      valueType: 'Multi-day tour',
    ),
  ].obs;

  RxList<TypeServiceSearch> typeServiceFood = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 11,
      valueType: 'Retaurant',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 12,
      valueType: 'Desserts & drinks',
    ),
  ].obs;

  RxList<TypeServiceSearch> typeServiceHotel = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 13,
      valueType: 'Hotel',
    ),
  ].obs;

  RxList<TypeServiceSearch> typeServiceOther = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 14,
      valueType: 'Travel equipment & related services',
    ),
  ].obs;

  RxList<TypeServiceSearch> date = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 14,
      valueType: 'Travel equipment & related services',
    ),
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

  // Type Tour Search
  void getTourSearchType() async {
    getAllTourSearch.value = await getTypeServiceFillSearch();
  }

  Future<List<TourModel>> getTypeServiceFillSearch() async {
    List<TourModel> filteredTours = [];

    if (getAllTourSearchTamp.value != null &&
        getAllTourSearchTamp.value!.isNotEmpty) {
      filteredTours = getAllTourSearchTamp.value!.where((tour) {
        return listTypeSearchService.value!.any(
          (term) => tour.type == term.typeNub && term.isCheck,
        );
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

    for (var e in listTypeSearchService.value!) {
      e.isCheck = false;
    }
    return filteredTours;
  }

  void setTypeServiceChip(double numbType) {
    final Rxn<List<TypeServiceSearch>> tampListType =
        Rxn<List<TypeServiceSearch>>([]);
    tampListType.value = listTypeSearchService.value;
    for (var item in listTypeSearchService.value!) {
      if (item.typeNub == numbType) {
        if (item.isCheck) {
          item.isCheck = false;
        } else {
          item.isCheck = true;
        }
      }
    }
    update();
  }

  RxBool isCheckChooseType(double numbType) {
    for (var item in listTypeSearchService.value!) {
      if (item.typeNub == numbType && item.isCheck) {
        return true.obs;
      }
    }
    return false.obs;
  }

  // Date Search
  void getDateSearch(DateTime startDate, DateTime endDate) async {
    getAllTourSearch.value = await getDateFillSearch(startDate, endDate);
  }

  Future<List<TourModel>> getDateFillSearch(
      DateTime startDate, DateTime endDate) async {
    List<TourModel> filteredTours = [];

    if (getAllTourSearch.value != null && getAllTourSearch.value!.isNotEmpty) {
      filteredTours = getAllTourSearch.value!.where((tour) {
        DateTime? tourStartDate = tour.startDate?.toDate();
        DateTime? tourEndDate = tour.endDate?.toDate();

        if (tourStartDate != null && tourEndDate != null) {
          return (tourStartDate.isBefore(startDate) ||
                  tourStartDate.isAtSameMomentAs(startDate)) &&
              (tourEndDate.isAfter(endDate) ||
                  tourEndDate.isAtSameMomentAs(endDate));
        }

        return false;
      }).toList();
    }

    return filteredTours;
  }

  // Destination Search
  String getResult() {
    String result = '';
    if (getListSearchTourChoose.value != null &&
        getListSearchTourChoose.value!.isNotEmpty) {
      List<TypeSearch> newList = List.from(getListSearchTourChoose.value!);

      for (var item in newList) {
        if (result.isEmpty) {
          result = item.valueType;
        }
        result = "$result/${item.valueType}";
      }
    }

    result += "/${searchTourEditingController.text}";
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
        List<String> searchTerms = des.toLowerCase().split('/');

        return searchTerms.any((term) => tourName.contains(term));
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
    getAllTourSearchTamp.value = [];
    getAllTourSearchTamp.value = filteredTours;
    return filteredTours;
  }

  // history search string
  void setHistorySearch(String value) {
    LocalStorageHelper.setListHistorySearch(value);
  }

  void getHistorySearch() async {
    getListHistorySearch.value = [];
    getListHistorySearch.value =
        await LocalStorageHelper.getListHistorySearch();
  }

  void clearHistorySearch() {
    getListHistorySearch.value = [];
    LocalStorageHelper.clearListHistorySearch();
  }

  // history current tour
  Future<void> setHistoryCurrentTour(TourModel tourModel) async {
    LocalStorageHelper.setListHistoryCurrentTour(tourModel);
  }

  Future<void> getHistoryCurrentTour() async {
    getListHistoryCurrentTour.value = [];
    getListHistoryCurrentTour.value =
        await LocalStorageHelper.getListHistoryCurrentTour();
  }

  // history current des
  Future<void> setHistoryCurrentDestination(CityModel cityModel) async {
    LocalStorageHelper.setListHistoryCurrentDes(cityModel);
  }

  Future<void> getHistoryCurrentDestination() async {
    getListHistoryCurrentDes.value = [];
    getListHistoryCurrentDes.value =
        await LocalStorageHelper.getListHistoryCurrentDes();
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
