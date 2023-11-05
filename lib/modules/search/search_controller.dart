import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:get/get.dart';

class SearchDesController extends GetxController {
  final _db = FirebaseFirestore.instance;

  Rx<List<CityModel>> listCitys = Rx([]);
  Rx<List<CityModel>> filterListCityData = Rx([]);

  @override
  void onInit() {
    super.onInit();
    getAllCityModelData();
  }

  // Get All Citys

  Future<void> getAllCityModelData() async {
    final snapShot = await _db.collection('cityModel').get();
    final listCityData =
        snapShot.docs.map((doc) => CityModel.fromJson(doc)).toList();

    listCitys.value = listCityData;
    filterListCityData.value = listCityData;
  }
}
