import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../models/user.dart';
import '../screens/screen_chat.dart';

class ItemLayoutMessage extends StatelessWidget {
  User user;
  String lastMessage;
  int timestamp,counter;
  String roomId;
  bool userBlock;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDateTime = DateFormat('hh:mm a').format(dateTime);
    return GestureDetector(
      onTap: (){
        Get.to(ScreenChat(user: user,counter: counter,chatRoomId: roomId,timeStamp: timestamp,));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: <Widget>[
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:   NetworkImage(user.imageUrl.isEmpty
                            ? image_url
                            : user.imageUrl),
                        // AssetImage("assets/images/profile.png"),
                        fit: BoxFit.fill)
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${user.name}   (${user.userType})",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp
                    ),),
                    Text(user.status,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp
                    ),),
                    Text(lastMessage,style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Color(0xFF373132),
                        overflow: TextOverflow.ellipsis
                    ),),
                  ],).marginSymmetric(horizontal: 8.h),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formattedDateTime,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500),),
                  counter == 0?SizedBox():   Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF2021),
                      shape: BoxShape.circle,

                    ),
                    child: Text(counter.toString(),style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14.sp
                    ),),
                  )
                ],),

            ],
          ).marginSymmetric(horizontal: 25.w,vertical: 5.h),
          Divider(
            indent: 80.w,
            endIndent: 14,
            color: Color(0xFF787878).withOpacity(.35),)
        ],
      ).marginSymmetric(vertical: 5.h),
    );
  }
  ItemLayoutMessage({
    required this.user,
    required this.lastMessage,
    required this.timestamp,
    required this.counter,
    required this.roomId,
    required this.userBlock,
  });
}
