import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour_item_widget.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:slideable/slideable.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminController adminController = Get.put(AdminController());
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'bounce',
      autoplay: true,
    );

    adminController.getAllTourModelData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Admin",
        iconBgrColor: ColorConstants.grayTextField,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADMIN_CREATE_SCREEN);
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          size: getSize(24),
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: adminController.refreshTourList,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: getSize(36),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'All Tour',
                        style: AppStyles.black000Size18Fw500FfMont,
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    adminController.getListTour.value != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                adminController.getListTour.value?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Slideable(
                                items: <ActionItems>[
                                  ActionItems(
                                    icon: Icon(
                                      Icons.update_outlined,
                                      color: Colors.blue,
                                      size: getSize(28),
                                    ),
                                    onPress: () {
                                      Get.toNamed(
                                        Routes.ADMIN_UPDATE_SCREEN,
                                        arguments: adminController
                                            .getListTour.value?[index],
                                      );
                                    },
                                    backgroudColor: Colors.transparent,
                                  ),
                                  ActionItems(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: getSize(28),
                                    ),
                                    onPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Confirmation',
                                              style: AppStyles
                                                  .black000Size14Fw600FfMont,
                                            ),
                                            content: Text(
                                              'Do you want to delete?',
                                              style: AppStyles
                                                  .black000Size16Fw700FfMont,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  String? idTour =
                                                      adminController
                                                          .getListTour
                                                          .value![index]
                                                          .idTour;
                                                  adminController
                                                      .deleteTourById(
                                                          idTour ?? '');
                                                  adminController
                                                      .getAllTourModelData();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    backgroudColor: Colors.transparent,
                                  ),
                                ],
                                child: Row(
                                  children: [
                                    if (index > 0)
                                      SizedBox(
                                        height: getSize(24),
                                      ),
                                    Expanded(
                                      child: TourItemWidget(
                                        listTour: adminController
                                            .getListTour.value![index],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
