import 'package:e_learning/Controller/auth_controller.dart';
import 'package:e_learning/View/Auth%20Screens/login_screen.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Constants/constant_colors.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final AuthFunctions authFunctions = Get.put(AuthFunctions());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  height: 50.h,
                ),
                 AppTextField(hintText: 'Username',
                textEditingController: authFunctions.nameSignUp,
                ),
                SizedBox(
                  height: 10.h,
                ),
             
                AppTextField(
                  hintText: 'Email',
                  textEditingController: authFunctions.emailSignUp,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  hintText: 'Password',
                  textEditingController: authFunctions.passwordSignUp,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                        onPressed: () {
                          Get.to(LoginScreen());
                        },
                        child: const Text('Login',
                            style: TextStyle(color: AppColors.primary)))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppButton(
                    title: 'Sign Up',
                    onPressed: () {
                      authFunctions.signUp();
  
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
