import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/colors.dart';
import '../../constant/file_pick.dart';
import '../../constant/firebase_utils.dart';
import '../../constant/helpers.dart';
import '../../controllers/home_controller.dart';
import '../../models/categories.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfiled.dart';

class ScreenAddCategories extends StatefulWidget {
  final String status;
  final Category? category;

  ScreenAddCategories({required this.status, this.category});

  @override
  State<ScreenAddCategories> createState() => _ScreenAddCategoriesState();
}

class _ScreenAddCategoriesState extends State<ScreenAddCategories> {
  File? _pickedImageData;
  TextEditingController categoryText = TextEditingController();
  TextEditingController categoryImage = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImageData = File(image.path);
        categoryImage.text = _pickedImageData!.path.split('/').last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.backGroundColor,
        elevation: 1,
        shadowColor: AppColors.appPrimaryColor,
        title: Text(
          "Category",
          style: TextStyle(
            color: AppColors.appPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 30.sp,
            fontFamily: "Nunito",
          ),
        ),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add New Category",
                        style: AppColors.headingStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category Title",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Nunito",
                          fontSize: 22.sp,
                        ),
                      ).marginOnly(top: 25.h, bottom: 5.h),
                      CustomTextField(
                        hint: "Enter Category Title",
                        controller: categoryText,
                        text: widget.status == "Update"
                            ? widget.category?.name ?? "Category Name"
                            : categoryText.text,
                      ),
                      Text(
                        "Category Image",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Nunito",
                          fontSize: 22.sp,
                        ),
                      ).marginOnly(top: 25.h, bottom: 5.h),
                      CustomTextField(
                        readOnly: true,
                        onTap: _pickImage,
                        padding: EdgeInsets.only(top: 20.h, left: 20.w),
                        text: categoryImage.text.isNotEmpty
                            ? categoryImage.text
                            : "Choose file",
                        controller: categoryImage,
                        prefix: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 5.w),
                          decoration: BoxDecoration(
                            color: Color(0xFf767676).withOpacity(.76),
                            border: Border.all(
                              color: Color(0xFF767676).withOpacity(.76),
                            ),
                          ),
                          child: Text(
                            "Choose File",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w500,
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                      ),
                      if (_pickedImageData != null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 20.h),
                          padding: EdgeInsets.all(10.h),
                          height: 150,
                          width: 150,
                          child: Image.file(_pickedImageData!),
                        ),
                      if (widget.status == "Update" && _pickedImageData == null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 20.h),
                          padding: EdgeInsets.all(10.h),
                          height: 150,
                          width: 150,
                          child: Image.network(widget.category!.image),
                        ),
                      CustomButton(
                        title: widget.status,
                        onPressed: () async {
                          String name = categoryText.text;
                          if (widget.status == "Submit") {
                            if (_pickedImageData != null) {
                              int id = DateTime.now().millisecondsSinceEpoch;
                              String imageUrl = await FirebaseUtils.uploadImage(
                                  _pickedImageData!.toString(),
                                  "categories/images/${id.toString()}");

                              Category category = Category(
                                  id: id.toString(), name: name, image: imageUrl);
                              await categoryRef.doc(id.toString()).set(category.toMap()).then((value) {
                                Get.snackbar(
                                  "Category",
                                  "Added category ${category.toString()}",
                                  backgroundColor: AppColors.appPrimaryColor,
                                  colorText: Colors.white,
                                );
                                categoryText.clear();
                                setState(() {
                                  _pickedImageData = null;
                                  categoryImage.text = "";
                                });
                              }).catchError((onError) {
                                print(onError.toString());
                              });
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please select an image.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          } else {
                            if (_pickedImageData != null) {
                              String imageUrl = await FirebaseUtils.uploadImage(
                                  _pickedImageData!.toString(),
                                  "categories/images/${widget.category!.id}");
                              await categoryRef.doc(widget.category!.id).update({
                                "name": name,
                                "image": imageUrl,
                              });
                              Get.snackbar(
                                "Successfully",
                                name,
                                backgroundColor: AppColors.appPrimaryColor,
                                colorText: Colors.white,
                              );
                            } else {
                              await categoryRef.doc(widget.category!.id).update({"name": name});
                              Get.snackbar(
                                "Update",
                                name,
                                backgroundColor: AppColors.appPrimaryColor,
                                colorText: Colors.white,
                              );
                            }
                          }
                        },
                      ).marginSymmetric(vertical: 30.h),
                    ],
                  ).marginSymmetric(horizontal: 15.w),
                ],
              ),
            ),
          ],
        ).marginSymmetric(horizontal: 30.w, vertical: 20.h),
      ),
    );
  }
}
