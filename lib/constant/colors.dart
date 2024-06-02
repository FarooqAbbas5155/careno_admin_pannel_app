import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors{

static MaterialColor appPrimaryColor = MaterialColor(
  0xFF4C0AE1,
  const <int, Color>{
    50: const Color(0xFF4C0AE1),
    100: const Color(0xFF4C0AE1),
    200: const Color(0xFF4C0AE1),
    300: const Color(0xFF4C0AE1),
    400: const Color(0xFF4C0AE1),
    500: const Color(0xFF4C0AE1),
    600: const Color(0xFF4C0AE1),
    700: const Color(0xFF4C0AE1),
    800: const Color(0xFF4C0AE1),
    900: const Color(0xFF4C0AE1),
  },
);
static Color greyColor=Color(0xFF505050);
static Color blackLightColor=Color(0xFF000000);
static Color starColor=Color(0xffFBC017);
static Color dividerColor=Color(0xff999999);
static Color dividerColor2=Color(0xffEDEEEE);
static Color signTextColor=Color(0xff808080);
static Color greyTextColor=Color(0xff616161);
static Color greyHeadingTextColor=Color(0xff828282);
static Color backGroundColor=Color(0xffF5F6FA);
static TextStyle headingStyle=TextStyle(
  color: appPrimaryColor,
  fontWeight: FontWeight.w800,
  fontSize: 45.sp,
  fontFamily: "Nunito"
);



}
