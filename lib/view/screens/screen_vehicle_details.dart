import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../models/add_host_vehicle.dart';
import '../../models/categories.dart';
import '../../models/user.dart ' as model;
import '../../widgets/custom_button.dart';

class ScreenVehicleDetails extends StatelessWidget {
 String status;
 String? userType;
 AddHostVehicle? vehicle;


 model.User? host;
 Category? categoty;

 @override


 Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Vehicle Details",
            style: TextStyle(
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                fontFamily: "Quicksand"),
          ),
        ),
        body:FutureBuilder<DocumentSnapshot>(
          future: usersRef.doc(vehicle!.hostId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(backgroundColor:AppColors.appPrimaryColor,),
              );
            }
            final doc = snapshot.data;
            host = model.User.fromMap(doc!.data() as Map<String,dynamic>);
            return FutureBuilder<Category>(
              future: getCategory(vehicle!.vehicleCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(backgroundColor:AppColors.appPrimaryColor,),
                  );
                }
                categoty = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetails(),
                      SizedBox(height: 10,),
                      buildDocumnets(),
                    ],
                  ).marginSymmetric(horizontal: 30.w, vertical: 20),
                );
              }
            );
          }
        ));
    }

  Widget buildDetails() {
    DateTime dobDateTime = DateTime.fromMillisecondsSinceEpoch(host!.dob);
    String formattedDate = DateFormat('d MMMM yyyy ').format(dobDateTime);
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Vehicle Details:",
              style: TextStyle(
                  fontFamily: "Quicksand",
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            Text(
              host!.name,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: Colors.black),
            ),
            Text(
             host!.address,
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
                            text: " ${vehicle!.vehicleYear}",
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
                            text: "${categoty!.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.greyTextColor))
                      ])),
                )
              ],
            ).marginSymmetric(vertical: 10.h),
            Divider(endIndent: 20,indent: 1,color: AppColors.appPrimaryColor.withOpacity(.2),),

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
                            text: " ${vehicle!.vehicleColor}",
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
                              color: AppColors.appPrimaryColor),
                          children: [
                        TextSpan(
                            text: " ${vehicle!.vehicleSeats}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.greyTextColor))
                      ])),
                )
              ],
            ).marginSymmetric(vertical: 10.h),
            Divider(endIndent: 20,indent: 1,color: AppColors.appPrimaryColor.withOpacity(.2),),

            Row(
              children: [
                Expanded(
                  child: RichText(
                      text: TextSpan(
                          text: "Transmission:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp,
                              color:AppColors.greyHeadingTextColor),
                          children: [
                        TextSpan(
                            text: "  ${vehicle!.vehicleTransmission}",
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
                              color: AppColors.appPrimaryColor),
                          children: [
                        TextSpan(
                            text: " ${vehicle!.vehicleFuelType}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.greyTextColor))
                      ])),
                )
              ],
            ).marginSymmetric(vertical: 10.h),
            Divider(endIndent: 20,indent: 1,color: AppColors.appPrimaryColor.withOpacity(.2),),

            RichText(
                text: TextSpan(
                    text: "Vehicle License Expiry Date:  ",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        color: AppColors.greyHeadingTextColor),
                    children: [
                  TextSpan(
                      text: " ${vehicle!.vehicleLicenseExpiryDate}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.greyTextColor))
                ])).marginSymmetric(vertical: 10.h),
            Divider(endIndent: 20,indent: 1,color: AppColors.appPrimaryColor.withOpacity(.2),),

            RichText(
                text: TextSpan(
                    text: "Vehicle Plate Number: ",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                        color: AppColors.greyHeadingTextColor),
                    children: [
                  TextSpan(
                      text: "  ${vehicle!.vehicleNumberPlate}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.greyTextColor))
                ])).marginSymmetric(vertical: 10.h),
            Divider(endIndent: 20,indent: 1,color: AppColors.appPrimaryColor.withOpacity(.2),),

            Row(
              children: [
                Expanded(
                  child: RichText(
                      text: TextSpan(
                          text: "Rate Per Day: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13.sp,
                              color:AppColors.greyHeadingTextColor),
                          children: [
                        TextSpan(
                            text: "  \$ ${vehicle!.vehiclePerDayRent}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.grey))
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
                            text: " \$ ${vehicle!.vehiclePerHourRent}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.greyTextColor))
                      ])),
                )
              ],
            ).marginSymmetric(vertical: 10.h),
            Divider(endIndent: 20,indent: 1,color: AppColors.appPrimaryColor.withOpacity(.2),),

            Text(
              vehicle!.vehicleDescription,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF828282)),
              textAlign: TextAlign.start,
            ).marginSymmetric(vertical: 8.h),
           if(status=="Pending") Row(
              children: [
                Expanded(
                    child: CustomButton(
                  height: 46.h,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700),
                  title: "Decline Account",
                  onPressed: () {},
                  color: Color(0xFFFE0000),
                )),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                    child: CustomButton(
                  height: 46.h,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700),
                  title: "Approve Account",
                  onPressed: () async{
                    await addVehicleRef.doc(vehicle!.vehicleId).update({"isVerified":true}).then((value) {

                      Get.snackbar("Alert", "Successfully Approved vehicel",backgroundColor: Colors.red,colorText: Colors.white);
                    });
                  },
                  color: Color(0xFF0F9D58),
                )),
              ],
            ).marginSymmetric(vertical: 8.h),
          ],
        ).marginOnly(bottom: 10.h),
        if(userType==""||userType==null)
          Container(
          color: Colors.white,
          child: ExpansionTile(
            iconColor: Colors.black,
            backgroundColor: Colors.white,
            title: Text("Provider Details",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    fontFamily: "Quicksand",
                    color: Colors.black)),
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 75.h,
                        width: 75.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:NetworkImage(host!.imageUrl.isNotEmpty?host!.imageUrl:image_url)
                                // AssetImage(
                                //     "assets/images/user-image.png")
                            )),
                      ).marginOnly(right: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            host!.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              host!.address,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.appPrimaryColor,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: "Date of Birth:",
                                style: TextStyle(
                                  color: AppColors.appPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp),
                                children: [
                              TextSpan(
                                  text: " ${formattedDate}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp))
                            ])),
                      ),
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: "Gender:",
                                style: TextStyle(
                                  color: AppColors.appPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp),
                                children: [
                              TextSpan(
                                  text: " ${host!.gender}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp))
                            ])),
                      ),
                    ],
                  ).marginSymmetric(vertical: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: "Email:",
                                style: TextStyle(
                                  color: AppColors.appPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp),
                                children: [
                              TextSpan(
                                  text: " ${host!.email}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp))
                            ])),
                      ),
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: "Phone No:",
                                style: TextStyle(
                                  color: AppColors.appPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.sp),
                                children: [
                              TextSpan(
                                  text: "  ${host!.phoneNumber}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp))
                            ])),
                      ),
                    ],
                  ).marginSymmetric(vertical: 10.h),
                  Text(
                    host!.profileDescription,
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF828282)),
                    textAlign: TextAlign.start,
                  ).marginSymmetric(vertical: 8.h),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildDocumnets() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50.w),
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
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 8,
              crossAxisCount: 2),
            children:
            [
              Container(
                height: 175.h,
                width: 185.w,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,

                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: NetworkImage(vehicle!.vehicleImageComplete),
                      fit: BoxFit.fill

                    // AssetImage("assets/images/car_fornt.png")
                  ),
                ),
              ),
              Container(
                height: 175.h,
                width: 185.w,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image:NetworkImage(vehicle!.vehicleImageNumberPlate),
                      fit: BoxFit.fill
                      // AssetImage("assets/images/full_car.png")
                  ),
                ),
              ),
              Container(
                height: 175.h,
                width: 185.w,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image:NetworkImage(vehicle!.vehicleImageRear),
                      fit: BoxFit.fill

                    // AssetImage("assets/images/car_fornt.png")
                  ),
                ),
              ),
              Container(
                height: 175.h,
                width: 185.w,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image:NetworkImage(vehicle!.vehicleImageNumberPlate),
                      fit: BoxFit.fill

                    // AssetImage("assets/images/full_car.png")
                  ),
                ),
              ),
              Container(
                height: 175.h,
                width: 185.w,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image:NetworkImage(vehicle!.vehicleImageRightSide),
                      fit: BoxFit.fill

                    // AssetImage("assets/images/car_fornt.png")
                  ),
                ),
              ),
              Container(
                height: 175.h,
                width: 185.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: NetworkImage(vehicle!.vehicleImageInterior),
                      fit: BoxFit.cover

                    // AssetImage("assets/images/full_car.png")
                  ),
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
              height: 250.h,
              width: 600.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(vehicle!.vehicleRegistrationImage)
                    // AssetImage("assets/images/reg_vechile.png"),
                  )),
            ),
          ).marginAll(10),
        ],
      )),
    );
  }

 ScreenVehicleDetails({
    required this.status,
     this.vehicle,
    this.userType,
  });
}
