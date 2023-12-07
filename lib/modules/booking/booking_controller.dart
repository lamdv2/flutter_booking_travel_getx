import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/modules/history_tour/history_tour.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  RxString selectedValue = '50HCM'.obs;

  String convertToDDMM(String inputDate) {
    final parts = inputDate.split('-');
    if (parts.length == 3) {
      final month = parts[1];
      final day = parts[2];
      return '$day/$month';
    }
    return inputDate;
  }

  Future<void> bookingTour(String userId, String tourId, Timestamp bookingDate,
      String status, double adult, double children, double totalPrice) async {
    if (userId.isEmpty || tourId.isEmpty) {
      Get.snackbar(StringConst.error, 'Booking fail !!!');
    } else {
      await _db.collection('historyModel').add({
        'idUser': userId,
        'idTour': tourId,
        'isActive': true,
        'bookingDate': bookingDate,
        'status': status,
        'adult': adult,
        'children': children,
        'totalPrice': totalPrice,
      });
      Get.snackbar(StringConst.success.tr, StringConst.bookingSuccessfully.tr);

      await historyTourController.getAllTourModelData();
    }
  }

  // format datetime
  Timestamp formatDateTime(String startDateText) {
    DateTime startDate;

    try {
      final inputFormat = DateFormat('dd MMM yyyy');
      startDate = inputFormat.parse(startDateText);
    } catch (e) {
      startDate = DateTime.now();
    }
    return Timestamp.fromDate(startDate);
  }
}
