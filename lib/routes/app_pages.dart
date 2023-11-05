import 'package:doan_clean_achitec/modules/booking/booking.dart';
import 'package:doan_clean_achitec/modules/booking/booking_requied.dart';
import 'package:doan_clean_achitec/modules/detail_place/detail_place.dart';
import 'package:doan_clean_achitec/modules/discover/discover.dart';
import 'package:doan_clean_achitec/modules/favorite/favorite_screen.dart';
import 'package:doan_clean_achitec/modules/google_map/google_map.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/hotel/hotel_all_screen.dart';
import 'package:doan_clean_achitec/modules/hotel/hotel_screen.dart';
import 'package:doan_clean_achitec/modules/hotel_detail/hotel_detail_binding.dart';
import 'package:doan_clean_achitec/modules/hotel_detail/hotel_detail_screen.dart';
import 'package:doan_clean_achitec/modules/intro/intro_binding.dart';
import 'package:doan_clean_achitec/modules/intro/intro_screen.dart';
import 'package:doan_clean_achitec/modules/otp/otp_binding.dart';
import 'package:doan_clean_achitec/modules/otp/otp_screen.dart';
import 'package:doan_clean_achitec/modules/pay/pay.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/modules/profile/profile.dart';
import 'package:doan_clean_achitec/modules/room/room.dart';
import 'package:doan_clean_achitec/modules/search/search.dart';
import 'package:doan_clean_achitec/modules/setting/setting_screen.dart';
import 'package:doan_clean_achitec/modules/splash/splash_binding.dart';
import 'package:doan_clean_achitec/modules/splash/splash_screen.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/utils/select_date.dart';
import 'package:get/get.dart';

import '../models/history_tour/history_tour_screen.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_login_screen.dart';
import '../modules/auth/auth_register_screen.dart';
import '../modules/auth/auth_screen.dart';
import '../modules/favorite/favorite_binding.dart';

part 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.INTRO,
      page: () => const IntroScreen(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(
          name: Routes.REGISTER,
          page: () => RegisterScreen(),
        ),
        GetPage(
          name: Routes.LOGIN,
          page: () => LoginScreen(),
        ),
      ],
    ),
    GetPage(
      name: Routes.DISCOVER,
      page: () => DiscoverScreen(),
      binding: DiscoverBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PLACE,
      page: () => DetailPlaceScreen(),
      binding: DetailPlaceBinding(),
    ),
    GetPage(
      name: Routes.HOTEL,
      page: () => const HotelScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_HOTEL,
      page: () => const HotelDetailScreen(),
      binding: HotelDetailBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE,
      page: () => FavoriteScreen(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingScreen(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.ROOM,
      page: () => RoomScreen(),
      binding: RoomBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_HOTEL,
      page: () => const HotelDetailScreen(),
      binding: HotelDetailBinding(),
    ),
    GetPage(
      name: Routes.HOTEL_ALL,
      page: () => const HotelAllScreen(),
    ),
    GetPage(
      name: Routes.TOUR,
      page: () => TourScreen(),
      binding: TourBinding(),
    ),
    GetPage(
      name: Routes.OTP_SCREEN,
      page: () => OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.TOUR_DETAILS,
      page: () => TourDetailsScreen(),
      binding: TourBinding(),
    ),
    GetPage(
      name: Routes.PAY_SCREEN,
      page: () => const PaymentScreen(),
      binding: PayBinding(),
    ),
    GetPage(
      name: Routes.BOOKING_REQUIED,
      page: () => BookingRequiedScreen(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: Routes.SELECT_DATE,
      page: () => SelectDateScreen(),
    ),
    GetPage(
      name: Routes.HISTORY_TOUR_SCREEN,
      page: () => HistoryScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.GOOGLE_MAP_SCREEN,
      page: () => const GoogleMapScreen(),
    ),
    GetPage(
      name: Routes.SEARCH_SCREEN,
      page: () => SearchScreen(),
      binding: SearchBinding(),
    ),
  ];
}
