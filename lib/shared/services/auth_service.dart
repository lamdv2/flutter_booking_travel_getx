import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/string_constants.dart';

class AuthService {
  final ProfileController profileController =
      Get.put<ProfileController>(ProfileController());

  final UserController userController = Get.put(UserController());

  final HomeController homeController = Get.put(HomeController());

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResult.user;

      if (user != null) {
        final existingUser =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(user.email!);

        if (existingUser.isNotEmpty) {
          if (!await profileController.isCheckExist(user.email ?? '')) {
            final UserModel userModel = UserModel(
              email: user.email ?? "",
              passWord: "",
              phoneNub: "",
              isActive: true,
            );
            profileController.createUser(userModel);
          }
        }
      }

      await homeController.getUserDetails(userController.userEmail.value);
      final fcmTokenGet = LocalStorageHelper.getValue('fcmToken') ?? "";
      profileController.createPushNotification(
        homeController.userModel.value?.id ?? "",
        fcmTokenGet,
      );

      return user;
    } catch (error) {
      Get.snackbar(StringConst.errorSigningInWithGoogle.tr, '$error');
      return null;
    }
  }
}
