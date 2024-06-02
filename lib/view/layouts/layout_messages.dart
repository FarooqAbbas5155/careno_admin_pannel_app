import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../constant/colors.dart';
import '../../constant/helpers.dart';
import '../../controllers/chat_controller.dart';
import '../../models/user.dart';
import 'item_layout_message.dart';

class LayoutMessages extends StatelessWidget {
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.backGroundColor,
          elevation: 0,
          title: Text("Messages", style: TextStyle(
              color: AppColors.appPrimaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 24.sp,
              fontFamily: "Nunito"
          ),)
      ),
      body: GetBuilder<ChatController>(
        init: chatController,
          builder: (logic) {
        return
          logic.rooms.value.isEmpty
            ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/nothing.png",
                  color: AppColors.appPrimaryColor,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                  width: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                ),
                Text(
                  "No Messages",
                  style: TextStyle(
                      color: AppColors.appPrimaryColor,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w600),
                ),
              ],
            )):
          ListView.builder(
          shrinkWrap: true,
          itemCount: logic.rooms.value.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
          var lastMessageObj = logic.rooms.value[index];

          return
            FutureBuilder<User>(
            future: getUser(
              get2ndUserId(
                lastMessageObj.chatRoomId,
                uid,
              ),
            ),
            builder: (context, snapshot) {
              User user = snapshot.connectionState == ConnectionState.waiting ? defaultUser : snapshot.data!;
              return ItemLayoutMessage(
                user: user,
                roomId: lastMessageObj.chatRoomId,
                timestamp: lastMessageObj.timestamp,
                lastMessage: lastMessageObj.lastMessage,
                counter: lastMessageObj.counter,
                userBlock: lastMessageObj.isBlocked,
              );
            },
          );
          },);
      }),
    );
  }
}
