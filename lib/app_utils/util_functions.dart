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

List<CameraDescription> cameras;

typedef VoidCallback = void Function();

class UtilFunctions {
  static logError({String code, String description, StackTrace stackTrace}) {
    debugPrint(
        "Exception\t ${(code != null) ? "Code: $code" : ""} ${(description != null) ? "\tMessage: $description" : ""} ${(stackTrace != null) ? "\tStackTrace: $stackTrace" : ""}");
  }

  static ThemeMode getThemeModeByIndex(index) {
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

  static TabAction getTabActionByIndex(index) {
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

  static double getRadiansFromDegree(double degree) {
    ///Deg*(pi/180) = Rad
    return degree * (math.pi / 180).toDouble();
  }
}
