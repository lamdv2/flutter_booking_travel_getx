import 'package:doan_clean_achitec/modules/history_tour/tour_history_detail/comment_controller.dart';
import 'package:get/get.dart';

import 'history_tour_controller.dart';

class HistoryTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryTourController>(HistoryTourController());
    Get.put<CommentTourController>(CommentTourController());
  }
}
