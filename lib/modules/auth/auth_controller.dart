import 'dart:async';

import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/utils/focus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  late final Rx<User> firebaseUser;
  RxString veriticationId = ''.obs;

  void signInPhoneAuthentication(String phoneNub, UserModel userModel) {
    phoneAuthentication(phoneNub, userModel);
  }

  Future<void> phoneAuthentication(String phoneNub, UserModel userModel) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNub,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (String verificationId, int? resendToken) async {
        veriticationId.value = verificationId;
        Get.toNamed(Routes.OTP_SCREEN, arguments: userModel);
      },
      codeAutoRetrievalTimeout: (veriticationId) {
        this.veriticationId.value = veriticationId;
      },
      timeout: const Duration(seconds: 60),
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "The phone number invalid!");
        } else {
          // Get.snackbar("Error", "Something went wrong. Try again!");
          Get.snackbar("Error", "${e.code}. Try again!");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: veriticationId.value,
          smsCode: otp,
        ),
      );
      // ignore: unnecessary_null_comparison
      return credentials != null;
    } catch (error) {
      print("Error verifying OTP: $error");
      return false;
    }
  }

  void register(BuildContext context) async {
    AppFocus.unFocus(context);

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (registerPasswordController.text ==
          registerConfirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: registerEmailController.text,
            password: registerPasswordController.text);

        // ignore: use_build_context_synchronously
        Get.back(result: context);

        // ignore: use_build_context_synchronously
        Incorrect(context, "Register Success");
      } else {
        Get.back(result: context);

        wrongMessage(context, "password don't match!");
      }
    } on FirebaseAuthException catch (e) {
      Get.back(result: context);
      wrongMessage(context, "${e.code} register");
    }
  }

  void login(BuildContext context) async {
    AppFocus.unFocus(context);

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text);
      // ignore: use_build_context_synchronously
      Get.back(result: context);

      // ignore: use_build_context_synchronously
      Incorrect(context, "Login Success");
    } on FirebaseAuthException catch (e) {
      Get.back(result: context);

      wrongMessage(context, "${e.code} login");
    }
  }

  // ignore: non_constant_identifier_names
  void Incorrect(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      anchorPoint: const Offset(10, 10),
      builder: (context) {
        Timer(const Duration(seconds: 2), () {
          Get.back();
        });
        return Center(
          child: AlertDialog(
            title: Center(child: Text(text)),
          ),
        );
      },
    );
  }

  // error message show dialog
  void wrongMessage(BuildContext context, String message) {
    String errorMessage = message;
    if (message == "weak-password") {
      errorMessage = "The password is too weak";
    } else if (message == "email-already-in-use") {
      errorMessage = "The email address is already in use";
    } else if (message == "user-not-found") {
      errorMessage = "User not found. Please register.";
    } else if (message == "wrong-password") {
      errorMessage = "Invalid password. Please try again.";
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
  }
}
