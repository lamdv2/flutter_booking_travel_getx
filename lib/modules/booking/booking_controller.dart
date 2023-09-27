import 'package:get/get.dart';

class BookingController extends GetxController {
  RxString selectedValue = '50HCM'.obs;

  String convertToDDMM(String inputDate) {
    final parts = inputDate.split('-');
    if (parts.length == 3) {
      final year = parts[0];
      final month = parts[1];
      final day = parts[2];
      return '$day/$month';
    }
    return inputDate; // Trả về nguyên bản nếu không thể chuyển đổi
  }
}
