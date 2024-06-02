import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/custom_button.dart';
import '../authentication/screen_login.dart';

class LayoutLogout extends StatelessWidget {
  const LayoutLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 50.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.white
        ),
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
             "assets/icons/logout-.svg",
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              "Logout",
              style: TextStyle(color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "UrbanistBold",),
            ),
            SizedBox(
              height: 13.sp,
            ),
            Text(
              textAlign: TextAlign.center,
              "Are you absolutely certain you wish to \nproceed with logging out?",

              style: TextStyle(color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "UrbanistBold",),
            ),
            CustomButton(
                width: 193.w,
                title: "Yes, logout",
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(ScreenLogin());
                }).marginSymmetric(vertical: 20.h)
          ],
        ),
      ),),
    );
  }
}
