import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

final ProfileController profileController = Get.find();
final AuthController authController = Get.put(AuthController());
final TourController tourController = Get.put(TourController());

class _TourScreenState extends State<TourScreen> {
  IconData? iconHeart = FontAwesomeIcons.solidHeart;

  final List<String> items = [
    'Popular',
    'New',
    'Sale',
  ];

  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'bounce',
      autoplay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    tourController.getAllTourModel();

    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: tourController.refreshTourList,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getSize(16),
                horizontal: getSize(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchBarWidget(
                      textEditingController: tourController.searchController,
                      onChanged: (value) =>
                          tourController.filterListTourByName(value),
                      hintText: "Search your favorite destination"),
                  SizedBox(
                    height: getSize(32),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pre-Book',
                      style: AppStyles.botTitle000Size30Fw800FfMont,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Tour Pack',
                      style: AppStyles.botTitle000Size28Fw500FfMont,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: getSize(32),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => tourController.isCheckSearch.value =
                                !tourController.isCheckSearch.value,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: getSize(20),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getSize(22),
                                ),
                                boxShadow: const [],
                                color: tourController.isCheckSearch.value
                                    ? ColorConstants.primaryButton
                                    : ColorConstants.grayTextField,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'City',
                                style: tourController.isCheckSearch.value
                                    ? AppStyles.white000Size18Fw500FfMont
                                    : AppStyles.black000Size18Fw500FfMont,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getSize(24),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => tourController.isCheckSearch.value =
                                !tourController.isCheckSearch.value,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: getSize(20),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getSize(22),
                                ),
                                boxShadow: const [],
                                color: tourController.isCheckSearch.value
                                    ? ColorConstants.grayTextField
                                    : ColorConstants.primaryButton,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Vicinity',
                                style: tourController.isCheckSearch.value
                                    ? AppStyles.black000Size18Fw500FfMont
                                    : AppStyles.white000Size18Fw500FfMont,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getSize(28),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter',
                        style: AppStyles.black000Size18Fw500FfMont,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Popular',
                                  style: AppStyles.titleSearchSize16Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppStyles
                                          .titleSearchSize14Fw400FfMont,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: tourController.selectedValue.value,
                          onChanged: (value) {
                            // setState(() {
                            //   selectedValue = value;
                            // });
                            tourController.selectedValue.value = value!;
                            tourController.filterListTourByState(value);
                          },
                          buttonStyleData: ButtonStyleData(
                            height: getSize(50),
                            width: getSize(160),
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(16),
                              vertical: getSize(8),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstants.darkGray.withOpacity(.2),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(
                                getSize(8),
                              ),
                              boxShadow: const [],
                              color: ColorConstants.white,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: IconStyleData(
                            icon: SvgPicture.asset(
                              AssetHelper.icFilter,
                              width: getSize(24),
                            ),
                            iconEnabledColor: ColorConstants.botTitle,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: getSize(200),
                            width: getSize(200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: ColorConstants.white,
                            ),
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: getSize(40),
                            padding: const EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(30),
                  ),
                  tourController.getListTour.value != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tourController.getListTour.value?.length,
                          itemBuilder: (BuildContext context, int rowIndex) {
                            return Row(
                              children: [
                                if (rowIndex > 0)
                                  SizedBox(
                                    height: getSize(24),
                                  ),
                                Expanded(
                                  child: TourItemWidget(
                                    listTour: tourController
                                        .getListTour.value![rowIndex],
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : Container(
                          height: getSize(250),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConstants.grayTextField,
                            borderRadius: BorderRadius.circular(
                              getSize(16),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: RiveAnimation.asset(
                            'assets/icons/riv/ic_checkerror.riv',
                            // artboard: "Search",
                            animations: const ['idle', 'curves'],

                            onInit: (p0) {
                              _controller.isActive;
                            },
                          ),
                        ),
                  // SizedBox(
                  //   height: 500,
                  //   child: StreamBuilder<QuerySnapshot>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('tourModel')
                  //         .snapshots(),
                  //     builder: (context, snapshot) {
                  //       List<Row> accountWidgets = [];
                  //       if (snapshot.hasData) {
                  //         final accounts = snapshot.data?.docs.reversed.toList();
                  //         for (var item in accounts!) {
                  //           final email = item['duration'] ?? 'N/A';
                  //           final firstName = item['idCity'] ?? 'N/A';
                  //           final lastName = item['duration'] ?? 'N/A';
                  //           final phoneNub = item['duration'] ?? 'N/A';

                  //           final clientWidget = Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(email),
                  //               Text(firstName),
                  //               Text(lastName),
                  //               Text(phoneNub),
                  //               IconButton(
                  //                 onPressed: () {
                  //                   var collection = FirebaseFirestore.instance
                  //                       .collection('tourModel');
                  //                   collection.doc(item.id).delete();
                  //                 },
                  //                 icon: const Icon(
                  //                   Icons.delete,
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //             ],
                  //           );
                  //           accountWidgets.add(clientWidget);
                  //         }
                  //       }
                  //       return Expanded(
                  //         child: ListView(
                  //           children: accountWidgets,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
