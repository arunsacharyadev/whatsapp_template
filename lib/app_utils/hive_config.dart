import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveConfig {
  static Future hiveInit() async {
    var dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
  }

  static Future hiveOpenBoxAsync(String name) async {
    await Hive.openBox(name);
  }

  static hiveOpenBox(String name) {
    Hive.openBox(name);
  }

  static bool isBoxOpen(String name) {
    debugPrint("isBoxOpen:\t" + Hive.isBoxOpen(name).toString());
    return Hive.isBoxOpen(name);
  }

  static Future<bool> isBoxExists(String name) async {
    debugPrint("isBoxExists:\t" + (await Hive.boxExists(name)).toString());
    return await Hive.boxExists(name);
  }

  static hiveCreateData(String key, String value, {String name: 'settings'}) {
    Hive.box(name).put(key, value);
  }

  static hiveReadData(String key, {String name: 'settings'}) {
    return Hive.box(name).get(key);
  }

  static hiveReadAllData({String name: 'settings'}) {
    return Hive.box(name).toMap();
  }
}
