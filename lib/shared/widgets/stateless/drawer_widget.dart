import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../modules/profile/profile_screen.dart';
import '../../../routes/app_pages.dart';
import '../../constants/assets_helper.dart';
import '../../constants/colors.dart';
import '../../utils/size_utils.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: getSize(16 + MediaQuery.of(context).padding.top),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: SvgPicture.asset(
                  AssetHelper.icoNextLeft,
                  colorFilter: const ColorFilter.mode(
                    ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(24),
                  height: getSize(24),
                ),
              ),
            ),
          ),
          SizedBox(
            height: getSize(32),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icProfile,
                  colorFilter: const ColorFilter.mode(
                    ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(24),
                  height: getSize(24),
                ),
                SizedBox(
                  width: getSize(16),
                ),
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
          ),
          Divider(
            thickness: 0.5,
            color: ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 100,
          ),
          SizedBox(
            height: getSize(16),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icBag,
                  color: ColorConstants.graySub,
                  width: getSize(24),
                  height: getSize(24),
                ),
                SizedBox(
                  width: getSize(16),
                ),
                const Text(
                  'Booking',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.BOOKING);
            },
          ),
          Divider(
            thickness: 0.5,
            color: ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 100,
          ),
          SizedBox(
            height: getSize(16),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icoHotel,
                  color: ColorConstants.graySub,
                  width: getSize(24),
                  height: getSize(24),
                ),
                SizedBox(
                  width: getSize(16),
                ),
                const Text(
                  'Hotels',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.HOTEL);
            },
          ),
          Divider(
            thickness: 0.5,
            color: ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 100,
          ),
          SizedBox(
            height: getSize(16),
          ),
          ListTile(
            title: Row(
              children: [
                Image.asset(
                  AssetHelper.icoRoom,
                  color: ColorConstants.graySub,
                  width: getSize(24),
                  height: getSize(24),
                ),
                SizedBox(
                  width: getSize(16),
                ),
                const Text(
                  'Rooms',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.ROOM);
            },
          ),
          Divider(
            thickness: 0.5,
            color: ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 100,
          ),
          SizedBox(
            height: getSize(16),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icDocument,
                  colorFilter: const ColorFilter.mode(
                    ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(24),
                  height: getSize(24),
                ),
                SizedBox(
                  width: getSize(16),
                ),
                const Text(
                  'History',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              // Get.toNamed(Routes.History);
            },
          ),
          Divider(
            thickness: 0.5,
            color: ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 100,
          ),
          SizedBox(
            height: getSize(16),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icWallet,
                  colorFilter: const ColorFilter.mode(
                    ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(24),
                  height: getSize(24),
                ),
                SizedBox(
                  width: getSize(16),
                ),
                const Text(
                  'Tours',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.TOUR);
            },
          ),
          Divider(
            thickness: 0.5,
            color: ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 100,
          ),
          SizedBox(
            height: getSize(32),
          ),
          InkWell(
            onTap: () {
              controller.signUserOut(context);
              Get.offNamed(Routes.AUTH);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.black.withOpacity(0.8),
                          width: 1,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: getSize(8)),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    AssetHelper.icoLogout,
                    color: ColorConstants.graySub,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
