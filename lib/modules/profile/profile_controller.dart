import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
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

  final scaffoldProfileKey = GlobalKey<ScaffoldState>();

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
        // ignore: body_might_complete_normally_catch_error
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

  Future<void> confirmLogoutDialog(
      BuildContext context, String title, Function() function) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: const Text("Do you want to logout?"),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                StringConst.cancel.tr,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: function,
              child: Text(
                StringConst.ok.tr,
              ),
            ),
          ],
        );
      },
    );
  }

  void openDrawer() {
    scaffoldProfileKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldProfileKey.currentState?.closeDrawer();
  }

  void signUserOut(BuildContext context) async {
    AppFocus.unFocus(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();

    confirmLogoutDialog(
      context,
      'Logout',
      () async {
        Get.back();

        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            Timer(const Duration(seconds: 1), () {
              Get.back();
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        try {
          await auth.signOut();

          await googleSignIn.signOut();

          userController.clearUserName();

          userController.userName.value = '';

          userController.userEmail.value = '';
        } catch (e) {
          wrongMessage("Logout failed: $e");
        }
      },
    );

    // showOkCancelAlertDialog(
    //   context: context,
    //   okLabel: 'OK',
    //   cancelLabel: 'Cancel',
    //   title: 'Do you want to log out?',
    //   defaultType: OkCancelAlertDefaultType.ok,
    //   onWillPop: () => Future.value(false),
    // );

    // confirmLogoutDialog(context, 'Logout', () async {
    //   try {
    //     // Đăng xuất khỏi Firebase Authentication
    //     await auth.signOut();

    //     // Đăng xuất khỏi Google Sign In
    //     await googleSignIn.signOut();

    //     userController.clearUserName();

    //     userController.userName.value = '';

    //     userController.userEmail.value = '';

    //     // ignore: use_build_context_synchronously
    //     Incorrect("Logout Success");
    //   } catch (e) {
    //     wrongMessage("Logout failed: $e");
    //   }
    // });
  }

  // ignore: non_constant_identifier_names
  void Incorrect(String text) {
    final context = Get.context;
    showDialog(
      context: context!,
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

  Future<void> wrongMessage(String message) async {
    await Future.delayed(const Duration(seconds: 2));

    await Future.microtask(
      () {
        final context = Get.context;
        showDialog(
          context: context!,
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
      },
    );
  }
}
