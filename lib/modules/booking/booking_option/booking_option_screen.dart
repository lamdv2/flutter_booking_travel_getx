import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/modules/booking/booking_option/booking_option_controller.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/regex.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/button_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constants/app_style.dart';
import '../../../shared/utils/app_bar_widget.dart';
import '../../auth/user_controller.dart';
import '../booking_controller.dart';

class BookingOptionScreen extends GetView<BookingOptionController> {
  BookingOptionScreen({super.key});

  final TourModel? tourModel = Get.arguments;

  final AppController appController = Get.find();
  final AuthController authController = Get.find();
  final HomeController homeController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());
  final UserController userController = Get.put(UserController());
  final BookingController bookingController = Get.put(BookingController());
  final BookingRequestController bookingRequestController =
      Get.put(BookingRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Confirm Booking".tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.lightBackground,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tourModel?.nameTour ?? '',
                              style: AppStyles.black000Size18Fw600FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              'Start location',
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              '${tourModel?.accommodation}',
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              'Start Date',
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              controller.formatTimeStampToString(
                                  tourModel?.startDate ?? Timestamp.now()),
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              'Quantity',
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              "Adult x ${bookingRequestController.adultNumb.value?.toInt()}, children x ${bookingRequestController.childrenNumb.value?.toInt()}",
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Container(
                      width: double.infinity,
                      color: ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Information Customer',
                              style: AppStyles.black000Size18Fw600FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(24),
                            ),
                            Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'First name',
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller:
                                        controller.firstNameConfirmController,
                                    hintText: "Enter your first name",
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    'Last name',
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller: controller.lastNameController,
                                    hintText: "Enter your last name",
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    'Email',
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller: controller.emailController,
                                    hintText: "Enter your email",
                                    obscureText: false,
                                    isCheckReadOnly: true,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    'Phone number',
                                    style: AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller:
                                        controller.phoneNumberController,
                                    hintText: "Enter your phone number",
                                    obscureText: false,
                                    isTypeNumb: true,
                                    validatorCheck: (value) {
                                      if (!Regex.isPasswordNumber(
                                          value!.trim())) {
                                        return 'password must contain at least one number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Container(
                      width: double.infinity,
                      color: ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Method",
                              style: AppStyles.black000Size18Fw600FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              'Scan QR code',
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              'Scanner with QR',
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              'Banking',
                              style: AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              "5621 000 123 4567",
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              "BIDV DO VAN LAM",
                              style: AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(96),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(getSize(16)),
                  color: ColorConstants.lightCard,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${bookingRequestController.totalPrice.toInt()} ',
                                style: AppStyles.blue000Size16Fw500FfMont,
                              ),
                              TextSpan(
                                text: 'VND ',
                                style: AppStyles.black000Size14Fw400FfMont,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ButtonWidget(
                        textBtn: 'Payment',
                        onTap: () {
                          final userOtp = UserModel(
                            id: homeController.userModel.value?.id ?? '',
                            email: homeController.userModel.value?.email ?? '',
                            firstName: controller
                                .firstNameConfirmController.text
                                .trim(),
                            lastName: controller.lastNameController.text.trim(),
                            passWord:
                                homeController.userModel.value?.passWord ?? '',
                            imgAvatar:
                                homeController.userModel.value?.imgAvatar ?? "",
                            phoneNub:
                                controller.phoneNumberController.text.trim(),
                            location:
                                homeController.userModel.value?.location ?? "",
                            isActive: true,
                          );
                          authController.signInPhoneAuthentication(
                            controller.formatPhoneNumber(
                                controller.phoneNumberController.text),
                            userOtp,
                            tourModel!,
                          );
                        },
                      ),
                    ],
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
