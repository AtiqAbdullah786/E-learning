import 'dart:developer';

import 'package:e_learning/Widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
            title: 'Sign Out',
            onPressed: (() {
              FirebaseAuth.instance.signOut();
            })),
        SizedBox(
          height: 20.h,
        ),
        AppButton(
            title: 'User ID',
            onPressed: () {
              log('User ID: ${FirebaseAuth.instance.currentUser!.uid}');
            })
      ],
    )));
  }
}
