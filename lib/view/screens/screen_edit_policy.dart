import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/colors.dart';
import '../../controllers/controller_policy.dart';
import '../../widgets/custom_button.dart';

class ScreenEditPolicy extends StatelessWidget {
  final PolicyController _controller = Get.put(PolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Terms and Conditions', style: TextStyle(
            color: AppColors.appPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 24.sp,
            fontFamily: "Nunito"
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<PolicyController>(
            init: _controller,
            builder: (controller) {
              return Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.h, horizontal: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),

                        itemCount: controller.policy.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              TextField(
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24.sp,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Update Heading",

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.appPrimaryColor,
                                    ),
                                  ),
                                ),
                                controller: TextEditingController(
                                    text: controller.policy[index].title ?? ""),
                                onChanged: (value) {
                                  controller.policy[index].title = value;
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextField(
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Update Description",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.appPrimaryColor,
                                    ),
                                  ),
                                ),
                                controller: TextEditingController(
                                    text: controller.policy[index]
                                        .description ??
                                        ""),
                                onChanged: (value) {
                                  controller.policy[index].description = value;
                                },
                                maxLines: null, // Allow multiline input
                              ),
                              SizedBox(height: 20.h),

                            ],
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.fields.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  style: TextStyle(
                                      fontFamily: "Nunito",
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
                                      .PolicytitleController,
                                ),
                                SizedBox(height: 10.h),
                                TextField(
                                  minLines: 2,
                                  maxLines: 40,
                                  style: TextStyle(
                                      fontFamily: "Nunito",
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
                                      .PolicydescriptionController,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.0),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.enableAddNew.value == false ? Obx(() {
                              return CustomButton(
                                loading: controller.uploading.value,
                                width: 100.w,
                                onPressed: () {
                                  // Iterate through each term and update it in the database
                                  for (int index = 0; index <
                                      controller.policy.length; index++) {
                                    // Get the updated title and description
                                    String updatedTitle = controller
                                        .policy[index]
                                        .title ??
                                        '';
                                    String updatedDescription = controller
                                        .policy[index]
                                        .description ?? '';

                                    // Call the method to update the field in the database
                                    controller.updateField(index, updatedTitle, updatedDescription).then((value) {
                                      controller.uploading.value = false;
                                    });
                                  }

                                  // Navigate back to the previous screen
                                  Get.back();
                                },
                                title: 'Save',
                              );
                            }) :
                            Obx(() {
                              return Center(
                                child: CustomButton(
                                  loading: controller.uploading.value,
                                  width: 110.w,
                                  title: "Submit",
                                  onPressed: () {
                                    controller.saveToFirestorePolicy()
                                        .then((value) {
                                      controller.response == "success";
                                      controller.enableAddNew.value = false;
                                      controller.fields.length = 0;

                                      //     ? showBottomSheet(
                                      //         context: context,
                                      //         builder:
                                      //             (BuildContext context) {
                                      //           return Container(
                                      //             color: AppColors
                                      //                 .appPrimaryColor,
                                      //             height: 100,
                                      //             child: Center(
                                      //               child: Text(
                                      //                 'Data saved successfully!',
                                      //                 style: TextStyle(
                                      //                     color:
                                      //                         Colors.white,
                                      //                     fontWeight:
                                      //                         FontWeight
                                      //                             .w800,
                                      //                     fontFamily:
                                      //                         "Nunito"),
                                      //               ),
                                      //             ),
                                      //           );
                                      //         },
                                      //       )
                                      //     : showBottomSheet(
                                      //         context: context,
                                      //         builder:
                                      //             (BuildContext context) {
                                      //           return Container(
                                      //             color: AppColors
                                      //                 .appPrimaryColor,
                                      //             height: 100,
                                      //             child: Center(
                                      //               child: Text(
                                      //                 controller.response
                                      //                     .toString(),
                                      //                 style: TextStyle(
                                      //                     color:
                                      //                         Colors.white,
                                      //                     fontWeight:
                                      //                         FontWeight
                                      //                             .w800,
                                      //                     fontFamily:
                                      //                         "Nunito"),
                                      //               ),
                                      //             ),
                                      //           );
                                      //         });
                                      // Get.back();
                                    });
                                    // Handle submit button action
                                  },
                                ),
                              );
                            }).marginSymmetric(vertical: 20.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.appPrimaryColor),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    controller.enableAddNew.value = true;
                                    controller
                                        .addField(); // Adds a new field when the '+' icon is pressed
                                  },
                                ),
                              ),
                            ),

                          ],
                        );
                      }),
                    ],
                  ),
                );
              });
            }),
      ),
    );
  }
}
