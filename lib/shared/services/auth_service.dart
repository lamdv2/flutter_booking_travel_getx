import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final ProfileController _profileController =
      Get.put<ProfileController>(ProfileController());

  // //  google sign in
  // signInWithGoogle() async {
  //   //  begin interactive sign in process
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  //   //  obtain auth details from request
  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //   //  create a new credential for user
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken, idToken: gAuth.idToken);

  //   if (credential) {
  //     final UserModel userModel = UserModel(email: email, passWord: passWord, phoneNub: phoneNub, isActive: isActive)
  //     _profileController.createUser(userModel);
  //   }

  //   // finally, lets sign in
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        // Google Sign-In was cancelled
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResult.user;

      if (user != null) {
        // final existingUser =
        //     await FirebaseAuth.instance.fetchSignInMethodsForEmail(user.email!);

        // if (existingUser.isEmpty) {

        // }
        final UserModel userModel = UserModel(
          email: user.email ?? "",
          passWord: "",
          phoneNub: "",
          isActive: true,
        );
        await _profileController.createUser(userModel);
      }

      return user;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }
}
