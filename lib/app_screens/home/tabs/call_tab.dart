import 'package:flutter/material.dart';
import 'package:whatsapp_template/app_services/call_notifier.dart';
import 'package:whatsapp_template/app_utils/app_theme.dart';
import 'package:whatsapp_template/app_utils/ui_components.dart';

class CallTab extends StatefulWidget {
  @override
  _CallTabState createState() => _CallTabState();
}

class _CallTabState extends State<CallTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CallNotifier.getCallData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                List<Map<String, dynamic>> _callData = [];
                _callData = snapshot.data;
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  key: PageStorageKey('callTabKey'),
                  shrinkWrap: true,
                  itemCount: _callData.length,
                  itemBuilder: (context, index) {
                    return BuildCallListTile(
                      context: context,
                      index: index,
                      callData: _callData[index],
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
                return NoRecordsFound("No Call Records");
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
