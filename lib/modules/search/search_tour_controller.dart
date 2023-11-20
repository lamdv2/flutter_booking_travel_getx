import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:get/get.dart';

class SearchTourController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final SearchDesController searchDesController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }
}
