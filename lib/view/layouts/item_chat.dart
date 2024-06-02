import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant/helpers.dart';
import '../../models/message.dart';
import '../../widgets/bubble_special_three.dart';

class ItemChat extends StatelessWidget {
  Message message;
  String displayDate;

  ItemChat({
    required this.message, required  this.displayDate,
  });
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(message.timestamp);
    String formattedDateTime = DateFormat('hh:mm a').format(dateTime);
    return     BubbleSpecialThree(
      text: message.text,
      tail: false,//message.sender_id == uid ?true:false,
      sent: false,//message.sender_id == uid ?true:false,
      isSender: message.sender_id !=uid?false:true,
      seen: false,
      delivered: false,
      time: formattedDateTime,
    );
  }
}
