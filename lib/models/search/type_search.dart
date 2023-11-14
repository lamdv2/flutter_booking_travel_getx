import 'package:cloud_firestore/cloud_firestore.dart';

class TypeSearch {
  final bool isCheck;
  final String valueType;

  TypeSearch({
    required this.isCheck,
    required this.valueType,
  });

  factory TypeSearch.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return TypeSearch(
      isCheck: json['isCheck'],
      valueType: json['valueType'],
    );
  }

  toJson() {
    return {
      'isCheck': isCheck,
      'valueType': valueType,
    };
  }
}
