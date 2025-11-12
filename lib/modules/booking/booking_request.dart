import 'package:get/get.dart';

class BookingRequestController extends GetxController {
  final adultNumb = Rxn<double>(0);
  final childrenNumb = Rxn<double>(0);
  final adultPrice = Rxn<double>(0);
  final childrenPrice = Rxn<double>(0);
  final totalPrice = Rxn<double>(0);
  final isCheckQR = RxBool(true);
  final isCheckBanking = RxBool(false);
  final isVisaCard = RxBool(false);
  final paymentMothod = RxnString("qrcode");

  @override
  void onInit() {
    adultNumb.value = 0;
    childrenNumb.value = 0;
    totalPrice.value = 0;
    super.onInit();
  }

  void setStatusQRcode() {
    isCheckQR.value = true;
    isCheckBanking.value = false;
    isVisaCard.value = false;
    paymentMothod.value = "qrcode";
  }

  void setStatusBanking() {
    isCheckQR.value = false;
    isCheckBanking.value = true;
    isVisaCard.value = false;
    paymentMothod.value = "banking";
  }

  void setStatusVisaCard() {
    isCheckQR.value = false;
    isCheckBanking.value = false;
    isVisaCard.value = true;
    paymentMothod.value = "visacard";
  }

  double setPlus(double plus) {
    return plus += 1;
  }

  double setMinus(double minus) {
    if (minus <= 0) return 0;
    return minus -= 1;
  }

  void setPrice(double priceTour) {
    adultPrice.value = priceTour;
    childrenPrice.value = priceTour * 80 / 100;
  }

  void calcuPrice() {
    totalPrice.value = adultPrice.value! * adultNumb.value! +
        childrenPrice.value! * childrenNumb.value!;
  }
}
