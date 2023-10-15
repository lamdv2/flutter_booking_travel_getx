import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/user_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

final UserController userController = Get.find();
final ProfileController profileController = Get.find();

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorConstants.white,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(24),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    AssetHelper.city_6,
                    width: getSize(116),
                    height: getSize(116),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: getSize(32),
                ),
                Text(
                  userController.userName.value,
                  style: TextStyle(
                      color: ColorConstants.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: getSize(36),
                ),
                const Text(
                  "email",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                TextField(
                  controller: profileController.editEmailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    hintText: userController.userEmail.value,
                    hintStyle: const TextStyle(
                      color: ColorConstants.titleSub,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Divider(
                  color: ColorConstants.graySecond,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: getSize(36),
                ),
                const Text(
                  "phone number",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                TextField(
                  controller: profileController.editPhoneNumberController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    hintText: "0123456789",
                    hintStyle: TextStyle(
                      color: ColorConstants.titleSub,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Divider(
                  color: ColorConstants.graySecond,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: getSize(36),
                ),
                const Text(
                  "location",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                TextField(
                  controller: profileController.editLocationController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    hintText: "Washington DC, USA",
                    hintStyle: TextStyle(
                      color: ColorConstants.titleSub,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none, // Đây là phần cần thêm vào
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Divider(
                  color: ColorConstants.graySecond,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: getSize(48),
                ),
                Center(
                  child: MyButton(
                    onTap: () {
                      final userModel = UserModel(
                          email:
                              profileController.editEmailController.text.trim(),
                          firstName:
                              profileController.editEmailController.text.trim(),
                          lastName:
                              profileController.editEmailController.text.trim(),
                          passWord:
                              profileController.editEmailController.text.trim(),
                          imgAvatar: profileController
                              .editLocationController.text
                              .trim(),
                          phoneNub: profileController
                              .editPhoneNumberController.text
                              .trim(),
                          isActive: true);
                      userController.updateUserProfile(userModel);
                    },
                    textBtn: "Save",
                    colorBgr: ColorConstants.primaryButton,
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
