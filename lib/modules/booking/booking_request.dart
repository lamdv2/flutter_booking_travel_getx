import 'package:get/get.dart';

class BookingRequestController extends GetxController {
  final adultNumb = Rxn<double>(0);
  final childrenNumb = Rxn<double>(0);
  final adultPrice = Rxn<double>(0);
  final childrenPrice = Rxn<double>(0);
  final totalPrice = Rxn<double>(1);
  final isCheckQR = RxBool(false);
  final isCheckBanking = RxBool(false);

  @override
  void onInit() {
    adultNumb.value = 0;
    childrenNumb.value = 0;
    totalPrice.value = 1;
    super.onInit();
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
