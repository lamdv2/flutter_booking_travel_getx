import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_screen.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCreateScreen extends StatefulWidget {
  const AdminCreateScreen({super.key});

  @override
  State<AdminCreateScreen> createState() => _AdminCreateScreenState();
}

class _AdminCreateScreenState extends State<AdminCreateScreen> {
  AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Create Tour",
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(36),
                ),
                const Text(
                  "Name Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(8),
                ),
                MyTextField(
                  controller: adminController.nameTourController,
                  hintText: "Enter new name tour",
                  obscureText: false,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Text(
                  "Description Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(8),
                ),
                MyTextField(
                  controller: adminController.descriptionController,
                  hintText: "Enter description tour",
                  obscureText: false,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Text(
                  "IdCity Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(8),
                ),
                MyTextField(
                  controller: adminController.idCityController,
                  hintText: "Enter IdCity Tour",
                  obscureText: false,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Text(
                  "StartDate Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(8),
                ),
                MyTextField(
                  controller: adminController.startDateController,
                  hintText: "Enter StartDate",
                  obscureText: false,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Text(
                  "EndDate Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(8),
                ),
                MyTextField(
                  controller: adminController.endDateController,
                  hintText: "Enter EndDate",
                  obscureText: false,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
