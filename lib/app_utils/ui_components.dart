import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_theme.dart';
import 'size_config.dart';
import 'util_functions.dart';

/// Build Circular Button
class BuildCircularButton extends StatelessWidget {
  /// ## Creates a Circular Button
  const BuildCircularButton({
    Key? key,
    this.width = 60,
    this.height = 60,
    this.elevation = 5.0,
    required this.backgroundColor,
    required this.icon,
    this.iconColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;
  final double elevation;
  final Color? backgroundColor;
  final Icon icon;
  final Color iconColor;
  final VoidCallback? onPressed;

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
          padding: EdgeInsets.zero,
          icon: icon,
          color: iconColor,
          onPressed: onPressed ?? () {},
        ),
      ),
    );
  }
}

/// Build Heading
class BuildHeading extends StatelessWidget {
  /// ## Creates a Heading
  const BuildHeading({
    Key? key,
    required this.context,
    required this.title,
  }) : super(key: key);
  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 30.0, 10.0),
      child: SizedBox(
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
}

/// Build Switch
class BuildSwitch extends StatelessWidget {
  /// ## Creates a Switch
  const BuildSwitch({
    Key? key,
    required this.valueNotifier,
    required this.callback,
  }) : super(key: key);

  final ValueNotifier<bool>? valueNotifier;
  final ValueChanged<bool> callback;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier!,
      builder: (context, dynamic value, _) {
        return Switch(
          inactiveThumbColor: AppTheme.chatBackground,
          activeTrackColor: AppTheme.tealGreenLight.withOpacity(0.2),
          value: value,
          onChanged: callback,
        );
      },
    );
  }
}

/// Build RadioListTile
class BuildRadioListTile extends StatelessWidget {
  /// ## Creates a RadioListTile
  const BuildRadioListTile({
    Key? key,
    required this.title,
    required this.groupValueNotifier,
    required this.value,
    required this.callback,
    this.controlAffinity = ListTileControlAffinity.leading,
  }) : super(key: key);

  final String title;
  final ValueNotifier<dynamic>? groupValueNotifier;
  final dynamic value;
  final ValueChanged<dynamic>? callback;
  final ListTileControlAffinity controlAffinity;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: groupValueNotifier!,
      builder: (context, dynamic groupValue, _) {
        return RadioListTile(
          title: Text(title.toString()),
          controlAffinity: controlAffinity,
          value: value,
          groupValue: groupValue,
          onChanged: (callback != null)
              ? callback
              : (dynamic val) {
                  groupValueNotifier!.value = val;
                },
        );
      },
    );
  }
}

/// ## build PopupMenuItem
PopupMenuItem buildPopupMenuItem({
  required String title,
  VoidCallback? callback,
}) {
  return PopupMenuItem(
    child: ListTile(
      title: Text(title.toString()),
      visualDensity: VisualDensity.compact,
      onTap: callback,
    ),
  );
}

/// Build Settings List Tile
class BuildSettingsListTile extends StatelessWidget {
  /// ## Creates a Settings List Tile
  const BuildSettingsListTile({
    Key? key,
    required this.context,
    this.leading,
    this.leadingIcon,
    this.leadingImage,
    this.title,
    this.subtitle,
    this.trailing,
    this.contentPadding,
    this.callback,
  })  : assert(leading == null || leadingIcon == null || leadingImage == null,
            'Use one property either [leading] or [leadingIcon] or [leadingImage]'),
        super(key: key);

