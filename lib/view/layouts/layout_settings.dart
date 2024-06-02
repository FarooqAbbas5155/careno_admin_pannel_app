import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/colors.dart';
import '../../controllers/service_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfiled.dart';

class LayoutSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PercentageController _percentageController = Get.put(
        PercentageController());

    print("kjhskhjk ${_percentageController.categoryId}");
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.backGroundColor,
          elevation: 1,

          title: Text("Setting",
              style: TextStyle(
                  color: AppColors.appPrimaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 24.sp,
                  fontFamily: "Nunito"
              ),
          )
      ),
      backgroundColor: AppColors.backGroundColor,
      body: GetBuilder<PercentageController>(
          init: _percentageController,
          builder: (percentageController) {
            return Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    width: Get.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 15.h),
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.appPrimaryColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),

                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Update Settings",
                                style: AppColors.headingStyle.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.sp),)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Set Service Charges", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Nunito",
                                fontSize: 22.sp),).marginOnly(
                                top: 25.h, bottom: 5.h),
                            CustomTextField(
                              controller: percentageController.percentageController.value,
                              text: percentageController.percentageController.value.text,
                              keyboardType: TextInputType.number,
                            ),

                            CustomButton(
                                loading: percentageController.loading.value,
                                title: "Update", onPressed: () async {
                              await percentageController.SetPercentage();
                            }).marginSymmetric(vertical: 30.h)
                          ],).marginSymmetric(horizontal: 15.w)
                      ],),
                  )
                ],
              );
            });
          }).marginSymmetric(horizontal: 30.w, vertical: 20.h),
    );
  }
}
