import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:get/get.dart';

class SearchTourController extends GetxController {
  final SearchDesController searchDesController = Get.find();
  final dataSearchArgument = Rxn<String>();

  @override
  void onInit() {
    searchDesController.searchEditingController.text =
        searchDesController.dataSearch.value ?? "";
    searchDesController.searchTourEditingController.text =
        searchDesController.dataSearch.value ?? "";
    searchDesController
        .getTourSearch(searchDesController.dataSearch.value ?? "");
    super.onInit();
  }
}
