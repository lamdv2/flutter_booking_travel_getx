import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/profile_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/item_setting_widget.dart';
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
                child: ProfileWidget(
                  userController: userController,
                ),
              ),
              SizedBox(
                height: getSize(32),
              ),
              Text(
                "App Setting",
                style: AppStyles.black000Size14Fw400FfMont.copyWith(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.black),
              ),
              SizedBox(
                height: getSize(12),
              ),
              ItemSettingWidget(
                  title: 'Personal Information',
                  description: 'Your account information',
                  image: AssetHelper.icProfile),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(
                  title: 'Notifications & Chat',
                  description: 'Chat and notifications settings',
                  image: AssetHelper.icNotification),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(
                  title: 'Private & Permissions',
                  description: 'Contact, My album and Black contact',
                  image: AssetHelper.icShieldDone),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(
                  title: 'Password & Account',
                  description: 'Manager your Account settings',
                  image: AssetHelper.icLock),
              SizedBox(
                height: getSize(32),
              ),
              Text(
                " Setting System",
                style: AppStyles.black000Size14Fw400FfMont.copyWith(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.black),
              ),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(
                  title: 'Change language', image: AssetHelper.icSetting),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(
                title: 'Dark mode',
                image: AssetHelper.icPassword,
                isSwitch: true,
              ),
              SizedBox(
                height: getSize(32),
              ),
              Text(
                "More",
                style: AppStyles.black000Size14Fw400FfMont.copyWith(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.black),
              ),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(title: 'Guide', image: AssetHelper.icDocument),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(
                  title: 'Feedback', image: AssetHelper.icEditSquare),
              SizedBox(
                height: getSize(16),
              ),
              ItemSettingWidget(
                  title: 'About', image: AssetHelper.icInfoSquare),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
