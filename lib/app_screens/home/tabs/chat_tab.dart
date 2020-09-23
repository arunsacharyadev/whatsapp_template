import 'package:flutter/material.dart';
import 'package:whatsapp_template/app_utils/ui_components.dart';
import 'package:whatsapp_template/app_utils/util_functions.dart';

class ChatTab extends StatefulWidget {
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: PageStorageKey('chat'),
      shrinkWrap: true,
      itemCount: _chatData.length,
      itemBuilder: (context, index) {
        return UiComponents.buildChatListTile(
          context: context,
          index: index,
          chatData: _chatData[index],
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 76.0,
          endIndent: 10.0,
          thickness: 0.8,
          height: 5.0,
        );
      },
    );
  }
}

List<Map<String, dynamic>> _chatData = [
  {
    "contactName": "Tejas",
    "contactProfilePic": "assets/icons/double_tick.png",
    "chatContent": "WhatsApp Clone is ready 👍",
    "chatElement": ChatElement.text,
    "chatStatus": ChatStatus.read,
    "chatTime": "09:08 PM",
    "chatNotificationCount": "1"
  },
  {
    "contactName": "Rajesh",
    "contactProfilePic": "assets/icons/double_tick.png",
    "chatContent": "",
    "chatElement": ChatElement.missedVoiceCall,
    "chatStatus": "",
    "chatTime": "06:30 PM",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Sandy",
    "contactProfilePic": "assets/icons/double_tick.png",
    "chatContent": "Very Good Morning 🌻",
    "chatElement": ChatElement.text,
    "chatStatus": "",
    "chatTime": "02:34 PM",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Santhosh",
    "contactProfilePic": "assets/icons/double_tick.png",
    "chatContent": "",
    "chatElement": ChatElement.missedVideoCall,
    "chatStatus": "",
    "chatTime": "yesterday",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Keerthi Suresh",
    "contactProfilePic": "assets/icons/double_tick.png",
    "chatContent": "research.pdf (1 page)",
    "chatElement": ChatElement.document,
    "chatStatus": ChatStatus.sent,
    "chatTime": "04/05/2020",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Mahesh",
    "contactProfilePic": "assets/icons/double_tick.png",
    "chatContent": "Good night, sweet dreams 😴",
    "chatElement": ChatElement.text,
    "chatStatus": ChatStatus.delivered,
    "chatTime": "02/05/2020",
    "chatNotificationCount": "",
  },
  {
    "contactName": "sanju",
    "contactProfilePic": "assets/icons/double_tick.png",
    "chatContent": "Happy birthday 🎂🍕🍺🍾",
    "chatElement": ChatElement.text,
    "chatStatus": ChatStatus.read,
    "chatTime": "28/04/2020",
    "chatNotificationCount": "",
  },
];
