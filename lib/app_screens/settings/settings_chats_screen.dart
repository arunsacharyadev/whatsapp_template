import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_services/theme_notifier.dart';
import '../../app_utils/hive_config.dart';
import '../../app_utils/size_config.dart';
import '../../app_utils/ui_components.dart';
import '../../app_utils/util_functions.dart';

class SettingsChatsScreen extends StatefulWidget {
  const SettingsChatsScreen({Key? key}) : super(key: key);

  @override
  _SettingsChatsScreenState createState() => _SettingsChatsScreenState();
}

class _SettingsChatsScreenState extends State<SettingsChatsScreen> {
  ValueNotifier<int>? _themeGroupValueNotifier;
  ValueNotifier<int>? _fontSizeGroupValueNotifier;
  ValueNotifier<bool>? _switch1Notifier;
  ValueNotifier<bool>? _switch2Notifier;
  final List<String> _themeList = <String>[
    'System default',
    'Light',
    'Dark',
  ];
  final List<String> _fontSizeList = <String>[
    'Small',
    'Medium',
    'Large',
  ];

  @override
  void initState() {
    super.initState();
    _themeGroupValueNotifier =
        ValueNotifier<int>(int.parse(HiveConfig.hiveReadData('ThemeMode')));
    _fontSizeGroupValueNotifier =
        ValueNotifier<int>(int.parse(HiveConfig.hiveReadData('FontSize')));
    _switch1Notifier = ValueNotifier<bool>(false);
    _switch2Notifier = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: SizeConfig.textScaleFactor * 25,
            visualDensity: VisualDensity.comfortable,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildHeading(context: context, title: 'Display'),
              BuildSettingsListTile(
                  leadingImage: 'assets/icons/brightness.svg',
                  context: context,
                  title: 'Theme',
                  subtitle: _themeList[
                      int.parse(HiveConfig.hiveReadData('ThemeMode'))],
                  callback: () async {
                    await showThemeDialog(
                      context: context,
                      groupValueNotifier: _themeGroupValueNotifier,
                    ).then((res) {
                      if (res != null && res.toString() == 'OK') {
                        HiveConfig.hiveCreateData('ThemeMode',
                            _themeGroupValueNotifier!.value.toString());
                        Provider.of<ThemeNotifier>(context, listen: false)
                            .setThemeMode(getThemeModeByIndex(
                                _themeGroupValueNotifier!.value));
                      } else {
                        _themeGroupValueNotifier!.value =
                            int.parse(HiveConfig.hiveReadData('ThemeMode'));
                      }
                    });
                  }),
              BuildSettingsListTile(
                context: context,
                leadingIcon: Icons.wallpaper,
                title: 'Wallpaper',
              ),
              Divider(thickness: 0.6),
              BuildHeading(context: context, title: 'Chat Settings'),
              BuildSettingsListTile(
                context: context,
                title: 'Enter is send',
                contentPadding: EdgeInsets.only(left: 70.0),
                subtitle: 'Enter key will send your message',
                trailing: BuildSwitch(
                    valueNotifier: _switch1Notifier,
                    callback: (value) {
                      _switch1Notifier!.value = value;
                    }),
              ),
              BuildSettingsListTile(
                context: context,
                title: 'Media visibility',
                contentPadding: EdgeInsets.only(left: 70.0),
                subtitle: "Show newly downloaded media in your phone's gallery",
                trailing: BuildSwitch(
                    valueNotifier: _switch2Notifier,
                    callback: (value) {
                      _switch2Notifier!.value = value;
                    }),
              ),
              ValueListenableBuilder(
                valueListenable: _fontSizeGroupValueNotifier!,
                builder: (context, dynamic value, _) {
                  return BuildSettingsListTile(
                      context: context,
                      title: 'Font Size',
                      contentPadding: EdgeInsets.only(left: 70.0),
                      subtitle: _fontSizeList[
                          int.parse(HiveConfig.hiveReadData('FontSize'))],
                      callback: () async {
                        await showFontSizeDialog(
                          context: context,
                          groupValueNotifier: _fontSizeGroupValueNotifier,
                          callback1: (val) {
                            _fontSizeGroupValueNotifier!.value = val;
                            Navigator.pop(context);
                          },
                          callback2: (val) {
                            _fontSizeGroupValueNotifier!.value = val;
                            Navigator.pop(context);
                          },
                          callback3: (val) {
                            _fontSizeGroupValueNotifier!.value = val;
                            Navigator.pop(context);
                          },
                        ).then((_) {
                          HiveConfig.hiveCreateData('FontSize',
                              '${_fontSizeGroupValueNotifier!.value}');
                        });
                      });
                },
              ),
              BuildSettingsListTile(
                context: context,
                title: 'App Language',
                contentPadding: EdgeInsets.only(left: 70.0),
                subtitle: "Phone's language (English)",
              ),
              BuildSettingsListTile(
                context: context,
                leadingIcon: Icons.backup,
                title: 'Chat backup',
              ),
              BuildSettingsListTile(
                context: context,
                leadingIcon: Icons.history,
                title: 'Chat history',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _themeGroupValueNotifier!.dispose();
    _fontSizeGroupValueNotifier!.dispose();
    _switch1Notifier!.dispose();
    _switch2Notifier!.dispose();
    super.dispose();
  }
}