  final BuildContext context;
  final Widget? leading;
  final IconData? leadingIcon;
  final String? leadingImage;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? contentPadding;
  final GestureTapCallback? callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (leading != null)
          ? leading
          : (leadingIcon != null)
              ? AspectRatio(
                  aspectRatio: SizeConfig.textScaleFactor * 0.6,
                  child: Icon(
                    leadingIcon,
                    size: SizeConfig.textScaleFactor * 25,
                    color: Theme.of(context).iconTheme.color,
                  ),
                )
              : (leadingImage != null)
                  ? AspectRatio(
                      aspectRatio: SizeConfig.textScaleFactor * 0.5,
                      child: SvgPicture.asset(
                        leadingImage.toString(),
                        color: Theme.of(context).iconTheme.color,
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
}

/// Build Chat List Tile
class BuildChatListTile extends StatelessWidget {
  /// ## Creates a Chat List Tile
  const BuildChatListTile({
    Key? key,
    required this.context,
    required this.index,
    required this.chatData,
  }) : super(key: key);

  /// ## context
  final BuildContext context;

  /// ## index
  final int index;

  /// ## chat Data
  /// Data should be as per the below format
  /// ```
  /// {
  ///   "contactName": "Flutter Developer",
  ///   "contactProfilePic": "assets/profiles/profile6.jpeg",
  ///   "chatContent": "WhatsApp Clone is ready 👍",
  ///   "chatElement": ChatElement.text,
  ///   "chatStatus": "",
  ///   "chatTime": "09:08 PM",
  ///   "chatNotificationCount": "1"
  /// }
  /// ```
  final Map<String, dynamic> chatData;

  /// Build chat status
  buildChatStatus(var chatStatus) {
    switch (chatStatus) {

      /// Sent
      case ChatStatus.sent:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.done,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );

      /// Delivered
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

      /// Read
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
      default:
        return Container();
    }
  }

  /// build chat element
  buildChatElement(var chatElement) {
    switch (chatElement) {

      /// Photo
      case ChatElement.photo:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.image,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );

      /// Document
      case ChatElement.document:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.description,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );

      /// Video
      case ChatElement.video:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.videocam,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );

      /// Audio
      case ChatElement.audio:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.volume_up,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.greyColor,
          ),
        );

      /// Missed voice call
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
                color: AppTheme.redAccent,
              ),
            ),
            Text('Missed Voice Call'),
          ],
        );

      /// Missed video call
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
                color: AppTheme.redAccent,
              ),
            ),
            Text('Missed Video Call'),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Theme.of(context).floatingActionButtonTheme.backgroundColor!,
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

/// Build Call List Tile
class BuildCallListTile extends StatelessWidget {
  /// ## Creates a Call List Tile
  const BuildCallListTile({
    Key? key,
    required this.context,
    required this.index,
    required this.callData,
  }) : super(key: key);

  /// ## context
  final BuildContext context;

  /// ## index
  final int index;

  /// ## call Data
  /// Data should be as per the below format
  /// ```
  /// {
  ///   "contactName": "Flutter Developer",
  ///   "contactProfilePic": "assets/profiles/profile6.jpeg",
  ///   "callStatus": CallStatus.call_missed_incoming,
  ///   "callFrequency": "2",
  ///   "callTime": "September 14, 3:38 PM",
  ///   "callType": CallType.voice
  /// }
  /// ```
  final Map<String, dynamic> callData;

  /// build call status
  buildCallStatus(BuildContext context, var callStatus) {
    switch (callStatus) {

      /// call made
      case CallStatus.call_made:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.call_made,
            size: SizeConfig.textScaleFactor * 20.0,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          ),
        );

