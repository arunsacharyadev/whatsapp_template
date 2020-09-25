import 'package:flutter/material.dart';
import 'package:whatsapp_template/app_services/chat_notifier.dart';
import 'package:whatsapp_template/app_utils/app_theme.dart';
import 'package:whatsapp_template/app_utils/ui_components.dart';

class ChatTab extends StatefulWidget {
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ChatNotifier.getChatData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                List<Map<String, dynamic>> _chatData = [];
                _chatData = snapshot.data;
                return ListView.separated(
                  key: PageStorageKey('chatTabKey'),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _chatData.length,
                  itemBuilder: (context, index) {
                    return BuildChatListTile(
                      context: context,
                      index: index,
                      chatData: _chatData[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 76.0,
                      endIndent: 10.0,
                      thickness: 0.8,
                      height: 5.0,
                    );
                  },
                );
              } else {
                return NoRecordsFound("No Chat Records");
              }
              break;
            case ConnectionState.waiting:
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppTheme.tealGreenLight),
                  ),
                ),
              );
              break;
            default:
              return Container();
              break;
          }
        });
  }
}
