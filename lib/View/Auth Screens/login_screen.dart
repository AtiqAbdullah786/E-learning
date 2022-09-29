import 'package:e_learning/Constants/constant_colors.dart';
import 'package:e_learning/Controller%20Bindings/controller_binding.dart';
import 'package:e_learning/Controller/auth_controller.dart';
import 'package:e_learning/Controller/main_screen_controller.dart';
import 'package:e_learning/Controller/upload_controller.dart';
import 'package:e_learning/View/Auth%20Screens/sign_up_screen.dart';
import 'package:e_learning/View/bottom_navigationbar.dart';

import 'package:e_learning/Widgets/custom_button.dart';
import 'package:e_learning/Widgets/custom_textfield.dart';
import 'package:e_learning/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthFunctions authFunctions = Get.put(AuthFunctions());
  final MainscreenController mainscreenController =
      Get.put(MainscreenController());
  final UpladController upladController = Get.put(UpladController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                 ControllerBinding();
                return const BotttomNavBar();
              } else {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'Images/logo1.png',
                            height: 150,
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                          AppTextField(
                            hintText: 'Email',
                            textEditingController: authFunctions.emailLogin,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextField(
                            hintText: 'Password',
                            textEditingController: authFunctions.passwordLogin,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              TextButton(
                                  onPressed: () {
                                    Get.to(SignUpScreen());
                                  },
                                  child: const Text('Sign Up',
                                      style:
                                          TextStyle(color: AppColors.primary)))
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppButton(
                              title: 'Log in',
                              onPressed: () {
                                authFunctions.login();
                              })
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
