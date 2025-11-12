import 'dart:convert';

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/booking/booking_controller.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/constants/string_constants.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PayController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final TourModel? tourModel = Get.arguments;

    makePayment(
      bookingRequestController.totalPrice.value!.toInt().toString(),
      tourModel!,
    );
  }

  final BookingRequestController bookingRequestController =
      Get.put(BookingRequestController());

  final BookingController bookingController = Get.put(BookingController());
  final HomeController homeController = Get.find();

  Future<void> makePayment(String price, TourModel tourModel) async {
    try {
      await initPaymentSheet(price, tourModel);
    } catch (err) {
      Get.snackbar(
        StringConst.error.tr,
        "${StringConst.error.tr}!!!",
      );
    }
  }

  Future<void> initPaymentSheet(String price, TourModel tourModel) async {
    try {
      final data = await createPaymentIntent(price, 'vnd');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Prospects',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
          style: ThemeMode.dark,
        ),
      );

      await Stripe.instance.presentPaymentSheet().then(
        (value) async {
          await bookingController.bookingTour(
            homeController.userModel.value?.id ?? '',
            tourModel.idTour ?? '',
            bookingController.formatDateTime(DateTime.now().toString()),
            'waiting',
            bookingRequestController.adultNumb.value ?? 0,
            bookingRequestController.childrenNumb.value ?? 0,
            bookingRequestController.totalPrice.value ?? 0,
          );
          Get.offAndToNamed(Routes.HISTORY_TOUR_SCREEN);
        },
      );
    } catch (e) {
      Get.snackbar(
        StringConst.notification.tr,
        "${StringConst.error.tr}!!!",
      );
      rethrow;
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51OIMAyHdpKm7MB8qBrZGoxMpc6vV5DLsNr37XUCn0kAOgZ9S2UeEOFAvj0QjvyjWSEyZCCkjw1J39OtU11vnKnra00L0jED0P7',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
