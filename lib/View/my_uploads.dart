import 'package:e_learning/Constants/constant_colors.dart';
import 'package:e_learning/Controller/main_screen_controller.dart';
import 'package:e_learning/Controller/upload_controller.dart';
import 'package:e_learning/View/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/book_card.dart';

class MyUploads extends StatelessWidget {
  MyUploads({super.key});
  final UpladController upladController = Get.put(UpladController());
  final MainscreenController mainscreenController =
      Get.put(MainscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Uploads'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: upladController.booksList.length,
            itemBuilder: (BuildContext context, int index) {
              return BookCard(
                title: upladController.booksList[index].title,
                autherName: upladController.booksList[index].auther,
                imageUrl: upladController.booksList[index].imageUrl,
                voidCallback: () async {
                  await mainscreenController
                      .toogleBookMark(mainscreenController.booksList[index].id);

                  await mainscreenController.getData();
                  await mainscreenController.getBookMarks();
                },
                color: mainscreenController.booksList[index].bookMarks
                        .contains(FirebaseAuth.instance.currentUser!.uid)
                    ? Colors.teal
                    : Colors.grey,
                likeButtonPressed: () async {
                  await mainscreenController
                      .toogleLikes(mainscreenController.booksList[index].id);
                  await mainscreenController.getData();
                  await mainscreenController.getBookMarks();
                },
                iconData: mainscreenController.booksList[index].likes
                        .contains(FirebaseAuth.instance.currentUser!.uid)
                    ?  Icon(
                        Icons.favorite,
                        color: Colors.red.shade400,
                      )
                    : const Icon(Icons.favorite_outline,color: Colors.grey,),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.to(const UploadScreen());
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
