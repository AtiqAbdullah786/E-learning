import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String autherName;
  final String imageUrl;
  final VoidCallback voidCallback;
  final Color color;
  final VoidCallback likeButtonPressed;

  final Icon iconData;

  const BookCard(
      {Key? key,
      required this.title,
      required this.autherName,
      required this.imageUrl,
      required this.voidCallback,
      required this.color,
      required this.likeButtonPressed,
    
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 120.h,
        width: 1.sw,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(-1, 2),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
        child: Row(children: [
          Container(
              height: 120.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
              child: FadeInImage.assetNetwork(
                placeholder: 'Images/loading.gif',
                placeholderScale: 0.1,
                image: imageUrl,
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
              Text(
                autherName,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: voidCallback,
                    icon: Icon(
                      Icons.bookmark,
                      color: color,
                    ),
                  ),
                  IconButton(
                    onPressed: likeButtonPressed,
                    icon: iconData,
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
