import 'package:whatsapp_template/app_utils/util_functions.dart';

class ChatNotifier {
  static List<Map<String, dynamic>> _chatData = [
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
      "contactName": "Best Buddy",
      "contactProfilePic": "",
      "chatContent": "Happy Engineer's Day",
      "chatElement": ChatElement.photo,
      "chatStatus": ChatStatus.read,
      "chatTime": "15/09/2020",
      "chatNotificationCount": "",
    },
  ];

  static Future<dynamic> getChatData() async {
    return _chatData;
  }
}
