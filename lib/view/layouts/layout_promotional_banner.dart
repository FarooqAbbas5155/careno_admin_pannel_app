
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/CustomDialog.dart';
import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../models/promotion_banner.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_add_ads_banner.dart';

class LayoutPromotionalBanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promotional Banner",
            style: TextStyle(
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 25.sp,
                fontFamily: "Nunito"
            ),
          ).marginSymmetric(vertical: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child:

            Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.appPrimaryColor),
                ),

                icon: Text("Add New Banner",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.w700,fontFamily: "Nunito")),
                onPressed: () {
                  Get.to(ScreenAddAdsBanner(status: 'Submit',));
                },
                label: Icon(Icons.add,color: Colors.white,),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: bannerRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive(backgroundColor: AppColors.appPrimaryColor,),);

              }
              var banners = snapshot.data!.docs.map((e) => PromotionBanner.fromMap((e.data() as Map<String,dynamic>))).toList();
              return banners.isNotEmpty?
              Expanded(
                child: ListView.builder(
                  itemCount: banners.length,
                  itemBuilder: (BuildContext context, int index) {
                  var banner = banners[index];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 14.h),
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: NetworkImage(
                              banner.imageList.first)),
                      title: Text(banner.vehicleModel),
                      subtitle: Text(banner.description),
                      trailing: IconButton(onPressed: () {
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
                                  Text("Are you sure you want to delete this Banner Ad?",style: TextStyle(
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
                                            onPressed: ()async{
                                              await deleteDirectory("promotionalBanner/${uid}").then((value) async{
                                                await bannerRef.doc(uid).delete();

                                              }).then((value){
                                                Get.snackbar("Alert", "Delete Banner success");
                                              });

                                            }, child: Text("Ok",style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500
                                        ),)).marginOnly(right: 20.w
                                        ),

                                        OutlinedButton(onPressed: (){
                                          Get.back();
                                        }, child: Text("Cancel")),
                                      ]
                                  ),
                                ],
                              ),
                            ), 10.0.r);
                      }, icon: Icon(Icons.clear,color: Colors.red,),),
                    ),
                  );
                },),

              ):Center(
                child: Text("No Promotional Banner yet",style: TextStyle(color: AppColors.appPrimaryColor,fontSize: 20.sp,fontFamily: "Nunito",fontWeight: FontWeight.w600),).marginSymmetric(),
              );
            }
          ),
        ],
      ),
    );
  }
  Future<void> deleteDirectory(String path) async {
    try {
      // Get reference to the directory
      Reference directoryRef = FirebaseStorage.instance.ref().child(path);

      // List all items (files and subdirectories) in the directory
      ListResult result = await directoryRef.listAll();

      // Delete each item (file or subdirectory) recursively
      for (Reference ref in result.items) {
        if (ref.fullPath.endsWith('/')) {
          // If the item is a subdirectory (ends with '/'), delete it recursively
          await deleteDirectory(ref.fullPath);
        } else {
          // If the item is a file, delete it
          await ref.delete();
        }
      }

      // After deleting all items, delete the directory itself
      await directoryRef.delete();

      print('Directory $path and its contents deleted successfully.');
    } catch (e) {
      print('Error deleting directory $path: $e');
    }
  }

}
