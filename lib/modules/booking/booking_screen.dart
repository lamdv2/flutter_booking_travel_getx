import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/utils/convert_date_time.dart';
import 'booking_controller.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  HomeController homeController = Get.find();
  BookingController bookingController = Get.put(BookingController());
  static String dateSelected = '';
  final List<String> items = [
    '50HCM',
    '43DN',
    '29HN',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Booking",
        iconBgrColor: ColorConstants.grayTextField,
        onTap: () => homeController.currentIndex.value = 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(
                  "Choose your favorite hotel and enjoy the service",
                  style: AppStyles.botTitle000Size12Fw400FfMont,
                ),
                SizedBox(
                  height: getSize(46),
                ),
                Obx(
                  () => DropdownButtonHideUnderline(
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
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        AssetHelper.icoDestination),
                                    SizedBox(
                                      width: getSize(16),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Destination",
                                          style: AppStyles
                                              .botTitle000Size14Fw400FfMont,
                                        ),
                                        SizedBox(
                                          height: getSize(8.0),
                                        ),
                                        Text(
                                          item,
                                          style: AppStyles
                                              .botTitle000Size14Fw400FfMont,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      value: bookingController.selectedValue.value,
                      onChanged: (value) {
                        bookingController.selectedValue.value = value!;
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSize(16),
                          vertical: getSize(8),
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.grayTextField,
                          borderRadius: BorderRadius.circular(
                            getSize(14),
                          ),
                          boxShadow: const [],
                        ),
                        elevation: 2,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        padding: EdgeInsets.only(left: getSize(16)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: ColorConstants.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.only(left: 0, right: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(46),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Get.toNamed(Routes.SELECT_DATE);
                    if (result is List<DateTime?>) {
                      dateSelected =
                          '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.grayTextField,
                      borderRadius: BorderRadius.circular(getSize(14)),
                    ),
                    padding: EdgeInsets.only(
                      left: getSize(34),
                      top: getSize(16),
                      bottom: getSize(16),
                      right: getSize(16),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AssetHelper.icoCalender),
                        SizedBox(
                          width: getSize(16),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Select Date",
                              style: AppStyles.botTitle000Size14Fw400FfMont,
                            ),
                            SizedBox(
                              height: getSize(8.0),
                            ),
                            Text(
                              dateSelected.isEmpty
                                  ? 'Please select your start date'
                                  : dateSelected,
                              style: AppStyles.botTitle000Size14Fw400FfMont,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(46),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: getSize(48),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(16)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: ColorConstants.primaryButton,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.TOUR);
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(46),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: getSize(48),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(16)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: ColorConstants.btnCanCel,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.LOADING_IMAGE);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.black,
                        ),
                      ),
                    ),
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
