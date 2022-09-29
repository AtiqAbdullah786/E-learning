import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Controller Bindings/controller_binding.dart';
import 'View/home_page.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
 await Firebase.initializeApp();
  runApp(ScreenUtilInit(
    designSize: const Size(360, 690),

    builder: (BuildContext context, Widget? child) => GetMaterialApp(
      initialBinding: ControllerBinding(),
      title: 'E-Learning',
      home: const HomePage(),
    ),
  ));
}
