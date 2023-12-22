import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:doan_clean_achitec/shared/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'modules/lang/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  AppController darkMode = AppController();

  await darkMode.loadDarkMode();
  await LocalStorageHelper.initLocalStorageHelper();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle( 
    statusBarColor: ColorConstants.blue,
  ));

  Stripe.publishableKey =
      "pk_test_51OIMAyHdpKm7MB8qqvzh6yB053y1lg8vJlUhPZ05Omb93IrEljTl9pC4YAuay0jh1cvxfQfHAkWMnkiGhfB3l92Y00XANULzRX";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAHthPE5I3tqFM0IH27imDAQlsduedNNNs",
      appId: "1:997595921202:android:f72bbf84b5ebfe912fb52b",
      messagingSenderId: "997595921202",
      projectId: "doan-final-travel",
      storageBucket: "doan-final-travel.appspot.com",
    ),
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("onMessageOpenedApp: $event");
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    subscribeToBookingTopic();
    LocalStorageHelper.setString('fcmToken', fcmToken);
  } else {
    print('fcmToken is null');
  }
  final handler = NotificationHandler();
  handler.setListeners();

  runApp(MyApp());
}

void subscribeToBookingTopic() async {
  await FirebaseMessaging.instance.subscribeToTopic("topic");
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the message when the app is in the background
  print("onBackgroundMessage: $message");
  // Show a notification or perform other actions as needed
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppController controller = Get.put(AppController());
  final mainTheme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.bgrLight,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
  );

  final darkTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: Routes.SPLASH,
        defaultTransition: Transition.fade,
        getPages: AppPages.routes,
        smartManagement: SmartManagement.keepFactory,
        title: 'Flutter GetX Clean Travel',
        theme: controller.isDarkModeOn.value
            ? darkTheme.copyWith(brightness: Brightness.dark)
            : mainTheme.copyWith(brightness: Brightness.light),
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = hexToColor('#64DEE0')
    ..textColor = hexToColor('#64DEE0')
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
