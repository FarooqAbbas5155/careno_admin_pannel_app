import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../constant/database_utils.dart';
import '../../constant/fcm.dart';
import '../../constant/helpers.dart';
import '../../models/last_message.dart';
import '../../models/message.dart';
import '../../models/user.dart' as model;
import '../../widgets/custom_svg.dart';
import '../layouts/item_chat.dart';

class ScreenChat extends StatefulWidget {
  model.User? user;
  int? counter;
  String? chatRoomId;
  int? timeStamp;
  @override
  State<ScreenChat> createState() => _ScreenChatState();
  ScreenChat({
    this.user,
    this.counter,
    this.chatRoomId,
    this.timeStamp,
    // this.userblock,
  });
}

class _ScreenChatState extends State<ScreenChat> {

  TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();
  var chatRoomId = "";
  // late Stream<DatabaseEvent> stream;
  bool isActive=false;
  bool isBlocked = false;
  String message = "";
  Stream<DatabaseEvent> stream = Stream.empty();
  RxList<LastMessage> rooms = RxList<LastMessage>([]);
  void listenToChatRooms() {
    usersRef.doc(uid).collection("chats").snapshots().listen((snapshot) {
      List<LastMessage> newRooms = snapshot.docs.map((doc) {
        return LastMessage.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      rooms.value = newRooms;
    });
  }
  @override
  void initState() {
    print("Blocked ${isBlocked}");
    print("Blocked ${message}");
    listenToChatRooms();
    checkCondition().then((value) {
      stream = chatref.child(chatRoomId).child(uid).onValue;
      // _subscription = stream?.listen((event) {});

      print("chatRoom: $chatRoomId");
      setState(() {});

    });
    super.initState();

    // if (widget.chatRoomId == null) {
    //   roomId().then((value) => {chatRoomId = value});
    //   stream = chatref.child(chatRoomId).onValue;
    //   // clearCounter();
    // } else {
    //   chatRoomId = widget.chatRoomId!;
    //   stream = chatref.child(chatRoomId).onValue;
    //   // clearCounter();
    // }
    clearCounter();
  }
  Future<bool> checkUser() async {
    var exist = await usersRef.doc(uid)
        .collection('chats')
        .doc("${widget.user!.uid}_${uid}")
        .get();
    return exist.exists;
  }
  Future<bool> checkUser2() async {
    var exist = await usersRef.doc(uid)
        .collection('chats')
        .doc("${uid}_${widget.user!.uid}")
        .get();
    return exist.exists;
  }

  Future<void> checkCondition() async {
    if (chatRoomId == '') {
      bool userExists = await checkUser();
      if (userExists) {
        chatRoomId = "${widget.user!.uid}_${uid}";
        // clearCounter();

      } else {
        chatRoomId = "${uid}_${widget.user!.uid}";
      }
    } else {
      chatRoomId = widget.chatRoomId!;
    }
  }
  //
  // Future<String> roomId() async {
  //   String _roomId = '';
  //   bool check = await checkRoomId();
  //   if (check) {
  //     _roomId = "${widget.user.uid}_${FirebaseUtils.myId}";
  //   } else {
  //     _roomId = "${FirebaseUtils.myId}_${widget.user.uid}";
  //   }
  //   return _roomId;
  // }
  //
  // Future<bool> checkRoomId() async {
  //   DocumentSnapshot userSnapshot=await usersRef
  //       .doc(FirebaseUtils.myId)
  //       .collection("chats")
  //       .doc("${widget.user.uid}_${FirebaseUtils.myId}")
  //       .get();
  //   DocumentSnapshot mySnapshot=await usersRef
  //       .doc(FirebaseUtils.myId)
  //       .collection("chats")
  //       .doc("${FirebaseUtils.myId}_${widget.user.uid}")
  //       .get();
  //   if (userSnapshot.exists) {
  //     return userSnapshot.exists;
  //   }
  //
  //   return mySnapshot.exists;
  // }
  Future<void> clearCounter() async {
    try {
      DocumentReference chatRef = usersRef
          .doc(uid)
          .collection("chats")
          .doc(chatRoomId);

      DocumentSnapshot chatSnapshot = await chatRef.get();

      if (chatSnapshot.exists) {
        await chatRef.update({"counter": 0});
      } else {
        // Handle case when document is not found
        print("Document not found: $chatRoomId");
      }
    } catch (error) {
      // Handle error
      print("Error clearing counter: $error");
    }
  }
  void clearChat() {
    chatref
        .child(chatRoomId)
        .child(uid)
        .remove()
        .then((_) {
      setState(() {

      });
      print("Chat cleared successfully");
    })
        .catchError((error) {
      print("Error clearing chat: $error");
    });
  }
 @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(widget.user!.timeStamp);
    String formattedDateTime = DateFormat('hh:mm a').format(dateTime);
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      appBar: AppBar(
        elevation: 1,
        leadingWidth: 75.w,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10.w,),
              CustomSvg(name: "arrow",),

              Expanded(
                child: CircleAvatar(
                    radius: 35.r,
                    backgroundImage: NetworkImage(widget.user!.imageUrl)
                ),
              ),

            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.user!.name,style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.sp
            ),),
            Text("Last Seen ${formattedDateTime}",style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(.4)
            ),),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.appPrimaryColor,
                      strokeWidth: 1,
                    ),
                  );
                }
                var data = snapshot.data!.snapshot.value;
                if (data == null) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                           "No Messages",style: TextStyle(color: AppColors.appPrimaryColor),),
                      ],
                    ),
                  );
                }
                clearCounter();
                List<Message> messages = snapshot.data!.snapshot.children.map((e) => Message.fromMap(
                  Map<String, dynamic>.from(e.value as dynamic),
                )).toList();
                messages.sort((b, a) => a.timestamp.compareTo(b.timestamp));
                return (messages.isNotEmpty)
                    ? SingleChildScrollView(
                      child: Builder(
                                        builder: (context) {
                      // Group messages by date
                      Map<String, List<Message>> groupedMessages =
                      groupMessagesByDate(messages);

                       return ListView.builder(
                        shrinkWrap: true, // Ensure ListView takes up only the necessary space
                        itemCount: groupedMessages.length + 1,
                        reverse: true,
                        itemBuilder: (context, index) {
                          if (index == groupedMessages.length) {
                            return SizedBox(
                              height: 10,
                            );
                          }

                          // Get messages for the current date group
                          String currentDate = groupedMessages.keys.elementAt(index);
                          List<Message> currentMessages = groupedMessages[currentDate]!;
                          var message = currentMessages.last; // Get the last message in the group

                          // Determine the display date based on the last message
                          String displayDate = getDisplayDate(DateTime.fromMillisecondsSinceEpoch(message.timestamp));

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                child: Text(
                                  displayDate,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true, // Ensure inner ListView takes only the necessary space
                                physics: NeverScrollableScrollPhysics(), // Disable scrolling of inner ListView
                                itemCount: currentMessages.length,
                                itemBuilder: (context, messageIndex) {
                                  var message = currentMessages.reversed.toList()[messageIndex];
                                  return GestureDetector(
                                    onTap: () {
                                      // Handle tap on chat message
                                    },
                                    child: ItemChat(message: message, displayDate: displayDate),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );

                                        },
                                      ),
                    )
                    : Center(
                  child: Text(
                    "No Messages",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    maxLines: 6,
                    minLines: 1,
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Write something...",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color(0xFFC6C4CC),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF2F2F2),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    if (isMessageValid) {
                      setState((){
                        if (widget.counter==null) {
                          widget.counter=1;
                        }
                        else{
                          widget.counter=widget.counter!+ 1;

                        }
                      });

                    }
                    String text = messageController.text.trim();
                    int timestamp = DateTime.now().millisecondsSinceEpoch;
                    if (text.isNotEmpty) {
                      var message = Message(
                        id: timestamp.toString(),
                        timestamp: timestamp,
                        text: text,
                        sender_id: uid,
                        receiver_id: widget.user!.uid,
                        message_type: "text",
                        counter: widget.counter ?? 0,
                      );
                      messageController.clear();
                      // controller.update();
                      sendMessage(message, chatRoomId)
                          .catchError((error) {
                        Get.snackbar("Message", error.toString());
                        print(error.toString());
                      }).then((value) {
                        animateToLastMessage(300);
                        if(widget.user!.notification == true){
                          FCM.sendMessageSingle(
                              "New Message",
                              message.text,
                              widget.user!.notificationToken.toString(),
                              {});
                        }
                      }).then((value) {
                        print(value);
                      });
                    }                  },
                  child: Container(
                    height: 48.h,
                    width: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isMessageValid = true;

  void validateMessage(String message) {
    setState(() {
      isMessageValid = ChatValidator.isMessageValid(message);
    });
  }

  void animateToLastMessage(int animateMillis) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final lastMessageOffset = _scrollController.position.minScrollExtent;
        _scrollController.animateTo(
          lastMessageOffset,
          duration: Duration(milliseconds: animateMillis),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  Map<String, List<Message>> groupMessagesByDate(List<Message> messages) {
    Map<String, List<Message>> groupedMessages = {};

    for (var message in messages) {
      // Convert timestamp to DateTime object
      DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(message.timestamp);

      // Format the date (e.g., "2023-07-12")
      String formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";

      // Add the message to the corresponding date group
      if (groupedMessages.containsKey(formattedDate)) {
        groupedMessages[formattedDate]!.add(message);
      } else {
        groupedMessages[formattedDate] = [message];
      }
    }

    return groupedMessages;
  }

  String getDisplayDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (dateTime.isAfter(today)) {
      return "Today";
    } else if (dateTime.isAfter(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat('MMM dd, yyyy').format(dateTime);
    }
  }
}
class ChatValidator {
  static final List<RegExp> blockPatterns = [
    RegExp(
        r'\b(Facebook|Instagram|Twitter|LinkedIn|Snapchat|whatsApp|Telegram|Discord|WeChat|Skype|Zoom|TikTok|Pinterest|Reddit|Tumblr|Viber|LINE|Kik|Signal|Google Hangouts|Email|Phone|Phone Number|Contact Number|Cell Phone|Cell Phone Number)\b',
        caseSensitive: false),
    RegExp(r'\b(call|phone)\b', caseSensitive: false),
    RegExp(r'\b(\d{4})\b'),
    // Matches 4-digit numbers
    RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'),
    // Email pattern
    // Add more regex patterns as needed
  ];

  static bool isMessageValid(String message) {
    for (RegExp pattern in blockPatterns) {
      if (pattern.hasMatch(message)) {
        return false;
      }
    }
    return true;
  }

}