      /// call received
      case CallStatus.call_received:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.call_received,
            size: SizeConfig.textScaleFactor * 20.0,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          ),
        );

      /// call missed incoming
      case CallStatus.call_missed_incoming:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.call_received,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.redAccent,
          ),
        );

      /// call missed outgoing
      case CallStatus.call_missed_outgoing:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.call_made,
            size: SizeConfig.textScaleFactor * 20.0,
            color: AppTheme.redAccent,
          ),
        );

      /// call merge
      case CallStatus.call_merge:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.call_merge,
            size: SizeConfig.textScaleFactor * 20.0,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          ),
        );

      /// call split
      case CallStatus.call_split:
        return Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.call_split,
            size: SizeConfig.textScaleFactor * 20.0,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          ),
        );
      default:
        return Container();
    }
  }

  /// build call type
  buildCallType(BuildContext context, var callType) {
    switch (callType) {

      /// voice
      case CallType.voice:
        return Icon(
          Icons.call,
          size: SizeConfig.textScaleFactor * 24.0,
          color: AppTheme.tealGreenLight,
        );

      /// video
      case CallType.video:
        return Icon(
          Icons.videocam,
          size: SizeConfig.textScaleFactor * 24.0,
          color: AppTheme.tealGreenLight,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: (callData['contactProfilePic'].toString().isNotEmpty)
            ? AssetImage('${callData['contactProfilePic']}')
            : AssetImage('assets/profiles/person_dp.png'),
        radius: SizeConfig.textScaleFactor * 28.0,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          callData['contactName'].toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildCallStatus(context, callData['callStatus']),
          Flexible(
            child: Text(
              "${(callData['callFrequency'] != null && int.parse('${callData['callFrequency']}') > 1) ? "(${callData['callFrequency']})" : ""} ${callData['callTime']}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      trailing: buildCallType(context, callData['callType']),
    );
  }
}

/// No Records Found
class NoRecordsFound extends StatelessWidget {
  final String message;

  const NoRecordsFound({
    Key? key,
    this.message = 'No Records Found',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(message.toString()),
      ),
    );
  }
}

/// Show Theme Dialog
Future<dynamic> showThemeDialog({
  required BuildContext context,
  required ValueNotifier<dynamic>? groupValueNotifier,
  ValueChanged<dynamic>? callback1,
  ValueChanged<dynamic>? callback2,
  ValueChanged<dynamic>? callback3,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text('Choose Theme'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildRadioListTile(
                  title: 'System default',
                  groupValueNotifier: groupValueNotifier,
                  value: 0,
                  callback: callback1,
                ),
                BuildRadioListTile(
                  title: 'Light',
                  groupValueNotifier: groupValueNotifier,
                  value: 1,
                  callback: callback2,
                ),
                BuildRadioListTile(
                  title: 'Dark',
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
                  'CANCEL',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, 'OK');
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Text(
                  'OK',
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

/// Show Font Size Dialog
Future<dynamic> showFontSizeDialog({
  required BuildContext context,
  required ValueNotifier<dynamic>? groupValueNotifier,
  ValueChanged<dynamic>? callback1,
  ValueChanged<dynamic>? callback2,
  ValueChanged<dynamic>? callback3,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text('Font Size'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildRadioListTile(
                  title: 'Small',
                  groupValueNotifier: groupValueNotifier,
                  value: 0,
                  callback: callback1,
                ),
                BuildRadioListTile(
                  title: 'Medium',
                  groupValueNotifier: groupValueNotifier,
                  value: 1,
                  callback: callback2,
                ),
                BuildRadioListTile(
                  title: 'Large',
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

/// highlight Occurrences
List<TextSpan> highlightOccurrences(String? source, String query) {
  if (query.isEmpty || !source!.toLowerCase().contains(query.toLowerCase())) {
    return [TextSpan(text: source)];
  }
  final matches = query.toLowerCase().allMatches(source.toLowerCase());

  int lastMatchEnd = 0;

  final List<TextSpan> children = [];
  for (var i = 0; i < matches.length; i++) {
    final match = matches.elementAt(i);

    if (match.start != lastMatchEnd) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, match.start),
      ));
    }

    children.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: TextStyle(color: AppTheme.checkMarkBlue),
    ));

    if (i == matches.length - 1 && match.end != source.length) {
      children.add(TextSpan(
        text: source.substring(match.end, source.length),
      ));
    }

    lastMatchEnd = match.end;
  }
  return children;
}

///contact permission
Future showContactPermission({
  BuildContext? context,
}) async {
  String content = '';
  bool permanentlyDenied = false;
  if (await Permission.contacts.isPermanentlyDenied) {
    permanentlyDenied = true;
    content = 'To help you message friends and family on whatsApp,'
        'allow WhatsApp access to your contacts.'
        'Tap Settings > Permissions, and turn Contacts on.';
  } else {
    permanentlyDenied = false;
    content = 'To help you connect with friends and family,'
        'allow WhatsApp access to your contacts.';
  }
  if (await Permission.contacts.isGranted) {
    return Future.value('GRANTED');
  } else {
    return await showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) {
        SizeConfig().init(context);
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: AspectRatio(
            aspectRatio: (SizeConfig.screenOrientation == Orientation.portrait)
                ? 2.5
                : 5,
            child: Container(
              color: AppTheme.tealGreenLight,
              child: Center(
                child: Icon(
                  Icons.contacts,
                  size: SizeConfig.textScaleFactor * 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          content: Text(content),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context, 'Not Now');
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                child: Text(
                  'NOT NOW',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
            if (!permanentlyDenied)
              InkWell(
                onTap: () {
                  Navigator.pop(context, 'CONTINUE');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
            if (permanentlyDenied)
              InkWell(
                onTap: () {
                  Navigator.pop(context, 'SETTINGS');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

///camera permission
Future checkCameraPermission({
  BuildContext? context,
}) async {
  String content = '';
  bool permanentlyDenied = false;
  if (await Permission.camera.isPermanentlyDenied) {
    permanentlyDenied = true;
    content = 'To capture photos and videos,'
        'allow WhatsApp access to your camera.'
        'Tap Settings > Permissions, and turn Camera on.';
  } else {
    permanentlyDenied = false;
    content = 'To capture photos and videos,'
        'allow WhatsApp access to your camera.';
  }
  if (await Permission.camera.isGranted) {
    return Future.value('GRANTED');
  } else {
    return await showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) {
        SizeConfig().init(context);
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: AspectRatio(
            aspectRatio: (SizeConfig.screenOrientation == Orientation.portrait)
                ? 2.5
                : 5,
            child: Container(
              color: AppTheme.tealGreenLight,
              child: Center(
                child: Icon(
                  Icons.camera_alt,
                  size: SizeConfig.textScaleFactor * 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          content: Text(
            content,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context, 'NOT NOW');
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                child: Text(
                  'NOT NOW',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
            if (!permanentlyDenied)
              InkWell(
                onTap: () {
                  Navigator.pop(context, 'CONTINUE');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
            if (permanentlyDenied)
              InkWell(
                onTap: () {
                  Navigator.pop(context, 'SETTINGS');
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

///show Permission Dialog
Future showPermissionDialog({
  required BuildContext context,
  required Map<Permission, PermissionStatus> permissionStatus,
  required String permissionTitle,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      SizeConfig().init(context);
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: permissionDialogTitle(permissionStatus),
        content: Text(
          getPermissionDialogContent(permissionTitle, permissionStatus),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context, 'NOT NOW');
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
              child: Text(
                'NOT NOW',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ),
          ),
          if (!permissionStatus.values
              .contains(PermissionStatus.permanentlyDenied))
            InkWell(
              onTap: () {
                Navigator.pop(context, 'CONTINUE');
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                child: Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
          if (permissionStatus.values
              .contains(PermissionStatus.permanentlyDenied))
            InkWell(
              onTap: () {
                Navigator.pop(context, 'SETTINGS');
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                child: Text(
                  'SETTINGS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );
}

///permission Dialog Title
Widget permissionDialogTitle(
    Map<Permission, PermissionStatus> permissionStatus) {
  return AspectRatio(
    aspectRatio:
        (SizeConfig.screenOrientation == Orientation.portrait) ? 2.5 : 5,
    child: Container(
      color: AppTheme.tealGreenLight,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            permissionStatus.length,
            (index) {
              if (permissionStatus[permissionStatus.keys.elementAt(index)] !=
                  PermissionStatus.granted) {
                Widget buildAddIcon() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.add_rounded,
                      size: SizeConfig.textScaleFactor * 30.0,
                      color: Colors.white,
                    ),
                  );
                }

                var _permission = permissionStatus.keys.elementAt(index);
                debugPrint('_permission:\t$_permission');
                if (_permission == Permission.storage) {
                  if (index < permissionStatus.length - 1) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.folder,
                          size: SizeConfig.textScaleFactor * 40.0,
                          color: Colors.white,
                        ),
                        buildAddIcon(),
                      ],
                    );
                  } else {
                    return Icon(
                      Icons.folder,
                      size: SizeConfig.textScaleFactor * 40.0,
                      color: Colors.white,
                    );
                  }
                } else if (_permission == Permission.camera) {
                  if (index < permissionStatus.length - 1) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: SizeConfig.textScaleFactor * 40.0,
                          color: Colors.white,
                        ),
                        buildAddIcon(),
                      ],
                    );
                  } else {
                    return Icon(
                      Icons.camera_alt,
                      size: SizeConfig.textScaleFactor * 40.0,
                      color: Colors.white,
                    );
                  }
                } else if (_permission == Permission.contacts) {
                  if (index < permissionStatus.length - 1) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.contacts,
                          size: SizeConfig.textScaleFactor * 40.0,
                          color: Colors.white,
                        ),
                        buildAddIcon(),
                      ],
                    );
                  } else {
                    return Icon(
                      Icons.contacts,
                      size: SizeConfig.textScaleFactor * 40.0,
                      color: Colors.white,
                    );
                  }
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    ),
  );
}
