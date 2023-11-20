import 'package:doan_clean_achitec/modules/booking/booking_option/booking_option_controller.dart';
import 'package:get/get.dart';

class BookingOptionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BookingOptionController>(BookingOptionController());
  }
}
