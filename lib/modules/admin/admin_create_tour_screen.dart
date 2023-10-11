
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
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

class AdminCreateScreen extends StatefulWidget {
  const AdminCreateScreen({super.key});

  @override
  State<AdminCreateScreen> createState() => _AdminCreateScreenState();
}

class _AdminCreateScreenState extends State<AdminCreateScreen> {
  AdminController adminController = Get.put(AdminController());
  TourController tourController = Get.put(TourController());
  final _formCreateKey = GlobalKey<FormState>();

  final List<String> items = [
    '50HCM',
    '43DN',
    '30HN',
  ];

  String startDateSelected = '';
  String endDateSelected = '';

  List<Widget> _children = [];
  int _count = 0;
  List<TextEditingController> _controllers = [];
  List<String> listIti = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Create Tour",
        iconBgrColor: ColorConstants.grayTextField,
        onTap: () {
          Get.back();
          adminController.clearController();
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formCreateKey,
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
                    Obx(
                      () => DropdownButtonHideUnderline(
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
                          items: tourController.items.value != null
                              ? tourController.items.value!
                                  .map(
                                    (String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: AppStyles
                                            .titleSearchSize14Fw400FfMont,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList()
                              : items
                                  .map(
                                    (String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: AppStyles
                                            .titleSearchSize14Fw400FfMont,
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
                    Row(
                      children: [
                        const Text(
                          "Itinerary Tour:",
                          style: TextStyle(
                            color: ColorConstants.graySub,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: IconButton(
                            onPressed: _add,
                            icon: Icon(
                              Icons.add,
                              size: getSize(16),
                              color: ColorConstants.accent1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyTextField(
                      controller: adminController.itineraryController,
                      hintText: "Enter itinerary tour of day 1",
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _children.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: getSize(16)),
                          child: _children[index],
                        );
                      },
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
                    SizedBox(
                      height: getSize(16),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          _save(_controllers);
                          if (_formCreateKey.currentState!.validate()) {
                            final TourModel tourModel = TourModel(
                              nameTour: adminController.nameTourController.text,
                              description:
                                  adminController.descriptionController.text,
                              idCity: adminController.idCityController.text,
                              startDate: adminController.formatDateTime(
                                  adminController.startDateController.text),
                              endDate: adminController.formatDateTime(
                                  adminController.endDateController.text),
                              price: double.parse(
                                  adminController.priceController.text),
                              images: List.empty(),
                              duration: adminController.durationController.text,
                              accommodation:
                                  adminController.accommodationController.text,
                              itinerary: listIti,
                              includedServices: listIti,
                              excludedServices: List.empty(),
                              reviews: List.empty(),
                              rating: double.parse(
                                  adminController.ratingController.text),
                              active: true,
                              specialOffers: List.empty(),
                              status: adminController.statusController.text,
                            );
                            adminController.createTour(tourModel);
                          }

                          Get.back();
                          adminController.getAllTourModelData();
                        },
                        child: const Text('Create'),
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _add() {
    TextEditingController newController = TextEditingController();
    _controllers.add(newController);

    _children = List.from(_children)
      ..add(
        MyTextField(
          controller: newController,
          hintText: "Enter itinerary tour of day ${_count + 2}",
          obscureText: false,
        ),
      );

    setState(() => ++_count);
  }

  void _save(List<TextEditingController> controllers) {
    listIti.clear();
    listIti.add(adminController.itineraryController.text);
    for (TextEditingController controller in controllers) {
      listIti.add(controller.text);
    }
  }
}
