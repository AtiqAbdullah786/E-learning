import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/constant_colors.dart';

class AppLoadingIndicator extends StatelessWidget {
  final String title;
  const AppLoadingIndicator({
    Key? key, required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          )
        ]),
      ),
    ));
  }
}
