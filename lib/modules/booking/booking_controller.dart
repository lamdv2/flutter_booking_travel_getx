import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/history_tour/history_tour.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final HistoryTourController historyTourController =
      Get.put(HistoryTourController());

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
    if (userId.isEmpty || tourId.isEmpty) {
      Get.snackbar('Error', 'Booking fail !!!');
    } else {
      await _db.collection('historyModel').add({
        'idUser': userId,
        'idTour': tourId,
        'isActive': true,
      });
      historyTourController.getAllTourModelData(userId);
    }
  }
}
