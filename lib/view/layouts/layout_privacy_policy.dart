
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../constant/colors.dart';
import '../../controllers/controller_policy.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_edit_policy.dart';

class LayoutPrivacyPolicy extends StatelessWidget {
  PolicyController _controller = Get.put(PolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<PolicyController>(
            init: _controller,
            builder: (controller) {
              return Obx(() {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text("Privacy Policy",
                            style: TextStyle(
                                color: AppColors.appPrimaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 24.sp,
                                fontFamily: "Nunito"
                            ),
                        ),
                      ),
                      controller.policy.value.isNotEmpty
                          ? Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.policy.value.length,
                                  itemBuilder: (context, index) {
                                    final existingTitle =
                                        controller.policy.value[index].title ??
                                            '';
                                    final existingDescription = controller
                                            .policy.value[index].description ??
                                        '';
                  
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  onChanged: (value) {
                                                    controller
                                                        .fields[index]
                                                        .PolicytitleController
                                                        .text = value.toString();
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Enter heading",
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .appPrimaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  readOnly: true,
                                                  controller:
                                                      TextEditingController(
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
                                              controller
                                                  .fields[index]
                                                  .PolicydescriptionController
                                                  .text = value.toString();
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Enter Description",
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                      AppColors.appPrimaryColor,
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
                                        color: AppColors.appPrimaryColor),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Get.to(ScreenEditPolicy());
                                      },
                                    ),
                                  ),
                                ).marginSymmetric(vertical: 20.h)
                              ],
                            )
                          : Obx(() => Column(
                                children: [
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
                                          controller
                                              .saveToFirestorePolicy()
                                              .then((value) {
                                            controller.response == "success";
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
                                ],
                              ))
                    ],
                  ),
                );
              }).marginSymmetric(horizontal: 20.w);
            }),
      ),
    );
  }
}
