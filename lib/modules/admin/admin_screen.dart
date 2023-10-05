import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_screen.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Admin",
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: getSize(36),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.TOUR),
                      child: const Text('View Tour'),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.ADMIN_CREATE_SCREEN),
                      child: const Text('Create Tour'),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.ADMIN_UPDATE_SCREEN),
                      child: const Text('Update Tour'),
                    ),
                  ],
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
