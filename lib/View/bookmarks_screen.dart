import 'dart:developer';

import 'package:e_learning/Controller/main_screen_controller.dart';
import 'package:e_learning/Widgets/book_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMarkScreen extends StatelessWidget {
  BookMarkScreen({super.key});
  final MainscreenController mainscreenController =
      Get.put(MainscreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Book Marks'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                mainscreenController.getBookMarks();
                log('Hello world');
              },
              icon: const Icon(Icons.add),
            ),
          ),
          body: ListView.builder(
              itemCount: mainscreenController.bookMarksList.length,
              itemBuilder: (BuildContext context, int index) {
                return BookCard(
                  title: mainscreenController.bookMarksList[index].title,
                  autherName: mainscreenController.bookMarksList[index].auther,
                  imageUrl: mainscreenController.bookMarksList[index].imageUrl,
                  voidCallback: () {},
                  color: Colors.teal,
                                          likeButtonPressed: () async {
                          await mainscreenController.toogleLikes(
                              mainscreenController.booksList[index].id);
                          await mainscreenController.getData();
                          await mainscreenController.getBookMarks();
                        },
                                               iconData: mainscreenController.booksList[index].likes
                                .contains(
                                    FirebaseAuth.instance.currentUser!.uid)
                            ?  Icon(
                        Icons.favorite,
                        color: Colors.red.shade400,
                      )
                    : const Icon(Icons.favorite_outline,color: Colors.grey,),
                );
              })),
    );
  }
}
