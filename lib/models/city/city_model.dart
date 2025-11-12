import 'package:cloud_firestore/cloud_firestore.dart';

class CityModel {
  final String? id;
  final String? idCity;
  final String nameCity;
  final String? descriptionCity;
  final String? imageCity;
  final String? idCountry;
  final List<String>? listArt;
  bool? isFavourite;

  CityModel({
    this.id,
    this.idCity,
    required this.nameCity,
    this.descriptionCity,
    this.imageCity,
    this.idCountry,
    this.listArt,
    this.isFavourite,
  });

  factory CityModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return CityModel(
      id: document.id,
      idCity: json['idCity'],
      nameCity: json['nameCity'],
      descriptionCity: json['descriptionCity'],
      imageCity: _parseImageCity(json['imageCity']),
      idCountry: json['idCountry'],
      listArt: _parseListArt(json['listArt']),
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  factory CityModel.fromJsonSearch(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      idCity: json['idCity'],
      nameCity: json['nameCity'],
      descriptionCity: json['descriptionCity'],
      imageCity: _parseImageCity(json['imageCity']),
      idCountry: json['idCountry'],
      listArt: _parseListArt(json['listArt']),
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  static String? _parseImageCity(dynamic imageCity) {
    if (imageCity is String) {
      return imageCity;
    }
    return null;
  }

  static List<String>? _parseListArt(dynamic listArt) {
    if (listArt is List) {
      return listArt.map((item) => item.toString()).toList().cast<String>();
    }
    return null;
  }

  toJson() {
    return {
      'id': id,
      'idCity': idCity,
      'nameCity': nameCity,
      'descriptionCity': descriptionCity,
      'imageCity': imageCity,
      'idCountry': idCountry,
      'listArt': listArt,
      'isFavourite': isFavourite,
    };
  }
}
