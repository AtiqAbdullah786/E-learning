import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFunctions extends GetxController {
  final TextEditingController emailLogin = TextEditingController();
  final TextEditingController passwordLogin = TextEditingController();
  final TextEditingController emailSignUp = TextEditingController();
  final TextEditingController passwordSignUp = TextEditingController();
  final TextEditingController nameSignUp = TextEditingController();
  String username = '';
  @override
  onInit()async {
    super.onInit();
    await getUserName();
  

  }


  Future<void> getUserName() async {
    try {
      var userName = FirebaseFirestore.instance.collection('Users');

      userName
          .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) {
        for (var element in snapshot.docs) {
          username = element.data()['name'];
        }
      });
    } catch (e) {
      log('Catch block of getUserName: ${e.toString()}');
    }
  }

  Future<void> login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailLogin.text,
      password: passwordLogin.text,
    );
  }

  Future<void> signUp() async {
    // showDialog(
    //     context: (context),
    //     barrierDismissible: false,
    //     builder: ((context) =>
    //       const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailSignUp.text, password: passwordSignUp.text);
      await createUser();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createUser() async {
    var users = FirebaseFirestore.instance.collection('Users');
    users.add({
      'name': nameSignUp.text,
      'email': emailSignUp.text,
      'userID': FirebaseAuth.instance.currentUser!.uid
    });
  }
}
