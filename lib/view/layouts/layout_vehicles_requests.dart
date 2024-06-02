
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/fcm.dart';
import '../../constant/helpers.dart';
import '../../controllers/home_controller.dart';
import '../../models/user.dart ';
import '../../widgets/custom_button.dart';
import '../screens/screen_vehicle_details.dart';

class LayoutVehiclesRequests extends StatelessWidget {
  HomeController _controller = Get.put(HomeController());
  User? host;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: _controller,
        builder: (controller) {
          return Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vehicle Requests",
                style:     TextStyle(
                        color: AppColors.appPrimaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24.sp,
                        fontFamily: "Nunito"
                    ),
                ).marginSymmetric(vertical: 10.h,horizontal: 10.w),
                controller.vehiclesRequest.value.isNotEmpty ?
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:  controller.vehiclesRequest.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    var vehicle =  controller.vehiclesRequest.value[index];
                    return InkWell(
                      onTap: (){
                          Get.to(ScreenVehicleDetails(
                            status: 'Pending',
                            vehicle: vehicle,));

                      },
                      child: Container(
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
                      trailing:      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureBuilder<DocumentSnapshot>(
                            future: usersRef.doc(vehicle.hostId).get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }

                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("Error loading data"),
                                );
                              }

                              if (!snapshot.hasData || !snapshot.data!.exists) {
                                return Center(
                                  child: SizedBox(),
                                );
                              }

                              // Attempt to parse host data
                              try {
                                host = User.fromMap(snapshot.data!.data() as Map<String, dynamic>);
                              } catch (e) {
                                return Center(
                                  child: Text("Invalid data format"),
                                );
                              }

                              if (host == null) {
                                return SizedBox();
                              }

