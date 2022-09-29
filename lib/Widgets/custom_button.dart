import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/constant_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AppButton({
    Key? key, required this.title, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: 40.h,
          width: 150.w,
          decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          )),
    );
  }
}
