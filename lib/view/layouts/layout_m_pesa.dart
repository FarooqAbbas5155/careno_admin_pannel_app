import 'package:careno_admin_pannel_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/my_helper_by_callofcoding.dart';
import '../../models/withdraw_request_model.dart';
import '../../widgets/custom_button.dart';

class LayoutMPesa extends StatefulWidget {
  final List<WithdrawRequestModel> mpesa;

  LayoutMPesa({required this.mpesa});

  @override
  State<LayoutMPesa> createState() => _LayoutMPesaState();
}

class _LayoutMPesaState extends State<LayoutMPesa> {

  bool approveLoading = false;
  bool rejectLoading = false;

  @override
  Widget build(BuildContext context) {
    return widget.mpesa.isNotEmpty? ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.mpesa.length,
      itemBuilder: (BuildContext context, int index) {
        var withdraw = widget.mpesa[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 14.h,horizontal: 10.w),
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage(withdraw.profilePic!),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      "${withdraw.hostName}",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "${withdraw.amount}\$",
                    style: TextStyle(
                      color: AppColors.appPrimaryColor,
                      fontFamily: "Nunito",
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      withdraw.hostPhoneNumber!.isNotEmpty ? "${withdraw.hostPhoneNumber}" : 'N/A',
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 12.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      "${withdraw.email}",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 12.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ).marginSymmetric(horizontal: 24.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                     loading: approveLoading,
                    width: 110.w,
                    height: 40.h,
                    title: 'Approve',
                    color: Colors.green,
                    textStyle: TextStyle(fontSize: 14.sp,fontFamily: "Nunito",fontWeight: FontWeight.w600,color: Colors.white),
                    onPressed: () async {
                      setState(() {
                        approveLoading = true;
                      });
                    // String hostAccountId = "acct_1NqD7LHjefWyyt1Q";
                    // int amountInCents = 50; // Example: $50.00 (5000 cents)
                    // await controller.createTransferToTestAccount(hostAccountId, amountInCents);

                    await approvePayment(withdraw);

                    setState(() {
                      approveLoading = false;
                    });


                  },).paddingSymmetric(horizontal: 20.w),
                  CustomButton(
                    loading: rejectLoading,
                    width: 120.w,
                    height: 40.h,
                    title: 'Cancel',
                    color: Colors.red,
                    textStyle: TextStyle(fontSize: 14.sp,fontFamily: "Nunito",fontWeight: FontWeight.w600,color: Colors.white),
                    onPressed: () async {
                      setState(() {
                        rejectLoading = true;
                      });
                    await rejectPayment(withdraw);
                    setState(() {
                      rejectLoading = false;
                    });
                  },).paddingSymmetric(horizontal: 20.w),
                ],
              ).marginSymmetric(vertical: 4.h),
            ],
          ),
        );
      },
    ):    Center(
        child: Icon(Icons.hourglass_empty_rounded
        ) );
  }
}
