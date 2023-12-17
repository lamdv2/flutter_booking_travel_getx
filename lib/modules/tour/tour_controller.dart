import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/image_full_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

class TourController extends GetxController {
  final _db = FirebaseFirestore.instance;

  List<String> detailsHotelList = ["Overview", "Itinerary", "Review & Rating"];

  RxBool isCheckSearch = false.obs;
  RxString idTour = ''.obs;
  final cityModel = Rxn<CityModel>();
  final getListTour = Rxn<List<TourModel>>();
  final getListTourTop10 = Rxn<List<TourModel>>();
  final getListTourTop10Sale = Rxn<List<TourModel>>();
  final filterListTourData = Rxn<List<TourModel>>();
  final cityList = Rxn<List<Map<String, String>>>();
  TextEditingController searchController = TextEditingController();
  final items = Rxn<List<String>>([]);

  final FocusNode focusSearchScreen = FocusNode();

  Rx<bool> isShowLoading = true.obs;
  SMITrigger? check;
  SMITrigger? error;
  SMITrigger? reset;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  void onInit() {
    super.onInit();
    getAllTourModelData();
    indicatorRive();
  }

  // Tour Details Call Firebase

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

  // Refresh Tour List

  Future<void> refreshTourList() async {
    getAllTourModelData();
    getAllCity();
  }

  // Edit Tour

  Future<void> updateTour(TourModel updatedTour) async {
    try {
      final tourRef = _db.collection('tourModel').doc(updatedTour.idTour);
      final tourData = updatedTour.toJson();
      await tourRef.update(tourData);
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  // Get All Tour

  Future<void> getAllTourModelData() async {
    final snapShot = await _db.collection('tourModel').get();
    final listTourData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    getListTour.value = listTourData;
    filterListTourData.value = listTourData;
    await getTop10Tour(listTourData);
    await getTop10TourSale(listTourData);
  }

  // Get Top 10 Tour By Star
  Future<void> getTop10Tour(List<TourModel> getListTour) async {
    if (getListTour.isNotEmpty) {
      getListTour.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
      getListTourTop10.value = [];
      if (getListTour.isNotEmpty && getListTour.length >= 8) {
        final top10Tour = getListTour.take(10).toList();
        if (top10Tour.isNotEmpty) {
          getListTourTop10.value = top10Tour;
        }
      } else {
        getListTourTop10.value = getListTour;
      }
    }
  }

  // Get Top 10 Tour Sale
  Future<void> getTop10TourSale(List<TourModel> getListTour) async {
    if (getListTour.isNotEmpty) {
      getListTour.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));

      final allSaleTours =
          getListTour.where((tour) => tour.status == "sale").toList();

      if (allSaleTours.length >= 10) {
        getListTourTop10Sale.value = allSaleTours.take(10).toList();
      } else {
        getListTourTop10Sale.value = allSaleTours;
      }
    }
  }

  Future<void> getAllCity() async {
    final snapShot = await _db.collection('cityModel').get();

    if (snapShot.docs.isNotEmpty) {
      final cityModelById =
          snapShot.docs.map((e) => CityModel.fromJson(e)).toList();

      cityList.value ??= [];
      cityList.value?.clear();

      for (var element in cityModelById) {
        Map<String, String> item = {'${element.idCity}': element.nameCity};
        cityList.value!.add(item);
      }
    }
  }

  Future<void> getAllCityModelData() async {
    final snapShot = await _db.collection('cityModel').get();
    final listCityData =
        snapShot.docs.map((doc) => CityModel.fromJson(doc)).toList();

    // listCitys.value = listCityData;
    // filterListCityData.value = listCityData;
  }

  // Location intent Map

  Future<void> launchMap(String address) async {
    final query = Uri.encodeComponent(address);
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> getImageStorage(String nameImage) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(nameImage);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return '';
    }
  }

  void showFullImageDialog(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullImageScreen(
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  // Filter List Tour

  // Filter get all
  void getAllTour() {
    getListTour.value = filterListTourData.value;
  }

  void loadCity() {
    if (homeController.listCitys.value.isNotEmpty) {
      items.value?.clear();
      for (var city in homeController.listCitys.value) {
        items.value?.add(city.nameCity);
      }
    }
  }

  Future<void> filterListTourByName(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
              (listTour) => _containsAllKeywords(listTour.nameTour, keyword))
          .toList();
    }
  }

  bool _containsAllKeywords(String tourName, String keyword) {
    List<String> searchTerms = keyword.toLowerCase().split(' ');

    return searchTerms.every((term) => tourName.toLowerCase().contains(term));
  }

  // Filter by State
  Future<void> filterListTourByState(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.status!.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  String formatTimeStampToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd/MM').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  String formatTimeStampEndToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  // Filter by Date

  Future<void> filterListTourByDateStart(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.startDate.toString().toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  // Filter by City
  Future<void> filterListTourByCity(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.idCity!.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  // Filter by Name City
  Future<void> filterListTourByNameCity(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.idCity!.toLowerCase().contains(
                  getIdCity(keyword).toLowerCase(),
                ),
          )
          .toList();
    }
  }

  String getIdCity(String nameCity) {
    if (homeController.listCitys.value.isNotEmpty) {
      for (var element in homeController.listCitys.value) {
        if (element.nameCity == nameCity) {
          return element.idCity ?? "";
        }
      }
    }
    return "";
  }

  String getNameCityById(String cityId) {
    if (cityList.value != null) {
      for (var cityMap in cityList.value!) {
        var key = cityMap.keys.first;

        if (key == cityId) {
          var value = cityMap.values.first;
          return value;
        }
      }
    }
    return '';
  }

  void indicatorRive() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (getListTour.value != null && getListTour.value!.isNotEmpty) {
          // check?.fire();
          Future.delayed(const Duration(seconds: 1), () {
            isShowLoading.value = false;
          });
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            // error?.fire();
            isShowLoading.value = false;
          });
        }
      },
    );
  }

  void loadIndicatorRive() {
    isShowLoading.value = true;
    indicatorRive();
  }
}
