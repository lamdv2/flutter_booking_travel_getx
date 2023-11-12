import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/utils/size_utils.dart';

class TabSearchWidget extends StatelessWidget {
  TabSearchWidget({super.key});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      labelColor: appController.isDarkModeOn.value
                          ? ColorConstants.primaryButton
                          : ColorConstants.primaryButton,
                      unselectedLabelColor: ColorConstants.gray600,
                      indicatorColor: appController.isDarkModeOn.value
                          ? ColorConstants.primaryButton
                          : ColorConstants.primaryButton,
                      tabs: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Tab(text: 'Popular destination'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Tab(text: 'Current destination'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    buildContentTab1(context),
                    buildContentTab2(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContentTab1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getSize(20)),
          SizedBox(
            height: getSize(200),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int rowIndex) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (rowIndex > 0)
                        SizedBox(
                          width: getSize(16),
                        ),
                      SizedBox(
                        height: getSize(180),
                        width: getSize(180),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                AssetHelper.city_1,
                                height: getSize(108),
                                width: getSize(180),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: getSize(10),
                            ),
                            Text(
                              'Ve Sun World Fansipan Lagend | Sapa',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                StarWidget(),
                                SizedBox(
                                  width: getSize(4),
                                ),
                                Text('4.6'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(20)),
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(getSize(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int rowIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (rowIndex > 0)
                            SizedBox(
                              height: getSize(16),
                            ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  AssetHelper.city_2,
                                  height: getSize(84),
                                  width: getSize(84),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: getSize(16),
                              ),
                              Text('Bangkok'),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: getSize(16)),
                ],
              ),
            ),
          ),
          SizedBox(height: getSize(16)),
        ],
      ),
    );
  }

  Widget buildContentTab2(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getSize(20)),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(20)),
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(getSize(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int rowIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (rowIndex > 0)
                            SizedBox(
                              height: getSize(16),
                            ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  AssetHelper.city_2,
                                  height: getSize(84),
                                  width: getSize(84),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: getSize(16),
                              ),
                              Text('Bangkok'),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: getSize(16)),
                ],
              ),
            ),
          ),
          SizedBox(height: getSize(16)),
        ],
      ),
    );
  }
}
