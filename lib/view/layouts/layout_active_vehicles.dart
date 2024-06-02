import 'dart:developer';
import 'package:careno_admin_pannel_app/constant/helpers.dart';
import 'package:careno_admin_pannel_app/models/add_host_vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_vehicle_details.dart';

class LayoutActiveVehicles extends StatelessWidget {
  String? userType;
  String? bannerModel;
  String? hostId;
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:Text(
          "Active Vehicle",
          style: TextStyle(
              color: AppColors.appPrimaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 25.sp,
              fontFamily: "Nunito"
          ),
        ).marginOnly(top: 10.h),
      ),
      body:
          hostId == null?
      controller.activeVehicle.value.isNotEmpty ?
          ListView.builder(
            itemCount: controller.activeVehicle.value.length,
            itemBuilder: (BuildContext context, int index) {
              var vehicle = controller.activeVehicle[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 4.h),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                // Adjust as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // Shadow color with opacity
                    spreadRadius: 2,
                    // Spread radius
                    blurRadius: 5,
                    // Blur radius
                    offset: Offset(0, 3), // Offset in x and y directions
                  ),
                ],
              ),
              child: ListTile(
                leading:   CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage(
                        vehicle.vehicleImageComplete)),
                title: Text(vehicle.vehicleModel),
                trailing:
              bannerModel == null ? CustomButton(
                                              title: "View",
                                              onPressed: () {
                                                Get.to(ScreenVehicleDetails(
                                                  status: 'Active',
                                                  userType: userType,
                                                  vehicle: vehicle,));
                                              },
                                              height: 41.h,
                                              width: 100.w,
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500),
                                            ) : CustomButton(
                                              title: "Select",
                                              onPressed: () {
                                                controller.bannerModel.value = vehicle.vehicleModel;
                                                controller.bannerVehicleId.value = vehicle.vehicleId;

                                                HomeController homeController = Get.find<HomeController>();
                                                Get.back(result:controller.bannerModel.value);
                                              },
                                              height: 41.h,
                                              width: 100.w,
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                        ),
              );
          },)
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //
      //
      //
      //     // Expanded(
      //     //   child: Container(
      //     //     padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      //     //     margin: EdgeInsets.symmetric(
      //     //       vertical: 15.h,
      //     //     ),
      //     //     decoration: BoxDecoration(
      //     //       color: Colors.white,
      //     //     ),
      //     //     child: Align(
      //     //       alignment: Alignment.topLeft,
      //     //       child: SingleChildScrollView(
      //     //         scrollDirection: Axis.horizontal,
      //     //         child: SingleChildScrollView(
      //     //           scrollDirection: Axis.vertical,
      //     //           child: Column(
      //     //             children: [
      //     //               DataTable(
      //     //                   columnSpacing: 40.h,
      //     //                   decoration: BoxDecoration(
      //     //                     border: Border.all(
      //     //                         color: Colors
      //     //                             .grey), // Border for the entire DataTable
      //     //                   ),
      //     //                   headingRowHeight: 60.h,
      //     //                   // horizontalMargin: 100.w,
      //     //                   dataRowHeight: 120.h,
      //     //                   headingRowColor: MaterialStateProperty
      //     //                       .resolveWith(
      //     //                           (states) => AppColors.appPrimaryColor),
      //     //                   columns: [
      //     //                     DataColumn(
      //     //                         label: Text(
      //     //                           "Image",
      //     //                           style: TextStyle(color: Colors.white),
      //     //                         ).paddingSymmetric(horizontal: 20.w)),
      //     //                     DataColumn(
      //     //                         label: Text(
      //     //                           "Make & Model",
      //     //                           style: TextStyle(color: Colors.white),
      //     //                         ).paddingSymmetric(horizontal: 20.w)),
      //     //                     DataColumn(
      //     //                         label: Text(
      //     //                           "Vehicle Location",
      //     //                           style: TextStyle(color: Colors.white),
      //     //                         ).paddingSymmetric(horizontal: 20.w)),
      //     //                     DataColumn(
      //     //                         label: Text(
      //     //                           "Rate Per Day",
      //     //                           style: TextStyle(color: Colors.white),
      //     //                         ).paddingSymmetric(horizontal: 20.w)),
      //     //                     DataColumn(
      //     //                         label: Text(
      //     //                           "Rate Per Hour",
      //     //                           style: TextStyle(color: Colors.white),
      //     //                         ).paddingSymmetric(horizontal: 20.w)),
      //     //
      //     //                     DataColumn(
      //     //                         label: Text(
      //     //                           "Action",
      //     //                           style: TextStyle(color: Colors.white),
      //     //                         ).paddingSymmetric(horizontal: 20.w)),
      //     //                   ],
      //     //                   rows: List.generate(
      //     //                       controller.activeVehicle.value.length, (
      //     //                       index) {
      //     //                     var vehicle = controller.activeVehicle
      //     //                         .value[index];
      //     //                     return DataRow(cells: [
      //     //                       DataCell(
      //     //                         CircleAvatar(
      //     //                             radius: 45.r,
      //     //                             backgroundImage: NetworkImage(
      //     //                                 vehicle.vehicleImageComplete))
      //     //                             .paddingSymmetric(horizontal: 20.w),
      //     //                       ),
      //     //                       DataCell(Text(vehicle.vehicleModel)
      //     //                           .paddingSymmetric(horizontal: 20.w)),
      //     //                       DataCell(Text(vehicle.address)
      //     //                           .paddingSymmetric(horizontal: 20.w)),
      //     //                       DataCell(
      //     //                           Text("\$ ${vehicle.vehiclePerDayRent}")
      //     //                               .paddingSymmetric(horizontal: 20.w)),
      //     //                       DataCell(
      //     //                           Text("\$ ${vehicle.vehiclePerHourRent}")
      //     //                               .paddingSymmetric(horizontal: 20.w)),
      //     //                       DataCell(
      //     //                           bannerModel == null ? CustomButton(
      //     //                             title: "View",
      //     //                             onPressed: () {
      //     //                               Get.to(ScreenVehicleDetails(
      //     //                                 status: 'Active',
      //     //                                 userType: userType,
      //     //                                 vehicle: vehicle,));
      //     //                             },
      //     //                             height: 41.h,
      //     //                             width: 100.w,
      //     //                             textStyle: TextStyle(
      //     //                                 color: Colors.white,
      //     //                                 fontSize: 18.sp,
      //     //                                 fontWeight: FontWeight.w500),
      //     //                           ) : CustomButton(
      //     //                             title: "Select",
      //     //                             onPressed: () {
      //     //                               controller.bannerModel.value = vehicle.vehicleModel;
      //     //                               controller.bannerVehicleId.value = vehicle.vehicleId;
      //     //
      //     //                               HomeController homeController = Get.find<HomeController>();
      //     //                               Get.back(result:controller.bannerModel.value);
      //     //                             },
      //     //                             height: 41.h,
      //     //                             width: 100.w,
      //     //                             textStyle: TextStyle(
      //     //                                 color: Colors.white,
      //     //                                 fontSize: 18.sp,
      //     //                                 fontWeight: FontWeight.w500),
      //     //                           ),
      //     //                       )
      //     //
      //     //                       // DataCell(Text("Test")),
      //     //                     ]);
      //     //                   })),
      //     //             ],
      //     //           ),
      //     //         ),
      //     //       ),
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // )


          : Center(
          child: Text("No Vehicle Found of This Host", style: TextStyle(fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.appPrimaryColor,
              fontFamily: "Nunito"),)):StreamBuilder<QuerySnapshot>(
            stream: addVehicleRef.where("isVerified",isEqualTo:true).where("status",isEqualTo: "Active").where("hostId",isEqualTo: hostId).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive(backgroundColor: AppColors.appPrimaryColor));

                }
                var vehilces = snapshot.data!.docs.map((e) => AddHostVehicle.fromMap(e.data() as Map<String,dynamic>)).toList();
          return vehilces != null ?
          ListView.builder(
            itemCount: vehilces.length,
            itemBuilder: (BuildContext context, int index) {
              var vehicle = vehilces[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 4.h),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  // Adjust as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      // Shadow color with opacity
                      spreadRadius: 2,
                      // Spread radius
                      blurRadius: 5,
                      // Blur radius
                      offset: Offset(0, 3), // Offset in x and y directions
                    ),
                  ],
                ),
                child: ListTile(
                  leading:   CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(
                          vehicle.vehicleImageComplete)),
                  title: Text(vehicle.vehicleModel),
                  trailing:
                  bannerModel == null ? CustomButton(
                    title: "View",
                    onPressed: () {
                      Get.to(ScreenVehicleDetails(
                        status: 'Active',
                        userType: userType,
                        vehicle: vehicle,));
                    },
                    height: 41.h,
                    width: 100.w,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  ) : CustomButton(
                    title: "Select",
                    onPressed: () {
                      controller.bannerModel.value = vehicle.vehicleModel;
                      controller.bannerVehicleId.value = vehicle.vehicleId;

                      HomeController homeController = Get.find<HomeController>();
                      Get.back(result:controller.bannerModel.value);
                    },
                    height: 41.h,
                    width: 100.w,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },):Container(
            color: Colors.red,
              child: Text("No Vehicles Found of this Host", style: TextStyle(fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appPrimaryColor,
                  fontFamily: "Nunito"),),
            );
                },
          )
    );
  }

  LayoutActiveVehicles({
    this.userType,
    this.bannerModel,
    this.hostId,
  });
}
