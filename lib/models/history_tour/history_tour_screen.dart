import 'package:doan_clean_achitec/models/history_tour/history_tour_controller.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  UserController userController = Get.put(UserController());

  bool isShowLoading = true;
  SMITrigger? check;
  SMITrigger? error;
  SMITrigger? reset;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (historyTourController.getAllListHistory.value != null &&
            historyTourController.getAllListHistory.value!.isNotEmpty) {
          // check?.fire();
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              isShowLoading = false;
            });
          });
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            // error?.fire();
            setState(() {
              isShowLoading = false;
            });
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    historyTourController
        .getAllTourModelData(userController.userModel.value?.id ?? "");

    return Scaffold(
      appBar: CustomAppBar(
        titles: 'History',
      ),
      body: RefreshIndicator(
        onRefresh: () => historyTourController.refreshHistory(),
        child: isShowLoading
            ? Center(
                child: SizedBox(
                  height: getSize(120),
                  width: getSize(120),
                  child: RiveAnimation.asset(
                    "assets/icons/riv/ic_checkerror.riv",
                    onInit: (artboard) {
                      StateMachineController controller =
                          getRiveController(artboard);
                      check = controller.findSMI("Check") as SMITrigger;
                      error = controller.findSMI("Error") as SMITrigger;
                      reset = controller.findSMI("Reset") as SMITrigger;
                    },
                  ),
                ),
              )
            : Obx(
                () => historyTourController.getAllListHistory.value!.isNotEmpty
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: getSize(16),
                            horizontal: getSize(24),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: historyTourController
                                    .getAllListHistory.value?.length ??
                                2,
                            itemBuilder: (BuildContext context, int rowIndex) {
                              return Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getSize(12)),
                                child: _buildItemHistory(
                                    tourModel: historyTourController
                                        .getAllListHistory.value?[rowIndex]),
                              );
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: getSize(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetHelper.icoNodata,
                                width: getSize(360),
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: getSize(20),
                              ),
                              Text(
                                'No data',
                                style: AppStyles.black000Size16Fw500FfMont,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: getSize(16),
                                  horizontal: getSize(36.0),
                                ),
                                child: Text(
                                  'Looks like you haven\'t booked any tours yet.\nWhy not book your first tour now?',
                                  style: AppStyles.black000Size14Fw400FfMont,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: getSize(20),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Booking first tour!',
                                      style:
                                          AppStyles.black000Size16Fw500FfMont,
                                    ),
                                    SvgPicture.asset(
                                      AssetHelper.icoNextRight,
                                      color: ColorConstants.accent1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class _buildItemHistory extends StatelessWidget {
  TourModel? tourModel;
  _buildItemHistory({
    required this.tourModel,
    super.key,
  });

  HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.grayTextField,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tourModel?.nameTour ?? 'Tour Đà Nẵng - Hội An',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.black000Size16Fw500FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  historyTourController
                      .timestampToString(tourModel!.startDate!),
                  style: AppStyles.black000Size14Fw400FfMont,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '${tourModel?.price} VND',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.blue000Size14Fw400FfMont,
                ),
              ],
            ),
          ),
          SizedBox(
            width: getSize(30),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getSize(14)),
              child: Image.asset(
                AssetHelper.city_1,
                height: getSize(77),
                width: getSize(77),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
