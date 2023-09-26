import 'package:cloud_firestore/cloud_firestore.dart';

class TourModel {
  final String? idTour;
  final String nameTour;
  final String? description;
  final String? idCity;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? price;
  final List<String>? images;
  final String? duration;
  final String? accommodation;
  final List<String>? itinerary;
  final List<String>? includedServices;
  final List<String>? excludedServices;
  final List<String>? reviews;
  final double? rating;
  final bool active;
  final List<String>? specialOffers;

  TourModel({
    this.idTour,
    required this.nameTour,
    this.description,
    this.idCity,
    this.startDate,
    this.endDate,
    this.price,
    this.images,
    this.duration,
    this.accommodation,
    this.itinerary,
    this.includedServices,
    this.excludedServices,
    this.reviews,
    this.rating,
    required this.active,
    this.specialOffers,
  });

  factory TourModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return TourModel(
      idTour: document.id,
      nameTour: json['nameTour'],
      description: json['description'],
      idCity: json['idCity'],
      startDate: json['startDate'] != null
          ? (json['startDate'] as Timestamp).toDate()
          : null,
      endDate: json['endDate'] != null
          ? (json['endDate'] as Timestamp).toDate()
          : null,
      price: json['price']?.toDouble(),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      duration: json['duration'],
      accommodation: json['accommodation'],
      itinerary: json['itinerary'] != null
          ? List<String>.from(json['itinerary'])
          : null,
      includedServices: json['includedServices'] != null
          ? List<String>.from(json['includedServices'])
          : null,
      excludedServices: json['excludedServices'] != null
          ? List<String>.from(json['excludedServices'])
          : null,
      reviews:
          json['reviews'] != null ? List<String>.from(json['reviews']) : null,
      rating: json['rating']?.toDouble(),
      active: json['active'] ?? false,
      specialOffers: json['specialOffers'] != null
          ? List<String>.from(json['specialOffers'])
          : null,
    );
  }

  toJson() {
    return {
      'idTour': idTour,
      'nameTour': nameTour,
      'description': description,
      'idCity': idCity,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'price': price,
      'images': images,
      'duration': duration,
      'accommodation': accommodation,
      'itinerary': itinerary,
      'includedServices': includedServices,
      'excludedServices': excludedServices,
      'reviews': reviews,
      'rating': rating,
      'active': active,
      'specialOffers': specialOffers,
    };
  }
}
