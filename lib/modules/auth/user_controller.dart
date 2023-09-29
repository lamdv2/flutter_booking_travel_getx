import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _db = FirebaseFirestore.instance;

  RxString userName = ''.obs;
  RxString userEmail = ''.obs;

  final userModel = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    initializeUser();
    getUserDetails(userEmail.value);
  }

  void initializeUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email;
      if (email != null && email.isNotEmpty) {
        userName.value = email.substring(0, 5);
        userEmail.value = email;
      }
    }
  }

  getUserData() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      return getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Login to continue !!!');
    }
  }

  Future<void> getUserDetails(String email) async {
    final snapShot = await _db
        .collection('userModel')
        .where('email', isEqualTo: email)
        .get();
    userModel.value =
        snapShot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  }

  Future<List<UserModel>> getAllUserModel() async {
    final snapShot = await _db.collection('userModel').get();
    final listUserData =
        snapShot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return listUserData;
  }

  Future<void> updateUserProfile(UserModel userModel) async {
    User? user = FirebaseAuth.instance.currentUser;
    String emailUser;
    if (user != null) {
      emailUser = user.email.toString();
    }
    await _db
        .collection('userModel')
        .doc('oAibVkNzeItirv6Vtirz')
        .update(userModel.toJson())
        .then((value) {
      Get.snackbar("Edit!!!", 'Success',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.black87);
    }).catchError((onError) {
      Get.snackbar("Edit!!!", 'Error: ${onError.toString()}',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.black87);
    });
  }

  void clearUserName() {
    userName.value = '';
    userEmail.value = '';
  }
}
