
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/CustomDialog.dart';
import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/custom_button.dart';
import '../screens/screen_add_categories.dart';

class LayoutCategoriesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category",
            style: TextStyle(
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 35.sp,
                fontFamily: "Nunito",
            )
          ).marginSymmetric(vertical: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child:

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.appPrimaryColor),
                ),

                icon: Text("Add Category",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.w700,fontFamily: "Nunito")),
                onPressed: () {
                  Get.to(ScreenAddCategories(status: 'Submit',));
                },
                label: Icon(Icons.add,color: Colors.white,),
              ),
            ),
          ),
      Obx(() {
        return controller.categories.value.isNotEmpty? Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: controller.categories.value.length, // Replace with your actual item count
            itemBuilder: (BuildContext context, int index) {
              var category = controller.categories.value[index];
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w), // Optional: Adjust margins for spacing between items
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r), // Adjust as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Offset in x and y directions
                    ),
                  ],
                ),
                child: Column(
                  children: [
                  ListTile(
                    leading:   SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: CircleAvatar(
                                    radius: 35.r,
                                    backgroundImage:NetworkImage(category.image),
                                    // AssetImage("assets/images/car.png")
                                  ),
                    ),
                    title: Text(category.name,style: TextStyle(fontFamily: "Nunito,",fontWeight: FontWeight.w600,fontSize: 15.sp),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap:(){
                            Get.to(ScreenAddCategories(status: "Update", category: category,));
                          },
                            child: Icon(Icons.edit,color: Colors.black,).marginSymmetric(horizontal: 30.w)),
                        InkWell(
                            onTap:() {
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
                                        Text("Are you sure you want to delete this category?",style: TextStyle(
                                            fontSize: 15.sp,
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
                                                  onPressed: (){
                                                    categoryRef.doc(category.id).delete().then((value) {
                                                      Get.snackbar("Successfully", "Delete Category => ${category.name}",backgroundColor: AppColors.appPrimaryColor,colorText: Colors.white);

                                                      Get.back();
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
                            },
                            child: Icon(Icons.delete_forever,color: Colors.red,))
                      ],
                    ),
                  ),
                  ],
                )
              );
            },
          ),
        ):    Center(
            child: Text("No Category Found yet",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,fontFamily: "Nunito"),)
        );
      })
        ],
      ),
    );
  }

  //row data

  List<String> headingTextCarers = [
    "Category Image",
    "Category Name",
    "Edit",
    "Delete"
  ];
}
