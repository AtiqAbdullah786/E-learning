import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  const AppTextField({
    Key? key, required this.hintText, this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 1.sw,
      decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Padding(
        padding: EdgeInsets.only(left: 8.0.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:hintText,
              hintStyle: TextStyle(color: Colors.grey.shade700,fontSize: 15.sp)
            ),
          ),
        ),
      ),
    );
  }
}