                              return CustomButton(
                                title: "Approve",
                                color: Color(0xFf0F9D58),
                                height: 41.h,
                                width: 80.w,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                onPressed: () async {
                                  await addVehicleRef.doc(vehicle.vehicleId).update({
                                    "isVerified": true,
                                    "status": "Active"
                                  }).then((value) async {
                                    if (host!.notification == true) {
                                      await FCM.sendMessageSingle(
                                        "Congratulations",
                                        "${vehicle.vehicleModel} is Approved",
                                        host!.notificationToken.toString(),
                                        {},
                                      );
                                    }
                                    Get.snackbar(
                                      "Alert",
                                      "Successfully Approved vehicle",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  });
                                },
                              ).marginSymmetric(horizontal: 10.w);
                            },
                          ),

                          CustomButton(
                            title: "Decline",
                            color: Color(0xFfEB141B),

                            height: 41.h,
                            width: 80.w,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight
                                    .w500),
                            onPressed: () async {
                              await addVehicleRef.doc(
                                  vehicle.vehicleId).update(
                                  {
                                    "isVerified": false,
                                    "status": "Reject"
                                  }).then((value) {
                                FCM.sendMessageSingle(
                                    "Congrutulation",
                                    "${vehicle!
                                        .vehicleModel} is Rejected",
                                    host!.notificationToken
                                        .toString(),
                                    {});
                                Get.snackbar("Alert",
                                    "Your Vehicle Request Reject",
                                    backgroundColor: Colors
                                        .red,
                                    colorText: Colors
                                        .white);
                              });
                            },

                          ),
                        ],
                      ),
                        )),
                    );
                  },)
                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //         vertical: 15.h, horizontal: 20.w),
                //     margin: EdgeInsets.symmetric(
                //       vertical: 15.h,
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //     ),
                //     child: Align(
                //       alignment: Alignment.topLeft,
                //       child: SingleChildScrollView(
                //         scrollDirection: Axis.horizontal,
                //         child: SingleChildScrollView(
                //           scrollDirection: Axis.vertical,
                //           child: Column(
                //             children: [
                //               DataTable(
                //                   columnSpacing: 40.h,
                //                   decoration: BoxDecoration(
                //                     border: Border.all(
                //                         color: Colors
                //                             .grey), // Border for the entire DataTable
                //                   ),
                //                   headingRowHeight: 60.h,
                //                   // horizontalMargin: 100.w,
                //                   dataRowHeight: 120.h,
                //                   headingRowColor: MaterialStateProperty
                //                       .resolveWith(
                //                           (states) =>
                //                       AppColors.appPrimaryColor),
                //                   columns: [
                //                     DataColumn(
                //                         label: Text(
                //                           "Image",
                //                           style: TextStyle(
                //                               color: Colors.white),
                //                         ).paddingSymmetric(horizontal: 20.w)),
                //                     DataColumn(
                //                         label: Text(
                //                           "Make & Model",
                //                           style: TextStyle(
                //                               color: Colors.white),
                //                         ).paddingSymmetric(horizontal: 20.w)),
                //                     DataColumn(
                //                         label: Text(
                //                           "Vehicle Location",
                //                           style: TextStyle(
                //                               color: Colors.white),
                //                         ).paddingSymmetric(horizontal: 20.w)),
                //                     DataColumn(
                //                         label: Text(
                //                           "Rate Per Day",
                //                           style: TextStyle(
                //                               color: Colors.white),
                //                         ).paddingSymmetric(horizontal: 20.w)),
                //                     DataColumn(
                //                         label: Text(
                //                           "Rate Per Hour",
                //                           style: TextStyle(
                //                               color: Colors.white),
                //                         ).paddingSymmetric(horizontal: 20.w)),
                //
                //                     DataColumn(
                //                         label: Text(
                //                           "Action",
                //                           style: TextStyle(
                //                               color: Colors.white),
                //                         ).paddingSymmetric(horizontal: 20.w)),
                //                   ],
                //                   rows: List.generate(
                //                       controller.vehiclesRequest.value
                //                           .length, (index) {
                //                     var vehicle = controller.vehiclesRequest
                //                         .value[index];
                //                     return DataRow(cells: [
                //                       DataCell(
                //                         CircleAvatar(
                //                             radius: 45.r,
                //                             backgroundImage: NetworkImage(
                //                                 vehicle.vehicleImageComplete)
                //                           // AssetImage("assets/images/car.png")
                //                         )
                //                             .paddingSymmetric(
                //                             horizontal: 20.w),
                //                       ),
                //                       DataCell(Text(vehicle.vehicleModel)
                //                           .paddingSymmetric(
                //                           horizontal: 20.w)),
                //                       DataCell(Text(vehicle.address)
                //                           .paddingSymmetric(
                //                           horizontal: 20.w)),
                //                       DataCell(
                //                           Text("\$ ${vehicle
                //                               .vehiclePerDayRent}")
                //                               .paddingSymmetric(
                //                               horizontal: 20.w)),
                //                       DataCell(
                //                           Text("\$ ${vehicle
                //                               .vehiclePerHourRent}")
                //                               .paddingSymmetric(
                //                               horizontal: 20.w)),
                //                       DataCell(
                //                         Row(
                //                           children: <Widget>[
                //                             CustomButton(
                //                               title: "View",
                //                               onPressed: () {
                //                                 Get.to(ScreenVehicleDetails(
                //                                   status: 'Pending',
                //                                   vehicle: vehicle,));
                //                               },
                //                               height: 41.h,
                //                               width: 100.w,
                //                               textStyle: TextStyle(
                //                                   color: Colors.white,
                //                                   fontSize: 18.sp,
                //                                   fontWeight: FontWeight
                //                                       .w500),
                //                             ),
                //                             // FutureBuilder<User?>(
                //                             //     future: getUser(vehicle.hostId),
                //                             //     builder: (context, snapshot) {
                //                             //       if (snapshot
                //                             //           .connectionState ==
                //                             //           ConnectionState
                //                             //               .waiting) {
                //                             //         return Center(
                //                             //           child: CircularProgressIndicator
                //                             //               .adaptive(
                //                             //             backgroundColor: Colors
                //                             //                 .green,),);
                //                             //       }
                //                             //       host = snapshot.data!;
                //                             //       return CustomButton(
                //                             //         title: "Approve",
                //                             //         color: Color(0xFf0F9D58),
                //                             //
                //                             //         height: 41.h,
                //                             //         width: 120.w,
                //                             //         textStyle: TextStyle(
                //                             //             color: Colors.white,
                //                             //             fontSize: 18.sp,
                //                             //             fontWeight: FontWeight
                //                             //                 .w500),
                //                             //         onPressed: () async {
                //                             //           await addVehicleRef.doc(
                //                             //               vehicle.vehicleId)
                //                             //               .update({
                //                             //             "isVerified": true,
                //                             //             "status": "Active"
                //                             //           })
                //                             //               .then((value) async{
                //                             //             if (host!.notification == true) {
                //                             //               await FCM.sendMessageSingle(
                //                             //                   "Congrutulation",
                //                             //                   "${vehicle!
                //                             //                       .vehicleModel} is Approved",
                //                             //                   host!
                //                             //                       .notificationToken
                //                             //                       .toString(),
                //                             //                   {});
                //                             //
                //                             //
                //                             //             }
                //                             //             Get.snackbar("Alert",
                //                             //                 "Successfully Aproved vehicel",
                //                             //                 backgroundColor: Colors
                //                             //                     .red,
                //                             //                 colorText: Colors
                //                             //                     .white);
                //                             //           });
                //                             //         },
                //                             //
                //                             //       ).marginSymmetric(
                //                             //           horizontal: 10.w);
                //                             //     }
                //                             // ),
                //                             CustomButton(
                //                               title: "Decline",
                //                               color: Color(0xFfEB141B),
                //
                //                               height: 41.h,
                //                               width: 100.w,
                //                               textStyle: TextStyle(
                //                                   color: Colors.white,
                //                                   fontSize: 18.sp,
                //                                   fontWeight: FontWeight
                //                                       .w500),
                //                               onPressed: () async {
                //                                 await addVehicleRef.doc(
                //                                     vehicle.vehicleId).update(
                //                                     {
                //                                       "isVerified": false,
                //                                       "status": "Reject"
                //                                     }).then((value) {
                //                                   FCM.sendMessageSingle(
                //                                       "Congrutulation",
                //                                       "${vehicle!
                //                                           .vehicleModel} is Rejected",
                //                                       host!.notificationToken
                //                                           .toString(),
                //                                       {});
                //                                   Get.snackbar("Alert",
                //                                       "Your Vehicle Request Reject",
                //                                       backgroundColor: Colors
                //                                           .red,
                //                                       colorText: Colors
                //                                           .white);
                //                                 });
                //                               },
                //
                //                             ),
                //                           ],
                //                         ),
                //                       )
                //
                //                       // DataCell(Text("Test")),
                //                     ]);
                //                   })),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
                    : Center(
                    child: Text(
                        "No Vehicle Request Found yet", style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Nunito")

                    ))
              ],
            );
          });
        });
  }
}
