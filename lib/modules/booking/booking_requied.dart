import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/auth_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingRequiedScreen extends StatelessWidget {
  const BookingRequiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController _profileController = Get.find();
    final AuthController _authController = Get.put(AuthController());
    final _formKey = GlobalKey<FormState>();
    String _username = '';

    final List<Widget> tabs = [
      const Tab(text: 'Tab 1'),
      const Tab(text: 'Tab 2'),
      const Tab(text: 'Firebase'),
      const Tab(text: 'Tab 4'),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tab Example'),
            bottom: TabBar(
              isScrollable: true,
              tabs: tabs,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _profileController.clearController();
                Get.back();
              },
            ),
          ),
          body: TabBarView(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                    // child: PointChart(),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Get.toNamed(Routes.LOADING_IMAGE);
                      },
                      child: const Text("Loading images firebase"),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _profileController.emailController,
                              decoration: const InputDecoration(
                                hintText: 'enter your email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller:
                                  _profileController.firstNameController,
                              decoration: const InputDecoration(
                                hintText: 'enter your first name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _profileController.lastNameController,
                              decoration: const InputDecoration(
                                hintText: 'enter your last name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _profileController.passWordController,
                              decoration: const InputDecoration(
                                hintText: 'enter your password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller:
                                  _profileController.imageAvatarController,
                              decoration: const InputDecoration(
                                hintText: 'enter your image',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller:
                                  _profileController.phoneNumberController,
                              decoration: const InputDecoration(
                                hintText: 'enter your phone number',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getSize(48),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final UserModel userModel = UserModel(
                                    email: _profileController
                                        .emailController.text
                                        .trim(),
                                    firstName: _profileController
                                        .firstNameController.text
                                        .trim(),
                                    lastName: _profileController
                                        .lastNameController.text
                                        .trim(),
                                    passWord: _profileController
                                        .passWordController.text
                                        .trim(),
                                    imgAvatar: _profileController
                                        .imageAvatarController.text
                                        .trim(),
                                    phoneNub: _profileController
                                        .phoneNumberController.text
                                        .trim(),
                                    isActive: true,
                                  );

                                  _authController.signInPhoneAuthentication(
                                      _profileController
                                          .phoneNumberController.text
                                          .trim(),
                                      userModel);
                                }
                              },
                              child: const Text("Add Account"),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('userModel')
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<Row> accountWidgets = [];
                          if (snapshot.hasData) {
                            final accounts =
                                snapshot.data?.docs.reversed.toList();
                            for (var item in accounts!) {
                              final email = item['email'] ?? 'N/A';
                              final firstName = item['firstName'] ?? 'N/A';
                              final lastName = item['lastName'] ?? 'N/A';
                              final phoneNub = item['phoneNub'] ?? 'N/A';

                              final clientWidget = Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(email),
                                  Text(firstName),
                                  Text(lastName),
                                  Text(phoneNub),
                                  IconButton(
                                    onPressed: () {
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('userModel');
                                      collection.doc(item.id).delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                              accountWidgets.add(clientWidget);
                            }
                          }
                          return Expanded(
                            child: ListView(
                              children: accountWidgets,
                            ),
                          );
                        },
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(48),
                  color: Colors.blueAccent,
                  child: const Center(
                    child: Text(
                      'data 1',
                      style: TextStyle(color: Colors.red, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
