import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_learning/Constants/categories.dart';
import 'package:e_learning/Controller/main_screen_controller.dart';
import 'package:e_learning/Controller/upload_controller.dart';
import 'package:e_learning/Widgets/custom_button.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../Constants/constant_colors.dart';
import '../Widgets/custom_progress_indicator.dart';
import '../Widgets/custom_textfield.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? pickedImage;
  final MainscreenController mainscreenController =
      Get.put(MainscreenController());

  final UpladController uploadController = Get.put(UpladController());

  Future pickImage() async {
    final XFile? tempimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempimage!.path);
    });

    //imagePath = image!.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload a Book'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() => uploadController.isUploaded.value == false
          ? const AppLoadingIndicator(
              title: 'Uploading..',
            )
          : SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      height: 300.h,
                      width: 1.sw,
                      color: Colors.grey.shade300,
                      child: pickedImage == null
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 80.r,
                                ),
                                const Text('Select Book Cover'),
                              ],
                            ))
                          : Image.file(pickedImage!),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 50.h,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonElevation: 0,
                            buttonWidth: 1.sw,
                            buttonHeight: 50.h,
                            value: uploadController.initialValue.value,
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 15.sp),
                            items: Categories.categories.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              uploadController.initialValue.value =
                                  value.toString();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextField(
                      hintText: 'Book Title',
                      textEditingController: uploadController.titleController),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTextField(
                    hintText: 'Auther Name',
                    textEditingController: uploadController.autherController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppButton(
                    title: 'Upload',
                    onPressed: () async {
                      uploadController.isUploaded.value = false;

                      await uploadController.uploadFile(pickedImage!);
                      
                      setState(() {
                        pickedImage = null;
                      });
                    },
                  )
                ],
              ),
            ))),
    );
  }
}
