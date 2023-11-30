import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  LocalStorageHelper._internal();
  static final LocalStorageHelper _shared = LocalStorageHelper._internal();

  factory LocalStorageHelper() {
    return _shared;
  }

  late SharedPreferences _preferences;

  static Future<void> initLocalStorageHelper() async {
    _shared._preferences = await SharedPreferences.getInstance();
  }

  static dynamic getValue(String key) {
    return _shared._preferences.get(key);
  }

  static Future<void> setValue(String key, dynamic value) async {
    if (value is int) {
      await _shared._preferences.setInt(key, value);
    } else if (value is double) {
      await _shared._preferences.setDouble(key, value);
    } else if (value is bool) {
      await _shared._preferences.setBool(key, value);
    } else if (value is String) {
      await _shared._preferences.setString(key, value);
    } else if (value is List<String>) {
      await _shared._preferences.setStringList(key, value);
    }
  }

  static Future<void> setString(String key, String value) async {
    await _shared._preferences.setString(key, value);
  }

  static void getBoolNotification(){
    LocalStorageHelper.getValue('isNotificationOn');
  }

  // history search string
  static Future<void> setListHistorySearch(String value) async {
    Set<String> setHistorySearch =
        _shared._preferences.getStringList("setListHistorySearch")?.toSet() ??
            Set();
    setHistorySearch.add(value);
    _shared._preferences
        .setStringList("setListHistorySearch", setHistorySearch.toList());
  }

  static Future<List<String>> getListHistorySearch() async {
    List<String> listHistorySearch =
        _shared._preferences.getStringList("setListHistorySearch") ?? [];
    return listHistorySearch;
  }

  static Future<void> clearListHistorySearch() async {
    Set<String> setHistorySearch =
        _shared._preferences.getStringList("setListHistorySearch")?.toSet() ??
            Set();
    setHistorySearch.clear();
    _shared._preferences
        .setStringList("setListHistorySearch", setHistorySearch.toList());
  }

  // history current tour
  static Future<void> setListHistoryCurrentTour(TourModel tourModel) async {
    final listTourModel = await getListHistoryCurrentTour();

    final existingTourIndex = listTourModel
        .indexWhere((existingTour) => existingTour.idTour == tourModel.idTour);

    if (existingTourIndex != -1) {
      listTourModel.removeAt(existingTourIndex);
    }

    listTourModel.add(tourModel);

    final startIndex = max(0, listTourModel.length - 10);
    final limitedList = listTourModel.skip(startIndex).toList();

    final prefs = await SharedPreferences.getInstance();
    final listTourModelJson = limitedList.map((tourModel) {
      Map<String, dynamic> tourJson = tourModel.toJson();
      if (tourJson['timestamp'] is Timestamp) {
        tourJson['timestamp'] =
            (tourJson['timestamp'] as Timestamp).toDate().toIso8601String();
      }
      return tourJson;
    }).toList();

    await prefs.setString(
        'setListHistoryCurrentTour', json.encode(listTourModelJson));
  }

  static Future<List<TourModel>> getListHistoryCurrentTour() async {
    final prefs = await SharedPreferences.getInstance();
    final listTourModelJson = prefs.getString('setListHistoryCurrentTour');

    if (listTourModelJson != null) {
      final List<dynamic> decoded = json.decode(listTourModelJson);
      return decoded.map((json) => TourModel.fromJsonSearch(json)).toList();
    } else {
      return [];
    }
  }

  // clear sharedPrefences logout
  static Future<void> clearListHistoryCurrentTour() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('setListHistoryCurrentTour');
    await prefs.remove('setListHistoryCurrentDes');
  }

  // history current des
  static Future<void> setListHistoryCurrentDes(CityModel cityModel) async {
    final listCityModel = await getListHistoryCurrentDes();

    final existingCityIndex = listCityModel
        .indexWhere((existingCity) => existingCity.id == cityModel.id);

    if (existingCityIndex != -1) {
      listCityModel.removeAt(existingCityIndex);
    }

    listCityModel.add(cityModel);

    final startIndex = max(0, listCityModel.length - 10);
    final limitedList = listCityModel.skip(startIndex).toList();

    final prefs = await SharedPreferences.getInstance();
    final listCityModelJson = limitedList.map((cityModel) {
      Map<String, dynamic> cityJson = cityModel.toJson();
      return cityJson;
    }).toList();

    await prefs.setString(
        'setListHistoryCurrentDes', json.encode(listCityModelJson));
  }

  static Future<List<CityModel>> getListHistoryCurrentDes() async {
    final prefs = await SharedPreferences.getInstance();
    final listCityModelJson = prefs.getString('setListHistoryCurrentDes');

    if (listCityModelJson != null) {
      final List<dynamic> decoded = json.decode(listCityModelJson);
      return decoded.map((json) => CityModel.fromJsonSearch(json)).toList();
    } else {
      return [];
    }
  }
}
