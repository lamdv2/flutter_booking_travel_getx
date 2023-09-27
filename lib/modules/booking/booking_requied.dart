import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingRequiedScreen extends StatelessWidget {
  const BookingRequiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TourController tourController = Get.put(TourController());

    return Scaffold(
      // appBar: CustomAppBar(),
      backgroundColor: ColorConstants.graySecond,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: getSize(60),
          bottom: getSize(40),
          right: getSize(40),
          left: getSize(40),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                getSize(28),
              ),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(
                  getSize(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(16),
                  ),
                  Text(
                    'Tour Da Nang - Hoi An - Hue - Quang Binh',
                    style: AppStyles.black000Size18Fw600FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  Text(
                    '5 ngay 4 dem',
                    style: AppStyles.black000Size14Fw400FfMont,
                  ),
                  SizedBox(height: getSize(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price:',
                        style: AppStyles.black000Size14Fw400FfMont,
                      ),
                      Text(
                        '\$ 810000',
                        style: AppStyles.black000Size16Fw500FfMont,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(50),
                  ),
                  Text(
                    'Service Excluded',
                    style: AppStyles.black000Size18Fw500FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  Text(
                    'Booking vip room',
                    style: AppStyles.black000Size14Fw400FfMont,
                  ),
                  SizedBox(height: getSize(16)),
                  Text(
                    'Buffet Breakfast',
                    style: AppStyles.black000Size14Fw400FfMont,
                  ),
                  SizedBox(height: getSize(60)),
                  Text(
                    'Payment Method',
                    style: AppStyles.black000Size18Fw500FfMont,
                  ),
                  SizedBox(height: getSize(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.grayTextField,
                            borderRadius: BorderRadius.circular(
                              getSize(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AssetHelper.icScan,
                                height: getSize(36),
                                width: getSize(36),
                              ),
                              SizedBox(height: getSize(28)),
                              Text(
                                'QR Code',
                                style: AppStyles.black000Size12Fw400FfMont,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getSize(20),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.grayTextField,
                            borderRadius: BorderRadius.circular(
                              getSize(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AssetHelper.icBag,
                                height: getSize(36),
                                width: getSize(36),
                              ),
                              SizedBox(height: getSize(28)),
                              Text(
                                'Cash',
                                style: AppStyles.black000Size12Fw400FfMont,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getSize(20),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.grayTextField,
                            borderRadius: BorderRadius.circular(
                              getSize(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AssetHelper.icWallet,
                                height: getSize(36),
                                width: getSize(36),
                              ),
                              SizedBox(height: getSize(28)),
                              Text(
                                'Wallet',
                                style: AppStyles.black000Size12Fw400FfMont,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(40),
                    ),
                    child: ButtonWidget(
                      textBtn: 'Yêu cầu đặt',
                      onTap: () {
                        // Get.toNamed(Routes.BOOKING_REQUIED);
                      },
                    ),
                  ),
                  SizedBox(height: getSize(28)),
                ],
              ),
            ),
            Positioned(
              top: getSize(8),
              right: getSize(8),
              child: InkWell(
                onTap: () => Get.back(),
                child: SvgPicture.asset(AssetHelper.icCloseSquare),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
