import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/focus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth/user_controller.dart';

class ProfileController extends GetxController {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passWordController = TextEditingController();
  final imageAvatarController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final editEmailController = TextEditingController();
  final editPhoneNumberController = TextEditingController();
  final editLocationController = TextEditingController();

  final UserController userController = Get.put(UserController());

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void clearController() {
    emailController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    passWordController.text = '';
    imageAvatarController.text = '';
    phoneNumberController.text = '';
  }

  createUser(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('userModel')
        .add(userModel.toJson())
        .whenComplete(
          () => Get.snackbar(
            "Success",
            "Your account have been created!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorConstants.blue.withOpacity(.1),
            colorText: ColorConstants.blue,
          ),
        )
        .catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.red.withOpacity(.1),
        colorText: ColorConstants.red,
      );
    });
  }

  Future<bool> isCheckExist(String email) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('userModel')
        .where('email', isEqualTo: email)
        .get();
    if (snapShot.docs.isNotEmpty) {
      return true;
    }

    return false;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }

  void signUserOut(BuildContext context) async {
    AppFocus.unFocus(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        Timer(const Duration(seconds: 2), () {
          Get.back();
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Đăng xuất khỏi Firebase Authentication
      await auth.signOut();

      // Đăng xuất khỏi Google Sign In
      await googleSignIn.signOut();

      userController.clearUserName();

      // ignore: use_build_context_synchronously
      Incorrect(context, "Logout Success");
    } catch (e) {
      wrongMessage(context, "Logout failed: $e");
    }
  }

  // ignore: non_constant_identifier_names
  void Incorrect(BuildContext context, String text) {
    showDialog(
      context: context,
      anchorPoint: const Offset(10, 10),
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Center(child: Text(text)),
          ),
        );
      },
    );
  }

  Future<void> wrongMessage(BuildContext context, String message) async {
    await Future.delayed(const Duration(seconds: 2));

    if (context != null && Navigator.canPop(context)) {
      await Future.microtask(() {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Text(
                message,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      });
    }
  }
}
