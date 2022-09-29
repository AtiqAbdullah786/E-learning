import 'dart:developer';

import 'package:e_learning/Constants/constant_colors.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../Widgets/custom_button.dart';
import 'Auth Screens/login_screen.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: 1.sw,
                height: 400.h,
                color: AppColors.secondary,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 330.h,
                    child: Image.asset(
                      'Images/girlwithbook.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reading Books',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Reading is',
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  Text(
                    'More  Fun',
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'A reader lives a thousand lives before',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    'he dies. The man who naver reads',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    'lives only one',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppButton(
                      title: 'Get Started',
                      onPressed: () {
                        Get.to(  LoginScreen());
                        log('Hello World');
                      })
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
