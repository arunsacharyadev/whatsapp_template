import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_template/app_screens/settings/settings_chats_screen.dart';
import 'package:whatsapp_template/app_utils/size_config.dart';
import 'package:whatsapp_template/app_utils/ui_components.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig()..init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  radius: SizeConfig.textScaleFactor * 40.0,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: SizeConfig.textScaleFactor * 40.0,
                  ),
                ),
                title: Text(
                  "arun",
                  style: TextStyle(
                    fontSize: SizeConfig.textScaleFactor * 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "Available",
                  style: TextStyle(
                    fontSize: SizeConfig.textScaleFactor * 18,
                  ),
                ),
                trailing: AspectRatio(
                  aspectRatio: SizeConfig.textScaleFactor * 0.5,
                  child: SvgPicture.asset(
                    'assets/icons/qr_code_scanner.svg',
                    color: Theme.of(context).accentIconTheme.color,
                  ),
                ),
              ),
              Divider(thickness: 0.6),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiComponents.buildSettingsListTile(
                      context: context,
                      leadingImage: 'assets/icons/encryption_key.svg',
                      title: "Account",
                      subtitle: "Privacy, security, change number",
                    ),
                    UiComponents.buildSettingsListTile(
                        context: context,
                        leadingIcon: Icons.chat,
                        title: "Chats",
                        subtitle: "Theme, wallpapers, chat history",
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsChatsScreen(),
                            ),
                          );
                        }),
                    UiComponents.buildSettingsListTile(
                      context: context,
                      leadingIcon: Icons.notifications,
                      title: "Notifications",
                      subtitle: "Messages, group & call tones",
                    ),
                    UiComponents.buildSettingsListTile(
                      context: context,
                      leadingIcon: Icons.data_usage,
                      title: "Data and storage usage",
                      subtitle: "Network usage, auto-download",
                    ),
                    UiComponents.buildSettingsListTile(
                      context: context,
                      leadingIcon: Icons.help_outline,
                      title: "Help",
                      subtitle: "FAQ, contact us, privacy policy",
                    ),
                    UiComponents.buildSettingsListTile(
                      context: context,
                      leadingIcon: Icons.group,
                      title: "Invite a friend",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
