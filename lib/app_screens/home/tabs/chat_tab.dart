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
      physics: BouncingScrollPhysics(),
      key: PageStorageKey('chatTabKey'),
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
    "contactName": "Flutter Developer",
    "contactProfilePic": "assets/profiles/profile6.jpeg",
    "chatContent": "WhatsApp Clone is ready 👍",
    "chatElement": ChatElement.text,
    "chatStatus": "",
    "chatTime": "09:08 PM",
    "chatNotificationCount": "1"
  },
  {
    "contactName": "John",
    "contactProfilePic": "assets/profiles/profile2.jpeg",
    "chatContent": "",
    "chatElement": ChatElement.missedVoiceCall,
    "chatStatus": "",
    "chatTime": "06:30 PM",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Albert",
    "contactProfilePic": "assets/profiles/profile5.jpeg",
    "chatContent": "Very Good Morning 🌻",
    "chatElement": ChatElement.text,
    "chatStatus": ChatStatus.read,
    "chatTime": "08:34 AM",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Kajal",
    "contactProfilePic": "assets/profiles/profile1.jpg",
    "chatContent": "",
    "chatElement": ChatElement.missedVideoCall,
    "chatStatus": "",
    "chatTime": "yesterday",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Sanju",
    "contactProfilePic": "assets/profiles/profile3.jpeg",
    "chatContent": "research.pdf (1 page)",
    "chatElement": ChatElement.document,
    "chatStatus": ChatStatus.sent,
    "chatTime": "22/05/2020",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Keerthi",
    "contactProfilePic": "assets/profiles/profile4.jpeg",
    "chatContent": "Good night, sweet dreams 😴",
    "chatElement": ChatElement.text,
    "chatStatus": ChatStatus.delivered,
    "chatTime": "10/05/2020",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Rohit",
    "contactProfilePic": "",
    "chatContent": "Happy Birthday 🎂🍰🍟🍔🍺",
    "chatElement": ChatElement.photo,
    "chatStatus": ChatStatus.delivered,
    "chatTime": "06/05/2020",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Manju",
    "contactProfilePic": "",
    "chatContent": "Pushpa.mp4",
    "chatElement": ChatElement.video,
    "chatStatus": ChatStatus.read,
    "chatTime": "05/05/2020",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Arjun",
    "contactProfilePic": "",
    "chatContent": "Audio",
    "chatElement": ChatElement.audio,
    "chatStatus": ChatStatus.read,
    "chatTime": "03/05/2020",
    "chatNotificationCount": "",
  },
  {
    "contactName": "Best Buddy's",
    "contactProfilePic": "",
    "chatContent": "Happy Engineer's Day",
    "chatElement": ChatElement.photo,
    "chatStatus": ChatStatus.read,
    "chatTime": "15/09/2020",
    "chatNotificationCount": "",
  },
];
