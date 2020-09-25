import 'package:flutter/material.dart';
import 'package:whatsapp_template/app_services/status_notifier.dart';
import 'package:whatsapp_template/app_utils/app_theme.dart';
import 'package:whatsapp_template/app_utils/size_config.dart';
import 'package:whatsapp_template/app_utils/ui_components.dart';

class StatusTab extends StatefulWidget {
  @override
  _StatusTabState createState() => _StatusTabState();
}

class _StatusTabState extends State<StatusTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StatusNotifier.getStatusData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                Map<String, dynamic> _statusData = {};
                Map<String, dynamic> _myStatus = {};
                List<Map<String, dynamic>> _recentUpdates = [];
                List<Map<String, dynamic>> _viewedUpdates = [];
                _statusData = snapshot.data;
                _myStatus = _statusData['my_status'];
                _recentUpdates = _statusData['recent_updates'];
                _viewedUpdates = _statusData['viewed_updates'];

                return ListView(
                  key: PageStorageKey("statusTabKey"),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      leading: AbsorbPointer(
                        absorbing: true,
                        ignoringSemantics: false,
                        child: Stack(
                          alignment: Alignment.center,
                          overflow: Overflow.visible,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: (_myStatus['statusPic']
                                      .toString()
                                      .isNotEmpty)
                                  ? AssetImage('${_myStatus['statusPic']}')
                                  : AssetImage('assets/profiles/person_dp.png'),
                              radius: SizeConfig.textScaleFactor * 28.0,
                            ),
                            Positioned(
                              bottom: -5.0,
                              right: -5.0,
                              child: BuildCircularButton(
                                backgroundColor: Theme.of(context)
                                    .floatingActionButtonTheme
                                    .backgroundColor,
                                height: 25.0,
                                width: 25.0,
                                icon: Icon(
                                  Icons.add,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text("My Status"),
                      ),
                      subtitle: Text(
                          (_myStatus['StatusTime'].toString().isNotEmpty)
                              ? _myStatus['StatusTime'].toString()
                              : "Tap to add status update"),
                      onTap: () {},
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      width: double.infinity,
                      color: (Theme.of(context).brightness == Brightness.light)
                          ? AppTheme.chatBackground.withOpacity(0.45)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                        child: Text(
                          "Recent updates",
                          style: TextStyle(
                            color: (Theme.of(context).brightness ==
                                    Brightness.light)
                                ? Colors.grey.withOpacity(0.8)
                                : Colors.white60,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textScaleFactor * 16.0,
                          ),
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: _recentUpdates.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: (_recentUpdates[index]
                                        ['contactStatusPic']
                                    .toString()
                                    .isNotEmpty)
                                ? AssetImage(
                                    '${_recentUpdates[index]['contactStatusPic']}')
                                : AssetImage('assets/profiles/person_dp.png'),
                            radius: SizeConfig.textScaleFactor * 28.0,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(_recentUpdates[index]['contactName']
                                .toString()),
                          ),
                          subtitle: Text(_recentUpdates[index]['StatusTime']),
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
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      width: double.infinity,
                      color: (Theme.of(context).brightness == Brightness.light)
                          ? AppTheme.chatBackground.withOpacity(0.45)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                        child: Text(
                          "Viewed updates",
                          style: TextStyle(
                            color: (Theme.of(context).brightness ==
                                    Brightness.light)
                                ? Colors.grey.withOpacity(0.8)
                                : Colors.white60,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textScaleFactor * 16.0,
                          ),
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: _viewedUpdates.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: (_viewedUpdates[index]
                                        ['contactStatusPic']
                                    .toString()
                                    .isNotEmpty)
                                ? AssetImage(
                                    '${_viewedUpdates[index]['contactStatusPic']}')
                                : AssetImage('assets/profiles/person_dp.png'),
                            radius: SizeConfig.textScaleFactor * 28.0,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(_viewedUpdates[index]['contactName']
                                .toString()),
                          ),
                          subtitle: Text(_viewedUpdates[index]['StatusTime']),
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
                    ),
                  ],
                );
              } else {
                return NoRecordsFound("No Status Records");
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
