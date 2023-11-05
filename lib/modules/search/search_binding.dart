import 'package:doan_clean_achitec/modules/search/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<SearchDesController>(SearchDesController());
  }

}