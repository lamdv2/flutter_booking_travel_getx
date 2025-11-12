import 'package:cloud_firestore/cloud_firestore.dart';

class SearchTour {
  final String? id;
  final String? value;
  final int? count;

  SearchTour({
    this.id,
    this.value,
    this.count,
  });

  factory SearchTour.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return SearchTour(
      id: document.id,
      value: json['value'] ?? '',
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'count': count,
    };
  }
}
