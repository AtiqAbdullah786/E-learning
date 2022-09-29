import 'package:e_learning/Constants/constant_colors.dart';
import 'package:e_learning/View/bookmarks_screen.dart';
import 'package:e_learning/View/main_screen.dart';
import 'package:e_learning/View/my_uploads.dart';
import 'package:e_learning/View/settings_screen.dart';

import 'package:flutter/material.dart';

class BotttomNavBar extends StatefulWidget {
  const BotttomNavBar({super.key});

  @override
  State<BotttomNavBar> createState() => _BotttomNavBarState();
}

class _BotttomNavBarState extends State<BotttomNavBar> {
  int currentIndex = 0;
  final screens = [MainScreen(), BookMarkScreen(),   MyUploads(),const SettingScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: ((value) {
            setState(() {
              currentIndex = value;
            });
          }),
          elevation: 10,
          unselectedItemColor: Colors.black,
          selectedItemColor: AppColors.primary,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border), label: 'Bookmarks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload_outlined), label: 'Upload'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Settings')
          ]),
    );
  }
}
