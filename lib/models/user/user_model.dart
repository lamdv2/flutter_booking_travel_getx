import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String passWord;
  final String? imgAvatar;
  final String phoneNub;
  final bool isActive;

  UserModel({
    this.id,
    required this.email,
    this.firstName,
    this.lastName,
    required this.passWord,
    this.imgAvatar,
    required this.phoneNub,
    required this.isActive,
  });

  toJson() {
    return {
      'id' : id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'passWord': passWord,
      'imgAvatar': imgAvatar,
      'phoneNub': phoneNub,
      'isActive': isActive,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      passWord: data['passWord'],
      imgAvatar: data['imgAvatar'],
      phoneNub: data['phoneNub'],
      isActive: data['isActive'],
    );
  }
}
