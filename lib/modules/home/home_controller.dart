import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/ads/ad_helper.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../models/history/history_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
        print("Ad Failed to Load");
        ad.dispose();
      }, onAdLoaded: (ad) {
        print("Ad Loaded");
        isBannerAdLoaded.value = true;
      }),
      request: const AdRequest(),
    );
    bannerAd?.load();
    Future.wait([getUserDetails(userController.userEmail.value)]);
  }

  RxInt currentIndex = 0.obs;
  final _db = FirebaseFirestore.instance;
  final userModel = Rxn<UserModel>();

  final UserController userController = Get.find();

  final getAllListHistory = Rxn<List<HistoryModel>>();
  final getListHistoryByUserId = Rxn<List<HistoryModel>>();
  final scaffoldHomeKey = GlobalKey<ScaffoldState>();

  BannerAd? bannerAd;
  final RxBool isBannerAdLoaded = false.obs;
  NativeAd? nativeAd;
  final RxBool nativeAdIsLoaded = false.obs;

  @override
  void onReady() {
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          nativeAdIsLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
          backgroundColor: Colors.white70,
        ),
      ),
    )..load();
    super.onReady();
  }

  Future<void> getUserDetails(String email) async {
    final snapShot = await _db
        .collection('userModel')
        .where('email', isEqualTo: email)
        .get();

    if (snapShot.docs.isNotEmpty) {
      userModel.value =
          snapShot.docs.map((e) => UserModel.fromSnapshot(e)).single;
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

// Get All Tour

  Future<void> getAllTourModelData() async {
    final snapShot = await _db.collection('historyModel').get();
    final listTourData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();

    getAllListHistory.value = listTourData;
  }

  Future<void> getTourDetailsById(String userId) async {
    final snapShot = await _db
        .collection('historyModel')
        .where('idUser', isEqualTo: userId)
        .get();

    final historyData =
        snapShot.docs.map((e) => HistoryModel.fromJson(e)).toList();
    getListHistoryByUserId.value = historyData;
  }

  void openDrawer() {
    scaffoldHomeKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldHomeKey.currentState?.closeDrawer();
  }
}
