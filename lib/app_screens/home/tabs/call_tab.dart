import 'package:flutter/material.dart';

import '../../../app_services/call_notifier.dart';
import '../../../app_utils/app_theme.dart';
import '../../../app_utils/ui_components.dart';

class CallTab extends StatefulWidget {
  const CallTab({Key? key}) : super(key: key);

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
                List<Map<String, dynamic>>? _callData = [];
                _callData = snapshot.data as List<Map<String, dynamic>>?;
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  key: PageStorageKey('callTabKey'),
                  shrinkWrap: true,
                  itemCount: _callData!.length,
                  itemBuilder: (context, index) {
                    return BuildCallListTile(
                      context: context,
                      index: index,
                      callData: _callData![index],
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
                return NoRecordsFound(message: 'No Call Records');
              }
            case ConnectionState.waiting:
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppTheme.tealGreenLight),
                  ),
                ),
              );
            default:
              return Container();
          }
        });
  }
}
