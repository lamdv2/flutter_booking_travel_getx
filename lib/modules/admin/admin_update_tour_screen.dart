import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_screen.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/convert_date_time.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/my_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AdminUpdateScreen extends StatefulWidget {
  const AdminUpdateScreen({super.key});

  @override
  State<AdminUpdateScreen> createState() => _AdminUpdateScreenState();
}

class _AdminUpdateScreenState extends State<AdminUpdateScreen> {
  AdminController adminController = Get.put(AdminController());

  final List<String> items = [
    '50HCM',
    '43DN',
    '29HN',
  ];

  final List<Map<String, String>> itemsName = [
    {'50HCM': 'Hồ Chí Minh'},
    {'43DN': 'Đà Nẵng'},
    {'29HN': 'Hà Nội'},
  ];

  String startDateSelected = '';
  String endDateSelected = '';

  final TourModel? tourModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    adminController.nameTourController.text = tourModel?.nameTour ?? '';
    adminController.descriptionController.text = tourModel?.description ?? '';
    adminController.idCityController.text = tourModel?.idCity ?? '';
    // adminController. startDateController.text = tourModel?.startDate ?? '';
    // adminController. endDateController.text = tourModel?.endDate ?? '';
    adminController.priceController.text = tourModel?.price.toString() ?? '';
    // adminController. imagesController.text =
    adminController.durationController.text = tourModel?.duration ?? '';
    adminController.accommodationController.text =
        tourModel?.accommodation ?? '';
    // adminController. itineraryController.text = tourModel?.itinerary ?? '';
    // adminController. includedServicesController.text =
    // adminController. excludedServicesController.text =
    // adminController. reviewsController.text =
    adminController.ratingController.text = tourModel?.rating.toString() ?? '';
    adminController.activeController.text = tourModel?.accommodation ?? '';
    // adminController. statusController.text =
    // adminController. specialOffersController.text =
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Update Tour",
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
                  height: getSize(12),
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
                  height: getSize(12),
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
                  height: getSize(12),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            adminController.selectedValue.value,
                            style: AppStyles.titleSearchSize16Fw400FfMont,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map(
                          (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: AppStyles.titleSearchSize14Fw400FfMont,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    value: adminController.selectedValue.value,
                    onChanged: (value) {
                      adminController.selectedValue.value = value!;
                      adminController.idCityController.text =
                          adminController.selectedValue.value;
                    },
                    buttonStyleData: ButtonStyleData(
                      height: getSize(50),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(16),
                        vertical: getSize(8),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstants.darkGray.withOpacity(.5),
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
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey.shade100,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(20),
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
                  height: getSize(12),
                ),
                Container(
                  width: double.infinity,
                  color: ColorConstants.white,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.white),
                    ),
                    onPressed: () async {
                      final result = await Get.toNamed(Routes.SELECT_DATE);
                      if (result is List<DateTime?>) {
                        startDateSelected = '${result[0]?.getDate}';
                        setState(() {
                          adminController.startDateController.text =
                              startDateSelected;
                        });
                      }
                    },
                    child: Text(
                      startDateSelected,
                      style: AppStyles.black000Size14Fw400FfMont,
                    ),
                  ),
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
                  height: getSize(12),
                ),
                Container(
                  width: double.infinity,
                  color: ColorConstants.white,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.white),
                    ),
                    onPressed: () async {
                      final result = await Get.toNamed(Routes.SELECT_DATE);
                      if (result is List<DateTime?>) {
                        endDateSelected = '${result[0]?.getDate}';
                        setState(() {
                          adminController.endDateController.text =
                              endDateSelected;
                        });
                      }
                    },
                    child: Text(
                      endDateSelected,
                      style: AppStyles.black000Size14Fw400FfMont,
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Text(
                  "Price Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                MyTextField(
                  controller: adminController.priceController,
                  hintText: "Enter price tour",
                  obscureText: false,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Text(
                  "Itinerary Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                MyTextField(
                  controller: adminController.itineraryController,
                  hintText: "Enter itinerary tour",
                  obscureText: false,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                const Text(
                  "Rating Tour:",
                  style: TextStyle(
                    color: ColorConstants.graySub,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                MyTextField(
                  controller: adminController.ratingController,
                  hintText: "Enter rating tour",
                  obscureText: false,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // DateFormat dateFormat = DateFormat("dd/MM/yyyy");
                      // DateTime dateTime = dateFormat
                      //     .parse(adminController.startDateController.text);
                      final TourModel tourModel = TourModel(
                        nameTour: adminController.nameTourController.text,
                        description: adminController.descriptionController.text,
                        idCity: adminController.idCityController.text,
                        // startDate: dateTime,
                        // endDate: dateTime,
                        price:
                            double.parse(adminController.priceController.text),
                        images: List.empty(),
                        duration: adminController.durationController.text,
                        accommodation:
                            adminController.accommodationController.text,
                        itinerary: List.empty(),
                        includedServices: List.empty(),
                        excludedServices: List.empty(),
                        reviews: List.empty(),
                        rating:
                            double.parse(adminController.ratingController.text),
                        active: true,
                        specialOffers: List.empty(),
                        status: adminController.statusController.text,
                      );
                      adminController.createTour(tourModel);
                      Get.back();
                      adminController.getAllTourModelData();
                    },
                    child: const Text('Update'),
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
