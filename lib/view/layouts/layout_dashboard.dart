
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../controllers/home_controller.dart';
import '../screens/screeb_block_customer_list.dart';
import '../screens/screen_block_provider_list.dart';
import '../screens/table.dart';

class LayoutDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashborad",
                style: TextStyle(
                    color: AppColors.appPrimaryColor,
                    fontFamily: "Nunito",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w800),
              ),
              Wrap(
                spacing: 20,
                runSpacing: 20,
          
                children: [
                  CustomContainer(Color(0xff0085cc),
                      ("${controller.categories.value.length}").obs,
                      "Total Categories",
                      "category.png", () {
                        Get.to(CustomTable());
                      }),
                  Obx(() {
                    return CustomContainer(
                        Color(0xff27b097),
                        controller.user.value.length.toString().obs,
                        "Total Users",
                        "user.png", () {});
                  }),
                  Obx(() {
                    return CustomContainer(Color(0xffff5252),
                        controller.Blockuser.value.length.toString().obs,
                        "Blocked Users",
                        "block_user.png", () {
                          Get.to(ScreebBlockCustomerList());
                        });
                  }),
                  Obx(() {
                    return CustomContainer(
                        Color(0xffafc23b),
                        controller.host.value.length.toString().obs,
                        "Total Providers",
                        "provider.png", () {});
                  }),
                  Obx(() {
                    return CustomContainer(Color(0xff0a9bb0),
                        controller.Blockhost.value.length.toString().obs,
                        "Blocked Providers",
                        "block_provider.png", () {
                          Get.to(ScreenBlockProviderList());
                        });
                  }),
                  Obx(() {
                    return CustomContainer(Color(0xff7f3bc2),
                        controller.hostRequest.value.length.toString().obs,
                        "Providers Requests",
                        "provider_request.png", () {
                          // Get.to(Screen)
                        });
                  }),
                  Obx(() {
                    return CustomContainer(Color(0xff3f51b5),
                        controller.vehiclesRequest.value.length.toString().obs,
                        "Vehicles Requests",
                        "vehicle_request.png", () {});
                  }),
                  Obx(() {
                    return CustomContainer(
                        AppColors.appPrimaryColor.withOpacity(.8),
                        controller.message.value.length
                            .toString()
                            .isEmpty ? ("0").obs : controller.message.value.length
                            .toString().obs, "Messages",
                        "message.png", () {});
                  }),
                ],
              ),
            ],
          ),
        );
      }).marginSymmetric(horizontal: 30.w, vertical: 20.h),
    );
  }
}

Widget CustomContainer(Color color, RxString itemLength, title, imagepath,
    VoidCallback voidCallback) {
  return Container(
    height: 160.h,
    width: 313.w,
    decoration:
    BoxDecoration(color: color, borderRadius: BorderRadius.circular(5.r)),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Text(
                  itemLength.value,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nunito",
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700),
                );
              }).marginOnly(top: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        fontFamily: "Nunito"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Image.asset(
                      "assets/images/${imagepath}",
                      height: 55.h,
                      width: 60.w,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: voidCallback,
            child: Container(
              color: Colors.transparent.withOpacity(.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "More Info",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        fontFamily: "Nunito"),
                  ).marginSymmetric(horizontal: 10.w),
                  Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: color,
                      size: 10.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
