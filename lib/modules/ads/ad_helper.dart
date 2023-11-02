import 'dart:io';

import 'package:flutter/foundation.dart';

class AdHelper {
  static bool checkRemoveAds = false;

  // ADS Banner
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else {
        return 'ca-app-pub-6297423778563938/5866290992';
      }
    } else if (Platform.isIOS) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else {
        return 'ca-app-pub-6297423778563938/4908641970';
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // ADS Full
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/1033173712';
      } else {
        return 'ca-app-pub-6297423778563938/3048555968';
      }
    } else if (Platform.isIOS) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/4411468910';
      } else {
        return ' ca-app-pub-6297423778563938/1531669598';
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // ADS Reward
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/5224354917';
      } else {
        return 'ca-app-pub-6297423778563938/9101445537';
      }
    } else if (Platform.isIOS) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/1712485313';
      } else {
        return ' ca-app-pub-6297423778563938/2282478639';
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // ADS Native
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/2247696110';
      } else {
        return 'ca-app-pub-6297423778563938/7457191376';
      }
    } else if (Platform.isIOS) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/1712485313';
      } else {
        return 'ca-app-pub-6297423778563938/5843267934';
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // ADS Open App
  static String get openAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/3419835294';
      } else {
        return 'ca-app-pub-6297423778563938/4170065941';
      }
    } else if (Platform.isIOS) {
      if (kDebugMode) {
        return 'ca-app-pub-6297423778563938/4170065941';
      } else {
        return 'ca-app-pub-6297423778563938/1197445910';
      }
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
