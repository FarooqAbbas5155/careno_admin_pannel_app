import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_provider_vehicle_details.dart';

class LayoutProviderVehicle extends StatelessWidget {
  const LayoutProviderVehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        color: AppColors.backGroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Provider Vehicles",
              style: AppColors.headingStyle,
            ).marginSymmetric(vertical: 10.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                margin: EdgeInsets.symmetric(
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          DataTable(
                              columnSpacing: 40.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors
                                        .grey), // Border for the entire DataTable
                              ),
                              headingRowHeight: 60.h,
                              // horizontalMargin: 100.w,
                              dataRowHeight: 120.h,
                              headingRowColor: MaterialStateProperty.resolveWith(
                                      (states) => AppColors.appPrimaryColor),
                              columns: [
                                DataColumn(
                                    label: Text(
                                      "Image",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Make & Model",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Vehicle Location",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Rate Per Day",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Rate Per Hour",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),

                                DataColumn(
                                    label: Text(
                                      "Action",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                              ],
                              rows: List.generate(20, (index) {
                                return DataRow(cells: [
                                  DataCell(
                                    CircleAvatar(
                                        radius: 45.r,
                                        backgroundImage: AssetImage(
                                            "assets/images/car.png"))
                                        .paddingSymmetric(horizontal: 20.w),
                                  ),
                                  DataCell(Text("Tesla Model 3")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("Street 2, House No, City, New York, United State")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("\$ 150")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("\$ 15")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(
                                    CustomButton(
                                      title: "View",
                                      onPressed: () {
                                        Get.to(ScreenProviderVehicleDetails());

                                      },
                                      height: 41.h,
                                      width: 100.w,
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )

                                  // DataCell(Text("Test")),
                                ]);
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
