import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/history_tour/tour_history_detail/preytty_qr_code.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../shared/constants/assets_helper.dart';
import '../../shared/utils/size_utils.dart';
import '../../shared/widgets/user_profile_setting_groups.dart';
import '../../shared/widgets/user_profile_setting_item.dart';
import '../auth/user_controller.dart';
import '../home/widgets/home_header.dart';
import '../lang/language.dart';
import '../lang/translation_service.dart';
import '../profile/profile_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final UserController userController = Get.find();

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
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
                BuildSettingsGroup(
                  settingsGroupTitle: StringConst.appSetting.tr,
                  items: [
                    BuildSettingsItem(
                      onTap: () => Get.toNamed(Routes.PROFILE),
                      imageAsset: AssetHelper.icProfile,
                      widgetTitle: Text(
                        StringConst.personalInformation.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BuildSettingsItem(
                      imageAsset: AssetHelper.icNotification,
                      widgetTitle: Text(
                        StringConst.notificationAndChat.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BuildSettingsItem(
                      onTap: () => openAppSettings(),
                      imageAsset: AssetHelper.icShieldDone,
                      widgetTitle: Text(
                        StringConst.privateAndPermissions.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BuildSettingsItem(
                      onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD_SCREEN),
                      imageAsset: AssetHelper.icLock,
                      widgetTitle: Text(
                        StringConst.passwordAndAccount.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                BuildSettingsGroup(
                  settingsGroupTitle: StringConst.settingSystem.tr,
                  items: [
                    BuildSettingsItem(
                      imageAsset: AssetHelper.icSetting,
                      widgetTitle: Text(
                        StringConst.changeLanguage.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SizedBox(
                        width: getSize(36),
                        height: getSize(36),
                        child: Card(
                          color: ColorConstants.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          elevation: 3.0,
                          child: SpeedDial(
                            icon: Icons.language,
                            direction: SpeedDialDirection.up,
                            curve: Curves.bounceOut,
                            animatedIconTheme: const IconThemeData(size: 12.0),
                            backgroundColor: ColorConstants.primaryButton,
                            foregroundColor: ColorConstants.white,
                            children: _buildLanguageOptions(),
                          ),
                        ),
                      ),
                    ),
                    BuildSettingsItem(
                      imageAsset: AssetHelper.icDarkMode,
                      widgetTitle: Text(
                        StringConst.darkMode.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
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
                BuildSettingsGroup(
                  settingsGroupTitle: StringConst.more.tr,
                  items: [
                    BuildSettingsItem(
                      imageAsset: AssetHelper.icDocument,
                      widgetTitle: Text(
                        StringConst.guide.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BuildSettingsItem(
                      onTap: () => Get.toNamed(Routes.FEED_BACK),
                      imageAsset: AssetHelper.icEditSquare,
                      widgetTitle: Text(
                        StringConst.feedback.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BuildSettingsItem(
                      onTap: () => Get.toNamed(Routes.ABOUT_APP_SCREEN),
                      imageAsset: AssetHelper.icInfoSquare,
                      widgetTitle: Text(
                        StringConst.about.tr,
                        style: appController.isDarkModeOn.value
                            ? AppStyles.lightDarkModeSize16Fw500FfMont
                            : AppStyles.gray600Size16Fw500FfMont,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: getSize(16)),
                  child: Text(
                    'QR Code',
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size16Fw500FfMont
                        : AppStyles.gray800Size16Fw500FfMont,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.grey800
                        : ColorConstants.white,
                  ),
                  child: const PrettyQrHomePage(),
                ),
                ListTile(
                  onTap: () {},
                  title: GestureDetector(
                    onTap: () => profileController.signUserOut(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConst.logout.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: getSize(16),
                        ),
                        Image.asset(
                          AssetHelper.icoLogout,
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.lightBackground
                              : ColorConstants.graySub,
                          width: 24,
                          height: 24,
                        ),
                      ],
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
      ),
    );
  }

  final _selectedLanguage = Language(1, "🇺🇸", "English", "en").obs;

  Language get selectedLanguage => _selectedLanguage.value;

  void handleLanguageSelection(Language? language) {
    if (language != null) {
      _selectedLanguage.value = language;
      String code = language.code;

      if (code == 'vi') {
        TranslationService.changeLocale('vi');
      } else if (code == 'en') {
        TranslationService.changeLocale('en');
      } else if (code == 'cn') {
        TranslationService.changeLocale('cn');
      }
    }
  }

  List<SpeedDialChild> _buildLanguageOptions() {
    return [
      _buildLanguageOption('🇺🇸 English', 'en'),
      _buildLanguageOption('🇨🇳 China', 'cn'),
      _buildLanguageOption('🇻🇳 Vietnamese', 'vi'),
    ];
  }

  SpeedDialChild _buildLanguageOption(String label, String locale) {
    return SpeedDialChild(
      backgroundColor: ColorConstants.blue,
      label: label,
      onTap: () {
        TranslationService.changeLocale(locale);
      },
    );
  }
}

final ProfileController controller = Get.find();
