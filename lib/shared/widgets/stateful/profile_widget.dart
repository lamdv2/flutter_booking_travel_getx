import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../modules/auth/user_controller.dart';
import '../../constants/assets_helper.dart';
import '../../constants/colors.dart';
import '../../utils/size_utils.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.secondBackground,
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
                  style: const TextStyle(
                      color: Colors.black,
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
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 16),
                  child: Divider(
                    color: ColorConstants.graySecond,
                    thickness: getSize(0.5),
                    endIndent: getSize(16),
                  ),
                ),
                const Text(
                  "+84 123 456 789",
                  style: TextStyle(
                    color: ColorConstants.titleSub,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 16),
                  child: Divider(
                    color: ColorConstants.graySecond,
                    thickness: getSize(0.5),
                    endIndent: getSize(16),
                  ),
                ),
                const Text(
                  "DaNang, VietNam",
                  style: TextStyle(
                    color: ColorConstants.titleSub,
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
