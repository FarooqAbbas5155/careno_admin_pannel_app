import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';

class ScreenProviderVehicleDetails extends StatelessWidget {
  const ScreenProviderVehicleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Provider Details",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                fontFamily: "Quicksand"),
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: buildDetails()),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(flex: 1, child: buildDocumnets()),
                ],
              ).marginSymmetric(horizontal: 50.w, vertical: 20);
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetails(),
                    SizedBox(height: 10,),
                    buildDocumnets(),
                  ],
                ).marginSymmetric(horizontal: 50.w, vertical: 20),
              );
            }
          },
        ));
  }
  Widget buildDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding:
            EdgeInsets.only(left: 30.w, bottom: 30, top: 30, right: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Vehicle Details",
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Text(
                  "Kristin Watson",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: Colors.black),
                ),
                Text(
                  "Street 2, House No, City, New York, United State",
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Year:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: " 2020",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Type: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: "Sedan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    )
                  ],
                ).marginSymmetric(vertical: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Color:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: " Black",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Seats: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: " 05",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    )
                  ],
                ).marginSymmetric(vertical: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Transmission:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: "  Automatic",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Fuel Type: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: " Gasoline",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    )
                  ],
                ).marginSymmetric(vertical: 10.h),
                RichText(
                    text: TextSpan(
                        text: "Vehicle License Expiry Date:  ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: " 02 April, 2030",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.greyTextColor))
                        ])).marginSymmetric(vertical: 10.h),
                RichText(
                    text: TextSpan(
                        text: "Vehicle Plate Number: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: "  10-SY-118",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.greyTextColor))
                        ])).marginSymmetric(vertical: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Rate Per Day: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: "  \$ 150",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Rate Per Hour:  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  color: AppColors.greyHeadingTextColor),
                              children: [
                                TextSpan(
                                    text: " \$ 15",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.greyTextColor))
                              ])),
                    )
                  ],
                ).marginSymmetric(vertical: 10.h),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF828282)),
                  textAlign: TextAlign.start,
                ).marginSymmetric(vertical: 8.h),

              ],
            ),
          ).marginOnly(bottom: 10.h),

        ],
      ),
    );
  }

  Widget buildDocumnets() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50.w),
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Vehicle Images",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    fontFamily: "Quicksand",
                    color: Colors.black),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Container(
                    height: 175.h,
                    width: 185.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: AssetImage("assets/images/car_fornt.png")),
                    ),
                  ),
                  Container(
                    height: 175.h,
                    width: 185.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: AssetImage("assets/images/full_car.png")),
                    ),
                  ),
                  Container(
                    height: 175.h,
                    width: 185.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: AssetImage("assets/images/car_fornt.png")),
                    ),
                  ),
                  Container(
                    height: 175.h,
                    width: 185.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: AssetImage("assets/images/full_car.png")),
                    ),
                  ),
                  Container(
                    height: 175.h,
                    width: 185.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: AssetImage("assets/images/car_fornt.png")),
                    ),
                  ),
                  Container(
                    height: 175.h,
                    width: 185.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: AssetImage("assets/images/full_car.png")),
                    ),
                  ),
                ],
              ).marginSymmetric(vertical: 10.h),
              Text(
                "Vehicle Registration",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    fontFamily: "Quicksand",
                    color: Colors.black),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 193.h,
                  width: 328.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("assets/images/reg_vechile.png"),
                      )),
                ),
              ).marginAll(20),
            ],
          )),
    );
  }
}
