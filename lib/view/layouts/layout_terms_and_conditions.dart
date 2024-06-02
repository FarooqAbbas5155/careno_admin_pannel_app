import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/colors.dart';
import '../../controllers/controller_terms_and_conditons.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_edit_terms_and_conditions.dart';


class LayoutTermsAndConditions extends StatelessWidget {
  final TermsController _controller = Get.put(
      TermsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<TermsController>(
          init: _controller,
          builder: (controller) {
            return SingleChildScrollView(
              child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Terms and Conditions",
                        style:TextStyle(
                            color: AppColors.appPrimaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 24.sp,
                            fontFamily: "Nunito"
                        ),                  ),
                    SizedBox(height: 20.h),
                    controller.terms.value.isNotEmpty ? Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.terms.value.length,
                          itemBuilder: (context, index) {
                            final existingTitle = controller.terms.value[index]
                                .title ??
                                '';
                            final existingDescription = controller.terms
                                .value[index]
                                .description ?? '';

                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24.sp,
                                          ),
                                          readOnly: true,
                                          onChanged: (value) {
                                            controller.fields[index]
                                                .TermstitleController.text =
                                                value.toString();
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Enter Title",
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.appPrimaryColor,
                                              ),
                                            ),
                                          ),
                                          controller: TextEditingController(
                                              text: existingTitle),
                                        ),
                                      ),
                                      // Show edit icon if data exists
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  TextField(
                                    readOnly: true,
                                    minLines: 2,
                                    maxLines: 40,
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                    onChanged: (value) {
                                      controller.fields[index]
                                          .TermsdescriptionController.text =
                                          value.toString();
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Description",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.appPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    controller: TextEditingController(
                                        text: existingDescription),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.appPrimaryColor
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.white,),
                              onPressed: () {
                                Get.to(ScreenEditTermsAndConditions());
                              },
                            ),
                          ),
                        ).marginSymmetric(vertical: 20.h),

                      ],
                    ) :
                    Obx(() =>
                        Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.fields.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        style: TextStyle(fontFamily: "Nunito",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 24.sp),
                                        decoration: InputDecoration(
                                          hintText: "Enter heading",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .appPrimaryColor), // Set border color to red
                                          ),
                                        ),
                                        controller: controller.fields[index]
                                            .TermstitleController,
                                      ),
                                      SizedBox(height: 10.h),
                                      TextField(
                                        minLines: 2,
                                        maxLines: 40,
                                        style: TextStyle(fontFamily: "Nunito",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
                                        decoration: InputDecoration(
                                          hintText: "Enter Description",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors
                                                    .appPrimaryColor), // Set border color to red
                                          ),
                                        ),
                                        controller: controller.fields[index]
                                            .TermsdescriptionController,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.appPrimaryColor
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add, color: Colors.white,),
                                  onPressed: () {
                                    controller
                                        .addField(); // Adds a new field when the '+' icon is pressed
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Obx(() {
                              return Center(
                                child: CustomButton(
                                  loading: controller.uploading.value,
                                  width: 600.w,
                                  title: "Submit",
                                  onPressed: () {
                                    controller.saveToFirestoreTermsAndConditons()
                                        .then((value) {
                                      controller.response == "success";
                                    });
                                    // Handle submit button action
                                  },
                                ),
                              );
                            }).marginSymmetric(vertical: 20.h),
                          ],
                        ))

                  ],
                );
              }).marginSymmetric(horizontal: 20.w),
            );
          }),
    );
  }
}