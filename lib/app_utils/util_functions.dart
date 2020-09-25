import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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

List<CameraDescription> cameras;

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
