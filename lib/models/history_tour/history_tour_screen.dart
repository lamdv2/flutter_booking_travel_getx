import 'package:doan_clean_achitec/models/history_tour/history_tour_controller.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/convert_date_time.dart';
import 'package:doan_clean_achitec/shared/utils/loading_rive_check.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  HistoryTourController historyTourController =
      Get.put(HistoryTourController());
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    historyTourController
        .getAllTourModelData(userController.userModel.value?.id ?? "");

    return Scaffold(
      appBar: CustomAppBar(
        titles: 'History',
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => historyTourController.refreshHistory(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getSize(16),
                horizontal: getSize(24),
              ),
              child: historyTourController
                          .getAllListHistory.value!.isNotEmpty &&
                      historyTourController.getAllListHistory.value?.length !=
                          null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: historyTourController
                              .getAllListHistory.value?.length ??
                          2,
                      itemBuilder: (BuildContext context, int rowIndex) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: getSize(12)),
                          child: _buildItemHistory(
                              tourModel: historyTourController
                                  .getAllListHistory.value?[rowIndex]),
                        );
                      },
                    )
                  : const LoadingRiveCheck(),
            ),
          ),
        ),
      ),
    );
  }
}

class _buildItemHistory extends StatelessWidget {
  TourModel? tourModel;
  _buildItemHistory({
    required this.tourModel,
    super.key,
  });

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
                  style: AppStyles.black000Size14Fw400FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  tourModel!.startDate.toString(),
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
