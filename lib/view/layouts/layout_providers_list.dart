import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/CustomDialog.dart';
import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../controllers/home_controller.dart';
import '../../models/block_user.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_chat.dart';
import '../screens/screen_user_details.dart';
class LayoutProvidersList extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  List<String> list=["Block User"];
  @override
  Widget build(BuildContext context) {
    return  controller.host.value.isNotEmpty? Container(
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Provider List",
            style: TextStyle(
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 25.sp,
                fontFamily: "Nunito"
            ),
          ).marginSymmetric(vertical: 10.h,horizontal: 6.w),

          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.host.value.length,
              itemBuilder: (BuildContext context, int index) {
                var host = controller.host.value[index];

                return InkWell(
                  onTap: () {
                    Get.to(ScreenUserDetails(userType: 'host', user: host,));                  },
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
                      leading: CircleAvatar(
                          radius: 35.r,
                          backgroundImage: NetworkImage(host.imageUrl.isEmpty
                              ? image_url
                              : host.imageUrl)
                        // AssetImage(
                        //     "assets/images/car.png")
                      ),
                      title: Text(host.name, style: TextStyle(fontSize: 18.sp,
                          fontFamily: "Nunito"),),
                      trailing: PopupMenuButton<String>(
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
                                width: Get.width * .35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("carenoapp.example.com says",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w500
                                      ),),
                                    Text(
                                      "Are you sure you want to block this Provider account?",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w500
                                      ),),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: AppColors
                                                    .appPrimaryColor,
                                              ),
                                              onPressed: () async {
                                                BlockUser blockuser = BlockUser(
                                                    uid: uid);
                                                await blcokUserRef.doc(uid).set(
                                                    blockuser.toMap()).then((
                                                    value) async{
                                                  await usersRef.doc(host.uid).update(
                                                      {"isBlocked":true});
                                                  Get.back();
                                                });
                                              }, child: Text("Ok", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500
                                          ),)).marginOnly(right: 20.w
                                          ),

                                          OutlinedButton(onPressed: () {},
                                              child: Text("Cancel")),
                                        ]
                                    ),
                                  ],
                                ),
                              ), 10.0.r);
                        },
                      ),

                    ),
                  ),
                );
              },);
          }),


          // Expanded(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
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
          //                   headingRowColor: MaterialStateProperty.resolveWith(
          //                           (states) => AppColors.appPrimaryColor),
          //                   columns: [
          //                     DataColumn(
          //                         label: Text(
          //                           "Image",
          //                           style: TextStyle(color: Colors.white),
          //                         ).paddingSymmetric(horizontal: 20.w)),
          //                     DataColumn(
          //                         label: Text(
          //                           "Name",
          //                           style: TextStyle(color: Colors.white),
          //                         ).paddingSymmetric(horizontal: 20.w)),
          //                     DataColumn(
          //                         label: Text(
          //                           "Phone",
          //                           style: TextStyle(color: Colors.white),
          //                         ).paddingSymmetric(horizontal: 20.w)),
          //                     DataColumn(
          //                         label: Text(
          //                           "Email",
          //                           style: TextStyle(color: Colors.white),
          //                         ).paddingSymmetric(horizontal: 20.w)),
          //                     DataColumn(
          //                         label: Text(
          //                           "Gender",
          //                           style: TextStyle(color: Colors.white),
          //                         ).paddingSymmetric(horizontal: 20.w)),
          //                     DataColumn(
          //                         label: Text(
          //                           "Action",
          //                           style: TextStyle(color: Colors.white),
          //                         ).paddingSymmetric(horizontal: 20.w)),
          //                     DataColumn(
          //                         label: Text(
          //                           "Details",
          //                           style: TextStyle(color: Colors.white),
          //                         ).paddingSymmetric(horizontal: 20.w)),
          //
          //                   ],
          //                   rows: List.generate(controller.host.value.length, (index) {
          //                     var host = controller.host.value[index];
          //                     return DataRow(cells: [
          //                       DataCell(
          //                         CircleAvatar(
          //                             radius: 45.r,
          //                             backgroundImage:NetworkImage(host.imageUrl.isEmpty?image_url:host.imageUrl)
          //                             // AssetImage(
          //                             //     "assets/images/car.png")
          //                         )
          //                             .paddingSymmetric(horizontal: 20.w),
          //                       ),
          //                       DataCell(Text(host.name)
          //                           .paddingSymmetric(horizontal: 20.w)),
          //                       DataCell(Text(host.phoneNumber)
          //                           .paddingSymmetric(horizontal: 20.w)),
          //                       DataCell(Text(host.email)
          //                           .paddingSymmetric(horizontal: 20.w)),
          //                       DataCell(Text(host.gender).paddingSymmetric(horizontal: 20.w)),
          //
          //                       DataCell(
          //                         PopupMenuButton<String>(
          //                           icon: Icon(Icons.more_vert),
          //                           color: Colors.white,
          //                           // constraints: BoxConstraints(
          //                           //   maxHeight: 40.h
          //                           // ),
          //                           itemBuilder: (BuildContext context) {
          //                             return list
          //                                 .map((choice) {
          //                               return PopupMenuItem<String>(
          //                                 value: choice,
          //                                 height: 40.h,
          //                                 padding: EdgeInsets.symmetric(horizontal: 10),
          //                                 child: Text(
          //                                   choice,
          //                                   style: TextStyle(
          //                                       color: Colors.black,
          //                                       fontFamily: "Urbanist"),
          //                                 ),
          //                               );
          //                             }).toList();
          //                           },
          //                           onSelected: (String choice) {
          //                             CustomDialog.showCustomDialog(context,
          //                                 SizedBox(
          //                                   width: Get.width*.35,
          //                                   child: Column(
          //                                     crossAxisAlignment: CrossAxisAlignment.start,
          //                                     mainAxisSize: MainAxisSize.min,
          //                                     children: <Widget>[
          //                                       Text("carenoapp.example.com says",style: TextStyle(
          //                                           fontSize: 20.sp,
          //                                           fontFamily: "Nunito",
          //                                           fontWeight: FontWeight.w500
          //                                       ),),
          //                                       Text("Are you sure you want to block this Provider account?",style: TextStyle(
          //                                           fontSize: 20.sp,
          //                                           fontFamily: "Nunito",
          //                                           fontWeight: FontWeight.w500
          //                                       ),),
          //                                       Row(
          //                                           mainAxisAlignment: MainAxisAlignment.end,
          //                                           children: <Widget>[
          //                                             OutlinedButton(
          //                                                 style: OutlinedButton.styleFrom(
          //                                                   backgroundColor: AppColors.appPrimaryColor,
          //                                                 ),
          //                                                 onPressed: ()async{
          //                                                   await usersRef.doc(host.uid).update({"isBlocked":true}).then((value) {
          //                                                     Get.snackbar("Alert", "Successfully provider Update");
          //                                                     Get.back();
          //                                                   });
          //
          //                                                 }, child: Text("Ok",style: TextStyle(
          //                                                 color: Colors.white,
          //                                                 fontSize: 18.sp,
          //                                                 fontWeight: FontWeight.w500
          //                                             ),)).marginOnly(right: 20.w
          //                                             ),
          //
          //                                             OutlinedButton(onPressed: (){
          //                                               Get.back();
          //                                             }, child: Text("Cancel")),
          //                                           ]
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ), 10.0.r);
          //
          //                           },
          //                         ),
          //                       ),
          //                       DataCell(CustomButton(
          //                         width: 130.w,
          //                         height: 45.h,
          //
          //                         title: 'View', onPressed: () {
          //                         Get.to(ScreenUserDetails(userType: 'host', user: host,));
          //                       },).paddingSymmetric(horizontal: 20.w)),
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
          // ),
        ],
      ),
    ):    Center(
        child: Text("No Provider Found yet",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,fontFamily: "Nunito"),));

  }
}
