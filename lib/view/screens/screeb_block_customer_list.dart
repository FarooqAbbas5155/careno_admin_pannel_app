import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/CustomDialog.dart';
import '../../constant/colors.dart';

class ScreebBlockCustomerList extends StatelessWidget {
  List<String> list=["UnBlock User"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        title: Text(
          " Blocked Customer List",
          style: AppColors.headingStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        color: AppColors.backGroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  alignment: Alignment.centerLeft,
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
                                      "Name",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Phone",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Email",
                                      style: TextStyle(color: Colors.white),
                                    ).paddingSymmetric(horizontal: 20.w)),
                                DataColumn(
                                    label: Text(
                                      "Gender",
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
                                  DataCell(Text("Name")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("+343434767676")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("ab@gmail.com")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(Text("Male")
                                      .paddingSymmetric(horizontal: 20.w)),
                                  DataCell(
                                    PopupMenuButton<String>(
                                      icon: Icon(Icons.more_vert),
                                      color: Colors.white,
                                      // constraints: BoxConstraints(
                                      //   maxHeight: 40.h
                                      // ),
                                      itemBuilder: (BuildContext context) {
                                        return list
                                            .map((choice) {
                                          return PopupMenuItem<String>(
                                            value: choice,
                                            height: 40.h,
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(
                                              choice,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Urbanist"),
                                            ),
                                          );
                                        }).toList();
                                      },
                                      onSelected: (String choice) {
                                        CustomDialog.showCustomDialog(context,
                                            SizedBox(
                                              width: Get.width*.35,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text("carenoapp.example.com says",style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontFamily: "Nunito",
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                  Text("Are you sure you want to Unblock this Customer account?",style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontFamily: "Nunito",
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        OutlinedButton(
                                                            style: OutlinedButton.styleFrom(
                                                              backgroundColor: AppColors.appPrimaryColor,
                                                            ),
                                                            onPressed: (){}, child: Text("Ok",style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.sp,
                                                            fontWeight: FontWeight.w500
                                                        ),)).marginOnly(right: 20.w
                                                        ),

                                                        OutlinedButton(onPressed: (){}, child: Text("Cancel")),
                                                      ]
                                                  ),
                                                ],
                                              ),
                                            ), 10.0.r);

                                      },
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
