// ignore_for_file: use_super_parameters

import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../profile/profile_screen.dart';
import '../controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchVideoController searchController =
      Get.put(SearchVideoController());

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: InputDecoration(
              filled: false,
              hintText: StringConst.search.tr,
              hintStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? Center(
                child: Text(
                  '${StringConst.searchForUsers.tr}!',
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            homeController.userModel.value?.imgAvatar != null
                                ? NetworkImage(
                                    homeController.userModel.value?.imgAvatar ??
                                        "",
                                  )
                                : const NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fic_nodata.png?alt=media&token=51128304-2989-4d9e-84b2-81155f0d06f8",
                                  ),
                      ),
                      title: Text(
                        homeController.userModel.value?.firstName ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
