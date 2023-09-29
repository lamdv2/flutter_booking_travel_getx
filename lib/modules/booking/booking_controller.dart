import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final _db = FirebaseFirestore.instance;

  RxString selectedValue = '50HCM'.obs;

  String convertToDDMM(String inputDate) {
    final parts = inputDate.split('-');
    if (parts.length == 3) {
      final year = parts[0];
      final month = parts[1];
      final day = parts[2];
      return '$day/$month';
    }
    return inputDate;
  }

  Future<void> bookingTour(String userId, String tourId) async {
    await _db.collection('historyModel').add({
      'idUser': userId,
      'idTour': tourId,
      'isActive': true,
    });
  }
}
