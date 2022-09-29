import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/Models/books_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class MainscreenController extends GetxController {
  RxBool isSelecrted = false.obs;
  RxInt selectedItem = 10.obs;
  RxList booksList = <BooksModel>[].obs;
  RxList bookMarksList = <BooksModel>[].obs;
  var imageurl = '';
  var bookmarksList2 = [];
  var likesList = [];

  @override
  // ignore: unnecessary_overrides
  onInit() async {
    super.onInit();
    await getData();
    await getBookMarks();
  }

  Future<void> toogleBookMark(String docID) async {
    try {
      var bookmarks1 =
          FirebaseFirestore.instance.collection('Books').doc(docID);
      await bookmarks1.get().then((snapshot) {
        log(snapshot['title']);
        bookmarksList2 = snapshot['BookMarks'];

        log(FirebaseAuth.instance.currentUser!.uid.toString());
        log(bookmarksList2.toString());
      });
      if (bookmarksList2.contains(FirebaseAuth.instance.currentUser!.uid)) {
        await removeBookMark(docID);
      } else {
        await bookmarks(docID);
      }
      bookmarksList2.clear();
    } catch (e) {
      log('Catch Block of toogleBookMark: ${e.toString()}');
    }
  }

  Future<void> toogleLikes(String docID) async {
    try {
      var likeBook =
          FirebaseFirestore.instance.collection('Books').doc(docID);
      await likeBook.get().then((snapshot) {
        log(snapshot['title']);
        likesList = snapshot['Likes'];

        log(FirebaseAuth.instance.currentUser!.uid.toString());
        log(likesList.toString());
      });
      if (likesList.contains(FirebaseAuth.instance.currentUser!.uid)) {
        await unLike(docID);
      } else {
        await like(docID);
      }
      likesList.clear();
    } catch (e) {
      log('Catch Block of toogleBookMark: ${e.toString()}');
    }
  }

  Future<void> removeBookMark(String docID) async {
    try {
      var bookmarks = FirebaseFirestore.instance.collection('Books');
      List<dynamic> bookmarked = [FirebaseAuth.instance.currentUser!.uid];
      bookmarks
          .doc(docID)
          .update({'BookMarks': FieldValue.arrayRemove(bookmarked)});
      await getData();
      await getBookMarks();
    } catch (e) {
      log('Catch Block of removeBookMark: ${e.toString()}');
    }
  }

  Future<void> unLike(String docID) async {
    try {
      var bookmarks = FirebaseFirestore.instance.collection('Books');
      List<dynamic> bookmarked = [FirebaseAuth.instance.currentUser!.uid];
      bookmarks
          .doc(docID)
          .update({'Likes': FieldValue.arrayRemove(bookmarked)});
      await getData();
      await getBookMarks();
    } catch (e) {
      log('Catch Block of removeBookMark: ${e.toString()}');
    }
  }

  Future<void> getDataFromCategory(String category) async {
    try {
      var books = FirebaseFirestore.instance.collection('Books');
      books.where('category', isEqualTo: category).get().then((snapshot) {
        booksList.clear();
        // for (var element in snapshot.docs) {
        //   booksList.add(BooksModel(
        //     id: element.reference.id,
        //     title: element.data()['title'],
        //     auther: element.data()['auther'],
        //     category: element.data()['category'],
        //     imageUrl: element.data()['imageUrl'],
        //   ));
        // }
      });
    } catch (e) {
      log('Catch Block of getDataFromCategory: ${e.toString()}');
    }
  }

  Future<void> getData() async {
    try {
      var books = FirebaseFirestore.instance.collection('Books');
      books.get().then((snapshot) {
        booksList.clear();
        for (var element in snapshot.docs) {
          booksList.add(BooksModel(
              id: element.reference.id,
              title: element.data()['title'],
              auther: element.data()['auther'],
              category: element.data()['category'],
              imageUrl: element.data()['imageUrl'],
              bookMarks: element['BookMarks'],
              likes: element['Likes']));
        }
      });
    } catch (e) {
      log('Catch Block of getData: ${e.toString()}');
    }
  }

  Future<void> bookmarks(String docId) async {
    var books = FirebaseFirestore.instance.collection('Books').doc(docId);

    books.update({
      'BookMarks':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    });
  }

  Future<void> like(String docId) async {
    var books = FirebaseFirestore.instance.collection('Books').doc(docId);

    books.update({
      'Likes': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    });
  }

  Future<void> getBookMarks() async {
    try {
      var books = FirebaseFirestore.instance.collection('Books');
      books
          .where('BookMarks',
              arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) {
        bookMarksList.clear();
        for (var element in snapshot.docs) {
          bookMarksList.add(BooksModel(
              id: element.reference.id,
              title: element.data()['title'],
              auther: element.data()['auther'],
              category: element.data()['category'],
              imageUrl: element.data()['imageUrl'],
              bookMarks: element['BookMarks'],
              likes: element['Likes']));
        }
      });
    } catch (e) {
      log('Catch Block of getBookMarks: ${e.toString()}');
    }
  }
}
