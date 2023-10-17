import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/constants/assets_helper.dart';
import '../../shared/utils/size_utils.dart';
import '../auth/user_controller.dart';
import '../home/widgets/home_header.dart';
import '../profile/profile_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

final ProfileController controller = Get.find();

class _SettingScreenState extends State<SettingScreen> {
  final UserController userController = Get.find();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(getSize(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                size: size,
              ),
              SizedBox(
                height: getSize(32),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.PROFILE),
                child: ProfileWidget(userController: userController),
              ),
              SizedBox(
                height: getSize(32),
              ),
              Text(
                "App Setting",
                style: AppStyles.black000Size14Fw400FfMont,
              ),
              SizedBox(
                height: getSize(12),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoBooking,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Your account information",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoRoom,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notifications & Chat",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Chat and notifications settings",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoUser,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Private & Permissions",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Contact, My album and Black contact",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoUser,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password & Account",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Manager your Account settings",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(32),
              ),
              Text(
                "More",
                style: AppStyles.black000Size14Fw400FfMont,
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoBooking,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Help",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Data preferences and storage settings",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoRoom,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feedback",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Chat and notifications settings",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoUser,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "About",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "App Travel Booking FLutter",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(32),
              ),
              Text(
                "More",
                style: AppStyles.black000Size14Fw400FfMont,
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoBooking,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Help",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Data preferences and storage settings",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(16),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.secondBackground,
                  borderRadius: BorderRadius.circular(getSize(12)),
                ),
                padding: EdgeInsets.all(getSize(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: getSize(28),
                      height: getSize(28),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(getSize(4)),
                      child: Image.asset(
                        AssetHelper.icoRoom,
                        color: ColorConstants.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feedback",
                            style: AppStyles.black000Size14Fw400FfMont,
                          ),
                          SizedBox(
                            height: getSize(4),
                          ),
                          Text(
                            "Chat and notifications settings",
                            style: AppStyles.botTitle000Size12Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(32),
              ),
              ListTile(
                onTap: () => appController.toggleDarkMode(),
                leading: SvgPicture.asset(
                    'assets/images/x3/ic_dark_mode_profile.svg'),
                title: const Text(
                  'Dark mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Obx(
                  () => Switch(
                    value: appController.isDarkModeOn.value,
                    activeTrackColor: appController.isDarkModeOn.value
                        ? Colors.white
                        : Colors.blueGrey,
                    activeColor: appController.isDarkModeOn.value
                        ? Colors.white
                        : Colors.lightBlue,
                    onChanged: (value) {
                      appController.toggleDarkMode();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
