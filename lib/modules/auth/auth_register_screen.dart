import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/assets_helper.dart';
import '../../shared/services/auth_service.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_textfield.dart';
import '../../shared/widgets/square_tile.dart';
import 'auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final Function()? onTap;
  RegisterScreen({super.key, this.onTap});

  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon
                const SizedBox(
                  height: 12,
                ),
                const Icon(
                  Icons.ac_unit,
                  size: 100,
                ),

                //welcome
                const SizedBox(
                  height: 38,
                ),
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),

                //username
                const SizedBox(
                  height: 26,
                ),
                MyTextField(
                  controller: controller.registerEmailController,
                  hintText: "Enter your email",
                  obscureText: false,
                ),

                //password
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                  controller: controller.registerPasswordController,
                  hintText: "Enter your password",
                  obscureText: true,
                ),

                //confirm password
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                  controller: controller.registerConfirmPasswordController,
                  hintText: "Confirm your password",
                  obscureText: true,
                ),

                //Btn Sign In
                const SizedBox(
                  height: 45,
                ),
                MyButton(
                  onTap: () {
                    controller.register(context);
                  },
                  textBtn: 'Sign Up',
                ),

                //divider continue
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text(
                        " or continue with ",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                // google + apple signin button
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imgPath: AssetHelper.imgGoogle,
                    ),

                    //Image(image: AssetImage('lib/images/apple.png'), height: 30,),
                    const SizedBox(
                      width: 24,
                    ),

                    // apple
                    SquareTile(
                      onTap: () {},
                      imgPath: AssetHelper.imgApple,
                    ),
                  ],
                ),

                // not a member? register
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have a account ?',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
