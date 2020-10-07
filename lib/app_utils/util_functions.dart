import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_template/app_utils/ui_components.dart';

enum TabAction { camera, chat, status, call }

enum ChatStatus { sent, delivered, read }

enum ChatElement {
  text,
  photo,
  document,
  video,
  audio,
  missedVoiceCall,
  missedVideoCall
}

enum CallStatus {
  call_made,
  call_received,
  call_missed_incoming,
  call_missed_outgoing,
  call_merge,
  call_split,
}

enum CallType {
  voice,
  video,
}

/// ## Print logError
void logError({String code, String description, StackTrace stackTrace}) {
  debugPrint(
      "Exception\t ${(code != null) ? "Code: $code" : ""} ${(description != null) ? "\tMessage: $description" : ""} ${(stackTrace != null) ? "\tStackTrace: $stackTrace" : ""}");
}

/// ## get [ThemeMode] By Index
ThemeMode getThemeModeByIndex(index) {
  switch (int.parse(index.toString())) {
    case 0:
      return ThemeMode.system;
      break;
    case 1:
      return ThemeMode.light;
      break;
    case 2:
      return ThemeMode.dark;
      break;
    default:
      return ThemeMode.system;
      break;
  }
}

/// ## get [TabAction] By Index
TabAction getTabActionByIndex(int index) {
  switch (index) {
    case 0:
      return TabAction.camera;
      break;
    case 1:
      return TabAction.chat;
      break;
    case 2:
      return TabAction.status;
      break;
    case 3:
      return TabAction.call;
      break;
    default:
      return TabAction.chat;
      break;
  }
}

/// ## get Radians From Degree
///
/// Formula: Radian = Degree*(pi/180)
///
/// ```
/// For Example:
/// getRadiansFromDegree(90)          // 1.5707963267948966
/// getRadiansFromDegree(180.0+90.0)  // 4.71238898038469
/// ```
double getRadiansFromDegree(double degree) {
  return degree * (math.pi / 180).toDouble();
}

/// ## cNumeric
///
/// If [input] is not Numeric, return '0'.
///
/// If [input] is Numeric, return [input] as String.
///
/// ```
/// For Example:
/// cNumeric(3)     // '3'
/// cNumeric('bad') // '0'
/// cNumeric(null)  // '0'
/// ```
String cNumeric(input) {
  if (isNumeric(input)) {
    return "0";
  } else {
    return input.toString();
  }
}

/// ## isNumeric
///
/// If [input] is  null or not possibly signed, integer literal, return false.
///
/// If [input] is  not null and possibly signed, integer literal, return true.
///
/// ```
/// For Example:
/// isNumeric(0)    // true
/// isNumeric('2')  // true
/// isNumeric('bad')  // false
/// isNumeric(null)  // false
/// ```
bool isNumeric(input) {
  if (input == null || int.tryParse(input.toString()) == null) {
    return false;
  } else {
    return true;
  }
}

String flattenPhoneNumber(String number) {
  return number.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
    return m[0] == "+" ? "+" : "";
  });
}

///check Permission
Future checkPermission({
  @required BuildContext context,
  @required List<Permission> permissionElement,
  @required String permissionTitle,
}) async {
  Map<Permission, PermissionStatus> permissionStatus =
      Map<Permission, PermissionStatus>();
  for (var element in permissionElement) {
    permissionStatus.addAll({
      element: await element.status,
    });
  }
  if (permissionStatus.values.every((element) => element.isGranted)) {
    return "GRANTED";
  } else {
    return await showPermissionDialog(
      context: context,
      permissionStatus: permissionStatus,
      permissionTitle: permissionTitle,
    );
  }
}

/// ## get Permission Dialog Content
String getPermissionDialogContent(
  String permissionTitle,
  Map<Permission, PermissionStatus> permissionStatus,
) {
  String content = permissionTitle + ", allow WhatsApp access to ";
  String storageTitle = "Storage";
  String storageDescription = "device's photos, media, and files";
  String cameraTitle = "Camera";
  String cameraDescription = "camera";
  String contactTitle = "Contact";
  String contactDescription = "contacts";
  List<String> tempDescription = [];
  permissionStatus.forEach((key, value) {
    if (value != PermissionStatus.granted) {
      switch (key) {
        case Permission.storage:
          tempDescription.add("your " + storageDescription);
          break;
        case Permission.camera:
          tempDescription.add("your " + cameraDescription);
          break;
        case Permission.contacts:
          tempDescription.add("your " + contactDescription);
          break;
        default:
          break;
      }
    }
  });
  content = content +
      "${(tempDescription.isNotEmpty && tempDescription.length > 1) ? tempDescription.sublist(0, tempDescription.length - 1).join(", ") : ""}" +
      "${(tempDescription.isNotEmpty && tempDescription.length > 1) ? " add " : ""}" +
      tempDescription.last +
      ".";
  if (permissionStatus.values.contains(PermissionStatus.permanentlyDenied)) {
    content = content + " Tap Settings > Permissions, and turn ";
    List<String> tempTitle = [];
    permissionStatus.forEach((key, value) {
      if (value != PermissionStatus.granted) {
        switch (key) {
          case Permission.storage:
            tempTitle.add(storageTitle + " on");
            break;
          case Permission.camera:
            tempTitle.add(cameraTitle + " on");
            break;
          case Permission.contacts:
            tempTitle.add(contactTitle + " on");
            break;
          default:
            break;
        }
      }
    });
    content = content +
        "${(tempTitle.isNotEmpty && tempTitle.length > 1) ? tempTitle.sublist(0, tempTitle.length - 1).join(", ") : ""}" +
        "${(tempTitle.isNotEmpty && tempTitle.length > 1) ? " and " : ""}" +
        tempTitle.last +
        ".";
  }
  return content;
}
