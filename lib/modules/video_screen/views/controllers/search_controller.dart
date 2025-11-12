import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SearchVideoController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(FirebaseFirestore.instance
        .collection('userModel')
        .where('firstName', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var elem in query.docs) {
        // retVal.add(UserModel.fromSnapshot(elem));
      }
      return retVal;
    }));
  }
}
