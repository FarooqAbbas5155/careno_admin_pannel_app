
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../models/add_host_vehicle.dart';
import '../../models/booking.dart';
import '../../models/categories.dart';
import '../../models/user.dart ';

class ScreenVehicleBookedDetails extends StatelessWidget {
   Booking booking;
  AddHostVehicle vehicle;

  @override

  var user;
   var category;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Booking Details",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                fontFamily: "Quicksand"),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: usersRef.doc(vehicle.hostId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(backgroundColor: AppColors.appPrimaryColor,),
              );

            }
            user = User.fromMap(snapshot.data!.data() as Map<String,dynamic>);
            return FutureBuilder<DocumentSnapshot>(
              future: categoryRef.doc(vehicle.vehicleCategory).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(backgroundColor: AppColors.appPrimaryColor,),
                  );

                }
                category = Category.fromMap(snapshot.data!.data() as Map<String,dynamic>);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetails(),
                      SizedBox(height: 10,),
                      buildDocumnets(),
                    ],
                  ).marginSymmetric(horizontal: 10.w, vertical: 20),
                );
              }
            );
          }
        ));
  }

  Widget buildDetails() {
    return SingleChildScrollView(
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
          Text(user!.name,
           style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                color: Colors.black),
          ),
          Text(
            vehicle.address.isNotEmpty?vehicle.address:"No address found",
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
                              text: " ${vehicle.vehicleYear}",
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
                              text: "${category.name}",
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
                              text: " ${vehicle.vehicleColor}",
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
                              text: " ${vehicle.vehicleSeats}",
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
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: "  ${vehicle.vehicleTransmission}",
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
                              text: " ${vehicle.vehicleFuelType}",
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
                        text: "Start Time:",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: "  ${formatTime(booking.startTime)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.greyTextColor))
                        ])),
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: "End Time: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: " ${formatTime(booking.EndTime)}",
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
                        text: "Start Date:",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                            text: "  ${BookingDateFormate(booking.bookingStartDate)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.greyTextColor,
                            ),
                          )
                        ])),
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: "End Date: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: " ${BookingDateFormate(booking.bookingEndDate)}",
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
                  text: "Vehicle Plate Number: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      color: AppColors.greyHeadingTextColor),
                  children: [
                    TextSpan(
                        text: "  ${vehicle.vehicleNumberPlate}",
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
                        text: "Bookin type: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: "  ${booking.bookingType}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.greyTextColor))
                        ])),
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: "Total Rent:  ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: AppColors.greyHeadingTextColor),
                        children: [
                          TextSpan(
                              text: " \$ ${booking.price}",
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
            vehicle.vehicleDescription,
            style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF828282)),
            textAlign: TextAlign.start,
          ).marginSymmetric(vertical: 8.h),
      
        ],
      ).marginOnly(bottom: 10.h),
    );
  }

   Widget buildDocumnets() {
     return SingleChildScrollView(
       child: Container(
         // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50.w),
         decoration: BoxDecoration(color: Colors.white),
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
         ),
       ),
     );
   }

  ScreenVehicleBookedDetails({
    required this.booking,
    required this.vehicle,
  });
}
