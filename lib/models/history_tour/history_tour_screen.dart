import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/models/history_tour/history_tour_controller.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
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
        .getTourDetailsById(userController.userModel.value?.id ?? "");

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
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: historyTourController
                        .getListHistoryByUserId.value?.length ??
                    2,
                itemBuilder: (BuildContext context, int rowIndex) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: getSize(12)),
                    child: _buildItemHistory(
                        historyModel: historyTourController
                            .getListHistoryByUserId.value?[rowIndex]),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _buildItemHistory extends StatelessWidget {
  HistoryModel? historyModel;
  _buildItemHistory({
    required this.historyModel,
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
                  historyModel?.idTour ?? 'Tour Đà Nẵng - Hội An',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.black000Size14Fw400FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '28/09/2023',
                  style: AppStyles.black000Size14Fw400FfMont,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '1231230',
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
