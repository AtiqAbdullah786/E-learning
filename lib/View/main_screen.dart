import 'package:e_learning/Constants/constant_colors.dart';
import 'package:e_learning/Constants/constant_lists.dart';
import 'package:e_learning/Controller/auth_controller.dart';
import 'package:e_learning/Controller/main_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Widgets/book_card.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final MainscreenController mainscreenController =
      Get.put(MainscreenController());
  final AuthFunctions authFunctions = Get.put(AuthFunctions());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(children: [
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, ${authFunctions.username}',
                    style: TextStyle(fontSize: 25.sp),
                  ),
                  CircleAvatar(
                      backgroundImage: const AssetImage('Images/person.jpg'),
                      radius: 20.r)
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.h,
                      width: 0.70.sw,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.r))),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              hintText: 'Search...'),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      mainscreenController
                          .toogleBookMark(mainscreenController.booksList[1].id);
                    }, // mainscreenController
                    //     .removeBookMark(mainscreenController.booksList[0].id);
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.r))),
                      child: Center(
                          child: Icon(
                        Icons.search,
                        color: mainscreenController.isSelecrted.value == true
                            ? Colors.white
                            : Colors.white,
                      )),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 27.h,
                width: 1.sw,
                child: ListView.builder(
                    itemCount: ConstantList.categoreyList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: InkWell(
                            onTap: () {
                              mainscreenController.selectedItem.value = index;

                              mainscreenController.getDataFromCategory(
                                  ConstantList.categoreyList[index]);
                            },
                            child: Obx(
                              () => Container(
                                height: 27.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                    color: index ==
                                            mainscreenController
                                                .selectedItem.value
                                        ? AppColors.primary
                                        : Colors.grey.shade300,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: Center(
                                    child: Text(
                                  ConstantList.categoreyList[index],
                                  style: TextStyle(
                                      color: index ==
                                              mainscreenController
                                                  .selectedItem.value
                                          ? Colors.white
                                          : Colors.black),
                                )),
                              ),
                            )),
                      );
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 1.sw,
                height: 0.70.sh,
                child: ListView.builder(
                    itemCount: mainscreenController.booksList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BookCard(
                        title: mainscreenController.booksList[index].title,
                        autherName:
                            mainscreenController.booksList[index].auther,
                        imageUrl:
                            mainscreenController.booksList[index].imageUrl,
                        voidCallback: () async {
                          await mainscreenController.toogleBookMark(
                              mainscreenController.booksList[index].id);

                          await mainscreenController.getData();
                          await mainscreenController.getBookMarks();
                        },
                        color: mainscreenController.booksList[index].bookMarks
                                .contains(
                                    FirebaseAuth.instance.currentUser!.uid)
                            ? Colors.teal
                            : Colors.grey,
                        likeButtonPressed: () async {
                          await mainscreenController.toogleLikes(
                              mainscreenController.booksList[index].id);
                          await mainscreenController.getData();
                          await mainscreenController.getBookMarks();
                        },
                        iconData: mainscreenController.booksList[index].likes
                                .contains(
                                    FirebaseAuth.instance.currentUser!.uid)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red.shade400,
                              )
                            : const Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                              ),
                      );
                    }),
              )
            ]),
          ),
        ),
      )),
    );
  }
}
