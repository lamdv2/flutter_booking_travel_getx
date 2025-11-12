import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingOptionController extends GetxController {
  final firstNameConfirmController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final HomeController homeController = Get.find();

  @override
  void onInit() {
    firstNameConfirmController.text =
        homeController.userModel.value?.firstName ?? "";
    lastNameController.text = homeController.userModel.value?.lastName ?? "";
    emailController.text = homeController.userModel.value?.email ?? "";
    phoneNumberController.text = homeController.userModel.value?.phoneNub ?? "";
    super.onInit();
  }

  String formatTimeStampToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (phoneNumber.startsWith('0')) {
      phoneNumber = '+84${phoneNumber.substring(1)}';
    } else {
      phoneNumber = '+84$phoneNumber';
    }

    return phoneNumber;
  }
}
