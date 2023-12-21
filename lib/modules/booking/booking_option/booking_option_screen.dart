import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/modules/booking/booking_option/booking_option_controller.dart';
import 'package:doan_clean_achitec/modules/booking/booking_request.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
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

  final TourModel? tourModel = Get.arguments['arg1'];
  final String statusPaymentMethod = Get.arguments['arg2'];

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
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        titles: "Confirm Booking".tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.lightBackground,
      ),
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
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
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.darkCard
                          : ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tourModel?.nameTour ?? '',
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.white000Size18Fw600FfMont
                                  : AppStyles.black000Size18Fw600FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              StringConst.startLocation.tr,
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.gray400Size14Fw400FfMont
                                  : AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              '${tourModel?.accommodation}',
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.white000Size14Fw400FfMont
                                  : AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              StringConst.startDateTour.tr,
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.gray400Size14Fw400FfMont
                                  : AppStyles.gray600Size14Fw400FfMont,
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
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.white000Size14Fw400FfMont
                                  : AppStyles.black000Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            Text(
                              StringConst.quantity.tr,
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.gray400Size14Fw400FfMont
                                  : AppStyles.gray600Size14Fw400FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(2),
                            ),
                            Text(
                              "${StringConst.adult.tr} x ${bookingRequestController.adultNumb.value?.toInt()}, ${StringConst.children.tr} x ${bookingRequestController.childrenNumb.value?.toInt()}",
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.white000Size14Fw400FfMont
                                  : AppStyles.black000Size14Fw400FfMont,
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
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.darkCard
                          : ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringConst.informationCustomer.tr,
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.white000Size18Fw600FfMont
                                  : AppStyles.black000Size18Fw600FfMont,
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
                                    StringConst.firstName.tr,
                                    style: appController.isDarkModeOn.value
                                        ? AppStyles.gray400Size14Fw400FfMont
                                        : AppStyles.black000Size14Fw400FfMont,
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
                                    hintText: StringConst.enterYourFirstname.tr,
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    StringConst.lastName.tr,
                                    style: appController.isDarkModeOn.value
                                        ? AppStyles.white000Size14Fw400FfMont
                                        : AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller: controller.lastNameController,
                                    hintText: StringConst.enterYourLastName.tr,
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    StringConst.email.tr,
                                    style: appController.isDarkModeOn.value
                                        ? AppStyles.white000Size14Fw400FfMont
                                        : AppStyles.black000Size14Fw400FfMont,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                  MyTextField(
                                    controller: controller.emailController,
                                    hintText: StringConst.enterYourEmail.tr,
                                    obscureText: false,
                                    isCheckReadOnly: true,
                                  ),
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                  Text(
                                    StringConst.phoneNumber.tr,
                                    style: appController.isDarkModeOn.value
                                        ? AppStyles.white000Size14Fw400FfMont
                                        : AppStyles.black000Size14Fw400FfMont,
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
                                    hintText:
                                        StringConst.enterYourPhoneNumber.tr,
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
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.darkCard
                          : ColorConstants.lightCard,
                      child: Padding(
                        padding: EdgeInsets.all(getSize(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringConst.paymentMethod.tr,
                              style: appController.isDarkModeOn.value
                                  ? AppStyles.white000Size18Fw600FfMont
                                  : AppStyles.black000Size18Fw600FfMont,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            SizedBox(
                              height: getSize(16),
                            ),
                            statusPaymentMethod == "qrcode"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringConst.scanQRCode.tr,
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles.gray400Size16Fw400FfMont
                                            : AppStyles
                                                .gray600Size16Fw400FfMont,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      SizedBox(
                                        height: getSize(2),
                                      ),
                                      Text(
                                        StringConst.scannerWithQR.tr,
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles
                                                .white000Size14Fw400FfMont
                                            : AppStyles
                                                .black000Size14Fw400FfMont,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ],
                                  )
                                : statusPaymentMethod == "banking"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            StringConst.banking.tr,
                                            style: appController
                                                    .isDarkModeOn.value
                                                ? AppStyles
                                                    .gray400Size16Fw400FfMont
                                                : AppStyles
                                                    .gray600Size16Fw400FfMont,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                          SizedBox(
                                            height: getSize(2),
                                          ),
                                          Text(
                                            "5621 000 246 6118",
                                            style: appController
                                                    .isDarkModeOn.value
                                                ? AppStyles
                                                    .white000Size14Fw400FfMont
                                                : AppStyles
                                                    .black000Size14Fw400FfMont,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                          SizedBox(
                                            height: getSize(2),
                                          ),
                                          Text(
                                            "BIDV DO VAN LAM",
                                            style: appController
                                                    .isDarkModeOn.value
                                                ? AppStyles
                                                    .white000Size14Fw400FfMont
                                                : AppStyles
                                                    .black000Size14Fw400FfMont,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            StringConst.cash.tr,
                                            style: appController
                                                    .isDarkModeOn.value
                                                ? AppStyles
                                                    .gray400Size16Fw400FfMont
                                                : AppStyles
                                                    .gray600Size16Fw400FfMont,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                          SizedBox(
                                            height: getSize(2),
                                          ),
                                          Text(
                                            "4242 4242 4242 4242",
                                            style: appController
                                                    .isDarkModeOn.value
                                                ? AppStyles
                                                    .white000Size14Fw400FfMont
                                                : AppStyles
                                                    .black000Size14Fw400FfMont,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                          SizedBox(
                                            height: getSize(2),
                                          ),
                                          Text(
                                            "DO VAN LAM",
                                            style: appController
                                                    .isDarkModeOn.value
                                                ? AppStyles
                                                    .white000Size14Fw400FfMont
                                                : AppStyles
                                                    .black000Size14Fw400FfMont,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        ],
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
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.darkCard
                      : ColorConstants.lightCard,
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
                                style: appController.isDarkModeOn.value
                                    ? AppStyles.white000Size14Fw400FfMont
                                    : AppStyles.black000Size14Fw400FfMont,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ButtonWidget(
                        textBtn: StringConst.payment.tr,
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
                              controller.phoneNumberController.text,
                            ),
                            userOtp,
                            tourModel!,
                            statusPaymentMethod,
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
