import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_template/app_utils/app_theme.dart';
import 'package:whatsapp_template/app_utils/size_config.dart';
import 'package:whatsapp_template/app_utils/util_functions.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final double elevation;
  final Color backgroundColor;
  final Icon icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const CircularButton(
      {Key key,
      this.width: 60,
      this.height: 60,
      this.elevation: 5.0,
      @required this.backgroundColor,
      @required this.icon,
      this.iconColor: Colors.white,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      elevation: elevation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: icon,
          color: iconColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class UiComponents {
  static Widget heading(
      {@required BuildContext context, @required String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 30.0, 10.0),
      child: Container(
        width: double.infinity,
        child: Text(
          title.toString(),
          style: TextStyle(
            fontSize: SizeConfig.textScaleFactor * 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
      ),
    );
  }

  static Widget buildSettingsListTile({
    @required BuildContext context,
    Widget leading,
    IconData leadingIcon,
    String leadingImage,
    String title,
    String subtitle,
    Widget trailing,
    EdgeInsetsGeometry contentPadding,
    void callback(),
  }) {
    return ListTile(
      leading: (leading != null)
          ? leading
          : (leadingIcon != null)
              ? AspectRatio(
                  aspectRatio: SizeConfig.textScaleFactor * 0.6,
                  child: Icon(
                    leadingIcon,
                    size: SizeConfig.textScaleFactor * 25,
                    color: Theme.of(context).accentIconTheme.color,
                  ),
                )
              : (leadingImage != null)
                  ? AspectRatio(
                      aspectRatio: SizeConfig.textScaleFactor * 0.5,
                      child: SvgPicture.asset(
                        leadingImage.toString(),
                        color: Theme.of(context).accentIconTheme.color,
                      ),
                    )
                  : null,
      title: Text(title.toString()),
      contentPadding: contentPadding,
      subtitle: (subtitle != null) ? Text(subtitle.toString()) : null,
      trailing: trailing,
      onTap: callback,
    );
  }

  static Widget buildSwitch({
    @required ValueNotifier<bool> valueNotifier,
    @required void callback(bool),
  }) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, _) {
        return Switch(
          inactiveThumbColor: AppTheme.chatBackground,
          activeTrackColor: AppTheme.tealGreenLight.withOpacity(0.2),
          value: value,
          onChanged: callback,
        );
      },
    );
  }

  static Widget buildRadioListTile({
    @required String title,
    @required ValueNotifier<dynamic> groupValueNotifier,
    @required dynamic value,
    @required void callback(dynamic),
    ListTileControlAffinity controlAffinity: ListTileControlAffinity.leading,
  }) {
    return ValueListenableBuilder(
      valueListenable: groupValueNotifier,
      builder: (context, groupValue, _) {
        return RadioListTile(
          title: Text(title.toString()),
          controlAffinity: controlAffinity,
          value: value,
          groupValue: groupValue,
          onChanged: (callback != null)
              ? callback
              : (val) {
                  groupValueNotifier.value = val;
                },
        );
      },
    );
  }

  static Future<dynamic> showThemeDialog({
    @required BuildContext context,
    @required ValueNotifier<dynamic> groupValueNotifier,
    void callback1(dynamic),
    void callback2(dynamic),
    void callback3(dynamic),
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: Text("Choose Theme"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildRadioListTile(
                    title: "System default",
                    groupValueNotifier: groupValueNotifier,
                    value: 0,
                    callback: callback1,
                  ),
                  buildRadioListTile(
                    title: "Light",
                    groupValueNotifier: groupValueNotifier,
                    value: 1,
                    callback: callback2,
                  ),
                  buildRadioListTile(
                    title: "Dark",
                    groupValueNotifier: groupValueNotifier,
                    value: 2,
                    callback: callback3,
                  ),
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, "OK");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<dynamic> showFontSizeDialog({
    @required BuildContext context,
    @required ValueNotifier<dynamic> groupValueNotifier,
    void callback1(dynamic),
    void callback2(dynamic),
    void callback3(dynamic),
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: Text("Font Size"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRadioListTile(
                    title: "Small",
                    groupValueNotifier: groupValueNotifier,
                    value: 0,
                    callback: callback1,
                  ),
                  buildRadioListTile(
                    title: "Medium",
                    groupValueNotifier: groupValueNotifier,
                    value: 1,
                    callback: callback2,
                  ),
                  buildRadioListTile(
                    title: "Large",
                    groupValueNotifier: groupValueNotifier,
                    value: 2,
                    callback: callback3,
                  ),
                ],
              ),
            ),
          );
        });
  }

  static buildChatStatus(var chatStatus) {
    switch (chatStatus) {
      case ChatStatus.sent:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.done,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );
        break;
      case ChatStatus.delivered:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Image.asset(
            'assets/icons/double_tick.png',
            color: AppTheme.greyColor,
            width: SizeConfig.textScaleFactor * 18,
            height: SizeConfig.textScaleFactor * 18,
          ),
        );
        break;
      case ChatStatus.read:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Image.asset(
            'assets/icons/double_tick.png',
            color: AppTheme.checkMarkBlue,
            width: SizeConfig.textScaleFactor * 18,
            height: SizeConfig.textScaleFactor * 18,
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }

  static buildChatElement(var chatElement) {
    switch (chatElement) {
      case ChatElement.photo:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.image,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );
        break;
      case ChatElement.document:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.description,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );
        break;
      case ChatElement.video:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.videocam,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );
        break;
      case ChatElement.audio:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.volume_up,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );
        break;
      case ChatElement.missedVoiceCall:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.phone_missed,
                size: SizeConfig.textScaleFactor * 20.0,
                color: Colors.redAccent,
              ),
            ),
            Text('Missed Voice Call'),
          ],
        );
        break;
      case ChatElement.missedVideoCall:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.missed_video_call,
                size: SizeConfig.textScaleFactor * 24.0,
                color: Colors.redAccent,
              ),
            ),
            Text('Missed Video Call'),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  static Widget buildChatListTile({
    @required BuildContext context,
    int index,
    Map<String, dynamic> chatData,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: (chatData['contactProfilePic'].toString().isNotEmpty)
            ? AssetImage('${chatData['contactProfilePic']}')
            : AssetImage('assets/profiles/person_dp.png'),
        radius: SizeConfig.textScaleFactor * 28.0,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          chatData['contactName'].toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildChatStatus(chatData['chatStatus']),
          buildChatElement(chatData['chatElement']),
          if (chatData['chatContent'] != null &&
              chatData['chatContent'].toString().isNotEmpty)
            Flexible(
              child: Text(
                "${chatData['chatContent']}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${chatData['chatTime']}",
            style: TextStyle(
              color: (chatData['chatNotificationCount'] != null &&
                      chatData['chatNotificationCount'].toString().isNotEmpty)
                  ? Theme.of(context).floatingActionButtonTheme.backgroundColor
                  : null,
            ),
          ),
          Badge(
            showBadge: (chatData['chatNotificationCount'] != null &&
                    chatData['chatNotificationCount'].toString().isNotEmpty)
                ? true
                : false,
            badgeColor:
                Theme.of(context).floatingActionButtonTheme.backgroundColor,
            badgeContent: Text(
              chatData['chatNotificationCount'].toString(),
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
