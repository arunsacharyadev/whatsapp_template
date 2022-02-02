import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'app_screens/home/home_screen.dart';
import 'app_screens/home/tabs/camera_tab.dart';
import 'app_services/theme_notifier.dart';
import 'app_utils/app_theme.dart';
import 'app_utils/hive_config.dart';
import 'app_utils/util_functions.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );

    await HiveConfig.hiveInit();
    await HiveConfig.hiveOpenBoxAsync('settings').then((_) {
      if (HiveConfig.hiveReadData('ThemeMode') == null) {
        HiveConfig.hiveCreateData('ThemeMode', '0');
      }
      if (HiveConfig.hiveReadData('FontSize') == null) {
        HiveConfig.hiveCreateData('FontSize', '1');
      }
    });
  } on CameraException catch (e) {
    logError(code: e.code, description: e.description);
  } on HiveError catch (e) {
    logError(description: e.message, stackTrace: e.stackTrace);
  }
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(
          getThemeModeByIndex(HiveConfig.hiveReadData('ThemeMode'))),
      child: WhatsAppTemplateApp(),
    ),
  );
}

class WhatsAppTemplateApp extends StatelessWidget {
  const WhatsAppTemplateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.getThemeMode(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeListResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.first;
          },
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('hi', ''),
            Locale('kn', ''),
            Locale('te', ''),
            Locale('ta', ''),
          ],
          home: HomeScreen(),
        );
      },
    );
  }
}
