import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String? id;
  final String? idUser;
  final String? idTour;
  final bool isActive;

  HistoryModel({
    this.id,
    this.idUser,
    this.idTour,
    required this.isActive,
  });

  factory HistoryModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return HistoryModel(
      id: document.id,
      idUser: json['idUser'],
      idTour: json['idTour'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'idTour': idTour,
      'isActive': isActive,
    };
  }
}
