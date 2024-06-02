import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/helpers.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? textColor;
  final Border? border;
  final bool? loading;

  CustomButton({
    required this.title,
    this.color,
    required this.onPressed,
    this.width,
    this.height,
    this.textStyle,
    this.textColor,
    this.border,
    this.loading=false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?? 320.w,
      height: height??55.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color?? primaryColor,
            foregroundColor: Colors.grey,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            )
        ),
        child:loading == false? Text(
          title ?? 'Button',
          style: textStyle ?? TextStyle(fontSize: 22.sp,fontFamily: "Nunito", fontWeight: FontWeight.w800,color: textColor??Colors.white),
        ):CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
      ),
    );
  }
}
