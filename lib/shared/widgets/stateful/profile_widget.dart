import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dark_mode.dart';
import '../../../modules/auth/user_controller.dart';
import '../../constants/assets_helper.dart';
import '../../constants/colors.dart';
import '../../utils/size_utils.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({
    super.key,
    required this.userController,
  });

  final UserController userController;
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appController.isDarkModeOn.value
            ? ColorConstants.bgrDarkmode!
            : ColorConstants.white,
        borderRadius: BorderRadius.circular(getSize(24)),
      ),
      padding: EdgeInsets.all(getSize(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(AssetHelper.city_1),
            radius: 50,
          ),
          SizedBox(width: getSize(24)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userController.userName.value != ''
                      ? userController.userName.value
                      : "David Lunik",
                  style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  userController.userEmail.value != ''
                      ? userController.userEmail.value
                      : "lambo1207@gmail.com",
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 16),
                  child: Divider(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySecond,
                    thickness: getSize(0.5),
                    endIndent: getSize(16),
                  ),
                ),
                Text(
                  "+84 123 456 789",
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.titleSub,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 16),
                  child: Divider(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySecond,
                    thickness: getSize(0.5),
                    endIndent: getSize(16),
                  ),
                ),
                Text(
                  "DaNang, VietNam",
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.titleSub,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
