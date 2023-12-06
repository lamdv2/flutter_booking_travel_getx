import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import '../../models/tour/tour_model.dart';

class DetailPlaceController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final getListTour = Rxn<List<TourModel>>();

  final WeatherFactory _weatherFactory = WeatherFactory(apiKeyWeather);
  late Weather _weather;
  final temperatureCelsius = RxnDouble();
  final windSpeed = RxnDouble();
  final humidity = RxnDouble();
  final pressure = RxnDouble();
  final cloudiness = RxnDouble();

  void fetchDataWeather(String nameCity) async {
    await _fetchWeatherData(nameCity);
  }

  Future<void> _fetchWeatherData(String nameCity) async {
    try {
      _weather = await _weatherFactory.currentWeatherByCityName(nameCity);
      getWeather();
    } catch (e) {
      print("Error fetching weather data: $e");
      Get.snackbar(StringConst.warning.tr, "$e");
    }
  }

  void getWeather() {
    if (_weather != null) {
      temperatureCelsius.value = _weather.temperature?.celsius ?? 0.0;
      windSpeed.value = _weather.windSpeed ?? 0.0;
      humidity.value = _weather.humidity ?? 0.0;
      pressure.value = _weather.pressure ?? 0.0;
      cloudiness.value = _weather.cloudiness ?? 0.0;
    }
  }

  Future<void> getAllTourModelData(String idCity) async {
    final snapShot = await _db
        .collection('tourModel')
        .where('idCity', isEqualTo: idCity)
        .get();
    final listTourData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    getListTour.value = listTourData;
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('E, d MMM yyyy');
    return formatter.format(dateTime);
  }
}
