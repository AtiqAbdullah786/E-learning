import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/Controller/main_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Models/books_model.dart';

class UpladController extends GetxController {
  final TextEditingController titleController = TextEditingController();

  RxBool isUploaded = true.obs;
  final TextEditingController autherController = TextEditingController();
  final MainscreenController mainscreenController =
      Get.put(MainscreenController());
  RxList booksList = <BooksModel>[].obs;
  String imageUrl = '';
  RxString initialValue = 'Business'.obs;

  @override
  onInit() async {
    super.onInit();
    await myUploads();
  }

  Future<void> uploadFile(File image) async {
    try {
      isUploaded.value = false;
      final imgId = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref('Books');
      final imgRef = storageRef.child('path_$imgId');
      var uploadTask = imgRef.putFile(image);
      uploadTask.whenComplete(() async {
        var url = await imgRef.getDownloadURL();
        imageUrl = url;
        addBook();
        mainscreenController.getData();
      });
    } catch (e) {
      log('Catch Block of uploadFile: ${e.toString()}');
    }
  }

  Future<void> addBook() async {
    try {
      var books = FirebaseFirestore.instance.collection('Books');
      books.add({
        'title': titleController.text,
        'uploadBy': FirebaseAuth.instance.currentUser!.uid,
        'auther': autherController.text,
        'category': initialValue.value,
        'imageUrl': imageUrl,
        'BookMarks': [],
        'Likes':[]
      }).then((value) {
        titleController.clear();
        autherController.clear();
        isUploaded.value = true;
        Get.snackbar('Book', 'Uploaded Sussessfully',
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (e) {
      log('Catch Block of addBook: ${e.toString()}');
    }
  }

  Future<void> myUploads() async {
    try {
      var books = FirebaseFirestore.instance.collection('Books');
      books
          .where('uploadBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) {
        booksList.clear();
        for (var element in snapshot.docs) {
          booksList.add(BooksModel(
            id: element.reference.id,
            title: element.data()['title'],
            auther: element.data()['auther'],
            category: element.data()['category'],
            imageUrl: element.data()['imageUrl'],
            bookMarks: element['BookMarks'],
            likes: element['Likes']
          ));
        }
        log(booksList.toString());
      });
    } catch (e) {
      log('Catch Block of getData: ${e.toString()}');
    }
  }
}
