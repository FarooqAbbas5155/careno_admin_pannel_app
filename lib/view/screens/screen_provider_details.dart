import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../constant/fcm.dart';
import '../../constant/helpers.dart';
import '../../controllers/home_controller.dart';
import '../../models/user.dart ';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';

class ScreenProviderDetails extends StatelessWidget {
  User host;

// String DateOfBirth = "";
  @override
  HomeController _controller = Get.put(HomeController());

  Widget build(BuildContext context) {
    // DateTime parsedDate = DateFormat("dd MMMM, yyyy").parse(host.dob.toString());
    //
    // // Format the DateTime object into the desired output format
    //  DateOfBirth = DateFormat("dd MMMM, yyyy").format(parsedDate);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10.w,
              ),
              CustomSvg(
                name: "arrow",
              ),
              Expanded(
                child: CircleAvatar(
                    radius: 35.r, backgroundImage: NetworkImage(host.imageUrl)

                    // AssetImage("assets/images/profile.png")
                    ),
              ),
            ],
          ),
        ),
        title: Text(
          "Provider Details",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              fontFamily: "Quicksand"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetails(),
            buildDocumnets(),
          ],
        ).marginSymmetric(horizontal: 10.w, vertical: 20),
      ),
    );
  }

  Widget buildDetails() {
    DateTime dobDateTime = DateTime.fromMillisecondsSinceEpoch(host!.dob);
    String DateOfBirth = DateFormat('d MMMM yyyy ').format(dobDateTime);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Provider Details",
          style: TextStyle(
              fontFamily: "Quicksand",
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 75.h,
              width: 75.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          host.imageUrl.isEmpty ? image_url : host.imageUrl)
                      // AssetImage("assets/images/user-image.png")
                      )),
            ).marginOnly(right: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  host.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 220.w,
                  child: Text(
                    host.address,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                    ),
                    maxLines: null,
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
                        text: "${DateOfBirth}",
                        style: TextStyle(
                            color: Colors.black,
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
                        text: " ${host.gender}",
                        style: TextStyle(
                            color: Colors.black,
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
                        text: " ${host.email}",
                        style: TextStyle(
                            color: Colors.black,
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
                        text: "  ${host.phoneNumber}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp))
                  ])),
            ),
          ],
        ).marginSymmetric(vertical: 10.h),
        Text(
          host.profileDescription,
          style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
          textAlign: TextAlign.start,
        ).marginSymmetric(vertical: 8.h),
        Row(
          children: [
            Expanded(
                child: CustomButton(
              height: 46.h,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700),
              title: "Decline Account",
              onPressed: () async {
                _controller.loading.value = true;
                await deleteDirectory(
                    "User/Host${uid}/IdentityProof/insurancePath");
                await deleteDirectory(
                    "User/Host${uid}/IdentityProof/idFrontPath/");
                await deleteDirectory(
                    "User/Host${uid}/IdentityProof/idBackPath/");
                await usersRef.doc(host.uid).delete().then((value) {
                  FCM.sendMessageSingle(
                      "Alert",
                      "Your host Account has been Rejected!",
                      host!.notificationToken.toString(), {});

                  Get.snackbar("Alert", "Account Reject",
                      backgroundColor: AppColors.appPrimaryColor,
                      colorText: Colors.white);
                  _controller.loading.value = false;
                });
              },
              color: Color(0xFFFE0000),
            )),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
                child: CustomButton(
              height: 46.h,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700),
              title: "Approve Account",
              onPressed: () async {
                await usersRef
                    .doc(host.uid)
                    .update({"isVerified": true}).then((value) {
                  Get.snackbar("Alert", "Account Approved",
                      backgroundColor: AppColors.appPrimaryColor,
                      colorText: Colors.white);
                });
              },
              color: Color(0xFF0F9D58),
            )),
          ],
        ).marginSymmetric(vertical: 8.h)
      ],
    );
  }

  Widget buildDocumnets() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Insurance Certificate",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              fontFamily: "Quicksand",
              color: Colors.black),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 220.h,
            width: 440.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(host.hostIdentity!.insurancePath.isEmpty
                        ? image_url
                        : host.hostIdentity!.insurancePath),
                    fit: BoxFit
                        .fill // AssetImage("assets/images/insurance.png"),
                    )),
          ),
        ).marginAll(20),
        RichText(
            text: TextSpan(
                text: "National ID ",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    fontFamily: "Quicksand",
                    color: Colors.black),
                children: [
              TextSpan(
                text: "(Front)",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    fontFamily: "Quicksand",
                    color: Colors.black.withOpacity(.5)),
              )
            ])),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 220.h,
            width: 440.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(host.hostIdentity!.idFrontPath),
                    fit: BoxFit.fill
                    // AssetImage("assets/images/insurance.png"),
                    )),
          ),
        ).marginAll(20),
        RichText(
            text: TextSpan(
                text: "National ID ",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    fontFamily: "Quicksand",
                    color: Colors.black),
                children: [
              TextSpan(
                text: "(Back)",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    fontFamily: "Quicksand",
                    color: Colors.black.withOpacity(.5)),
              )
            ])),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 220.h,
            width: 440.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(host.hostIdentity!.idBackPath),
                    fit: BoxFit.fill
                    // AssetImage("assets/images/insurance.png"),
                    )),
          ),
        ).marginAll(20),
      ],
    ));
  }

  ScreenProviderDetails({
    required this.host,
  });
}
