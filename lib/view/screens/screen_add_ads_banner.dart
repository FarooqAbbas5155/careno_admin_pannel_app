import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/file_pick.dart';
import '../../constant/helpers.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_listview_builder.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/custom_textfiled.dart';
import '../layouts/layout_active_vehicles.dart';

class ScreenAddAdsBanner extends StatefulWidget {
  String status;

  @override
  State<ScreenAddAdsBanner> createState() => _ScreenAddAdsBannerState();

  ScreenAddAdsBanner({
    required this.status,
  });
}

class _ScreenAddAdsBannerState extends State<ScreenAddAdsBanner> {

  // List<String> imageList = [];
  TextEditingController bannerDescriptionController = TextEditingController();
  TextEditingController bannerImageController = TextEditingController();
  TextEditingController DateImageController = TextEditingController();
  HomeController controller = Get.put(HomeController());
  RxList<String> vehicleMore = RxList([]);

  @override
  Widget build(BuildContext context) {
    print("imageList ${controller.BannerImages.value}");
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.backGroundColor,
          elevation: 1,
          title: Text("Promotional Banner",
          style: TextStyle(
              color: AppColors.appPrimaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 24.sp,
              fontFamily: "Nunito"
          ),
          )
      ),
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                        child: Text("Add New Banner",
                          style: AppColors.headingStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp),)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Banner Description", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Nunito",
                          fontSize: 22.sp),).marginOnly(top: 25.h, bottom: 5.h),
                      CustomTextField(
                        controller: bannerDescriptionController,
                        hint: "Add Description",
                        minLines: 1,
                        maxLines: 3,
                        padding: EdgeInsets.only(top: 4.h,left: 4.w),
                      ),
                      Text("Selecct Vehicel", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Nunito",
                          fontSize: 22.sp),).marginOnly(top: 25.h, bottom: 5.h),
                      GetBuilder(
                        init: Get.put(HomeController()),
                        builder: (HomeController logic) {
                          return CustomTextField(
                            controller: TextEditingController(
                                text: logic.bannerModel.value),
                            // controller: bannerUrlController,
                            text: logic.bannerModel.value.isEmpty
                                ? "Select Model Vehicle"
                                : logic.bannerModel.value,
                            readOnly: true,
                            onTap: () async {
                              var result = await Get.to(
                                  LayoutActiveVehicles(bannerModel: "Banner",));
                              if (result != null) {
                                log(result);
                                logic.bannerModel.value = result.toString();
                                // logic.bannerVehicleId.value=result[1].toString();
                                logic.update();
                              }
                            },
                          );
                        },),
                      Text("Banner Images", style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Nunito",
                          fontSize: 22.sp),).marginOnly(top: 25.h, bottom: 5.h),
        
                      StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              children: [
                                if(
                                controller.BannerImages.value
                                    .isNotEmpty)
                                  CustomListviewBuilder(
        
                                    itemBuilder: (
                                        BuildContext context,
                                        int index) {
                                      //var imageIndex = index;
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5.sp),
                                        height: Get.height * .18,
                                        width: Get.width*.6,
                                        decoration: BoxDecoration(
                                          // boxShadow: appBoxShadow,
                                          border: Border.all(
                                              color: Colors
                                                  .grey
                                                  .withOpacity(
                                                  0.3)),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(
                                              File(controller.BannerImages.value[index]),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount:
                                    controller.BannerImages.value
                                        .length,
                                    scrollDirection:
                                    CustomDirection
                                        .horizontal,
                                  ),
                                Align(
                                  alignment: Alignment
                                      .centerLeft,
                                  child: DottedBorder(
                                    color: Colors.black,
                                    strokeWidth: 1,
                                    borderType: BorderType
                                        .RRect,
                                    dashPattern: [3, 3],
                                    child: GestureDetector(
                                      onTap: () async {
                                        await PickFile(['png', 'jpg', 'jpeg'
                                        ]).then((value) {
                                          controller.BannerImages.value = value!.paths.map((e) => e.toString()).toList();
                                          setState(() {});
                                        });
                                      },
                                      child: Container(
                                          height: 10.h,
                                          width: 30.w,
                                          padding: EdgeInsets
                                              .all(8.sp),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(6)),
                                          child: SvgPicture.asset("assets/icons/banner.svg",color: AppColors.appPrimaryColor,)),
                                    ),
                                  ),
                                ),
        
                              ],),
                          );
                        },),
                      Obx(() {
                        return CustomButton(
                            loading: controller.BannerLoding.value,
                            title: widget.status, onPressed: () async {
                          String des = bannerDescriptionController.text;
                          if (controller.bannerVehicleId.value.isEmpty || des.isEmpty || controller.BannerImages.value == null) {
                            Get.snackbar(
                                "Alert", "Required All Fileds given below",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                          else {

                            await controller.AddPromotionalBanner(controller.bannerVehicleId.value, des, controller.BannerImages.value).then((value) {
                              controller.bannerVehicleId.value = "";
                              bannerDescriptionController.clear();
                              controller.BannerImages.value = [];
                            });
                          }
                        });
                      }).marginSymmetric(vertical: 30.h)
                    ],).marginSymmetric(horizontal: 15.w)
                ],),
            )
          ],
        ).marginSymmetric(vertical: 20.h),
      ),
    );
  }
  Widget AddBanner(VoidCallback onTap, String text, RxString imagePath) {
    return Obx(() {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          // margin: EdgeInsets.only(r.h),
          height: 89.h,
          width: 92.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: Color(0xFFC4C4C4).withOpacity(.3),
          ),
          child: (imagePath.value.isNotEmpty)
              ? Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r
              ),
              image: DecorationImage(
                image: FileImage(File(imagePath.value)),
                fit: BoxFit.fill,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: CustomSvg(
                name: "edit-car",
              ).marginOnly(top: 10.h, right: 10.w),
            ),
          )
              : Column(
            children: [
              Spacer(),
              CustomSvg(
                name: "camer-",
              ),
              Spacer(),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 6.sp,
                  fontFamily: "Nunito",
                  color: Colors.black.withOpacity(.5),
                ),
              ).marginSymmetric(horizontal: 5.w, vertical: 8.h),
            ],
          ),
        ),
      );
    });
  }

}
