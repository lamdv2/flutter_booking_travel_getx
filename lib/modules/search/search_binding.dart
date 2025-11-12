import 'package:doan_clean_achitec/modules/search/search_controller.dart';
import 'package:get/get.dart';

import 'search_tour_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchDesController());
    Get.lazyPut(() => SearchTourController());
  }
}
