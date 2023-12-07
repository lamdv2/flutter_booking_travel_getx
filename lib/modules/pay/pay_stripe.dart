import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/modules/pay/pay.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PayStripeScreen extends GetView<PayController> {
  PayStripeScreen({Key? key}) : super(key: key);

  Map<String, dynamic>? paymentIntent;

  final TourModel? tourModel = Get.arguments;

  final BookingRequestController bookingRequestController =
      Get.put(BookingRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        iconBgrColor: ColorConstants.white,
        titles: StringConst.payment.tr,
      ),
      body: Center(
        child: TextButton(
          child: const Text('Buy Now'),
          onPressed: () {
            controller.makePayment(
              bookingRequestController.totalPrice.value.toString(),
              tourModel!,
            );
          },
        ),
      ),
    );
  }
}
