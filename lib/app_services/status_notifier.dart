class StatusNotifier {
  static Map<String, dynamic> _statusData = {
    "my_status": {
      "statusPic": "",
      "statusCount": "",
      "StatusTime": "",
    },
    "recent_updates": [
      {
        "contactName": "Flutter Developer",
        "contactStatusPic": "assets/status/status1.jpeg",
        "statusCount": "1",
        "StatusTime": "18 minutes ago",
      },
      {
        "contactName": "Kajal",
        "contactStatusPic": "assets/status/status2.jpeg",
        "statusCount": "2",
        "StatusTime": "Today, 5:40 PM",
      },
      {
        "contactName": "Keerthi",
        "contactStatusPic": "assets/status/status3.jpeg",
        "statusCount": "4",
        "StatusTime": "Today, 2:51 PM",
      },
      {
        "contactName": "Manju",
        "contactStatusPic": "assets/status/status4.jpeg",
        "statusCount": "2",
        "StatusTime": "Today, 2:43 PM",
      },
      {
        "contactName": "Ramesh",
        "contactStatusPic": "assets/status/status5.jpeg",
        "statusCount": "8",
        "StatusTime": "Today, 2:28 PM",
      },
      {
        "contactName": "Rohit",
        "contactStatusPic": "assets/status/status6.jpeg",
        "statusCount": "4",
        "StatusTime": "Today, 11:02 AM",
      },
    ],
    "viewed_updates": [
      {
        "contactName": "Sanju",
        "contactStatusPic": "assets/status/status2.jpeg",
        "statusCount": "2",
        "StatusTime": "Yesterday, 10:09 PM",
      },
      {
        "contactName": "John",
        "contactStatusPic": "assets/status/status4.jpeg",
        "statusCount": "4",
        "StatusTime": "Yesterday, 7:08 PM",
      },
    ],
  };

  static Future getStatusData() async {
    return _statusData;
  }
}
