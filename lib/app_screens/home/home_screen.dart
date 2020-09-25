import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_template/app_screens/home/tabs/call_tab.dart';
import 'package:whatsapp_template/app_screens/home/tabs/camera_tab.dart';
import 'package:whatsapp_template/app_screens/home/tabs/chat_tab.dart';
import 'package:whatsapp_template/app_screens/home/tabs/status_tab.dart';
import 'package:whatsapp_template/app_screens/settings/settings_screen.dart';
import 'package:whatsapp_template/app_utils/size_config.dart';
import 'package:whatsapp_template/app_utils/color_config.dart';

import 'package:whatsapp_template/app_utils/ui_components.dart';
import 'package:whatsapp_template/app_utils/util_functions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    ///Initializing Controller
    _tabController = TabController(
      length: _tabLength,
      vsync: this,
      initialIndex: 1,
    );
    _tabIndexNotifier = ValueNotifier<int>(_tabController.index);
    _fabActionNotifier =
        ValueNotifier<TabAction>(getTabActionByIndex(_tabController.index));
    _tabController.addListener(() {
      _tabIndexNotifier.value = _tabController.index;
      _fabActionNotifier.value = getTabActionByIndex(_tabController.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    _tabIndexNotifier.dispose();
    super.dispose();
  }

  int _tabLength = 4;
  ValueNotifier<int> _tabIndexNotifier;
  ValueNotifier<TabAction> _fabActionNotifier;

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.color,
      ),
    );
    SizeConfig()..init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool value) {
                return [
                  SliverAppBar(
                    title: Text("WhatsApp"),
                    pinned: true,
                    floating: true,
                    snap: true,
                    forceElevated: value,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.search),
                        iconSize: SizeConfig.textScaleFactor * 25,
                        visualDensity: VisualDensity.comfortable,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        iconSize: SizeConfig.textScaleFactor * 25,
                        visualDensity: VisualDensity.comfortable,
                        onPressed: () async {
                          await _showPopUpMenu(context: context);
                        },
                      ),
                    ],
                    bottom: TabBar(
                      isScrollable:
                          SizeConfig.screenOrientation == Orientation.portrait
                              ? true
                              : false,
                      controller: _tabController,
                      labelColor: Theme.of(context).indicatorColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (tabIndex) {},
                      tabs: <Widget>[
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: SizeConfig.textScaleFactor * 25,
                              ),
                            ],
                          ),
                        ),
                        _buildTab(
                          tabIndexNotifier: _tabIndexNotifier,
                          title: "chats".toUpperCase(),
                          currentTabIndex: 1,
                          notificationCount: 1,
                        ),
                        _buildTab(
                          tabIndexNotifier: _tabIndexNotifier,
                          title: "status".toUpperCase(),
                          currentTabIndex: 2,
                          notificationCount: 3,
                        ),
                        _buildTab(
                          tabIndexNotifier: _tabIndexNotifier,
                          title: "calls".toUpperCase(),
                          currentTabIndex: 3,
                          notificationCount: 4,
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  CameraTab(),
                  ChatTab(),
                  StatusTab(),
                  CallTab(),
                ],
              ),
            ),
            Positioned(
              right: 20.0,
              bottom: 20.0,
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _fabActionNotifier,
                    builder: (context, fabAction, _) {
                      if (_tabController.index !=
                              _tabController.previousIndex &&
                          (getTabActionByIndex(_tabController.previousIndex) ==
                                  fabAction ||
                              getTabActionByIndex(
                                      _tabController.previousIndex) ==
                                  fabAction)) {
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 100),
                          tween: Tween<double>(
                            begin: 70,
                            end: 0,
                          ),
                          curve: Curves.easeInExpo,
                          builder: (context, value, _) {
                            return Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(180.0 + 90.0), value),
                              child: BuildCircularButton(
                                width: 50.0,
                                height: 50.0,
                                backgroundColor: 'ece5dd'.toHexColor(),
                                icon: Icon(Icons.edit),
                                iconColor: Colors.black.withOpacity(0.6),
                                onPressed: () {},
                              ),
                            );
                          },
                        );
                      }
                      if (TabAction.status == fabAction) {
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 100),
                          tween: Tween<double>(
                            begin: 0,
                            end: 70,
                          ),
                          curve: Curves.easeInExpo,
                          builder: (context, value, _) {
                            return Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(180.0 + 90.0), value),
                              child: BuildCircularButton(
                                width: 50.0,
                                height: 50.0,
                                backgroundColor: 'ece5dd'.toHexColor(),
                                icon: Icon(Icons.edit),
                                iconColor: Colors.black.withOpacity(0.6),
                                onPressed: () {},
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  buildFloatingActionButton(_fabActionNotifier),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFloatingActionButton(ValueNotifier<TabAction> valueListenable) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: ValueListenableBuilder(
        valueListenable: valueListenable,
        builder: (BuildContext context, TabAction tabAction, _) {
          switch (tabAction) {
            case TabAction.chat:
              return BuildCircularButton(
                backgroundColor:
                Theme
                    .of(context)
                    .floatingActionButtonTheme
                    .backgroundColor,
                icon: Icon(Icons.chat),
                onPressed: () {},
              );
              break;
            case TabAction.status:
              return BuildCircularButton(
                backgroundColor:
                Theme
                    .of(context)
                    .floatingActionButtonTheme
                    .backgroundColor,
                icon: Icon(Icons.camera_alt),
                onPressed: () {},
              );
              break;
            case TabAction.call:
              return BuildCircularButton(
                backgroundColor:
                Theme
                    .of(context)
                    .floatingActionButtonTheme
                    .backgroundColor,
                icon: Icon(Icons.add_call),
                onPressed: () {},
              );
              break;
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }

  Future<dynamic> _showPopUpMenu({@required BuildContext context}) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(double.infinity, 40, 0, 0),
      items: [
        _buildPopupMenuItem(
          title: "New group",
        ),
        _buildPopupMenuItem(
          title: "New broadcast",
        ),
        _buildPopupMenuItem(
          title: "WhatsApp Web",
        ),
        _buildPopupMenuItem(
          title: "Starred Messages",
        ),
        _buildPopupMenuItem(
          title: "Settings",
          callback: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
          },
        ),
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem({
    @required String title,
    void callback(),
  }) {
    return PopupMenuItem(
      child: ListTile(
        title: Text(title.toString()),
        visualDensity: VisualDensity.compact,
        onTap: callback,
      ),
    );
  }

  Tab _buildTab({
    @required ValueNotifier<int> tabIndexNotifier,
    @required String title,
    @required int currentTabIndex,
    int notificationCount: 0,
  }) {
    return Tab(
      child: ValueListenableBuilder(
        valueListenable: tabIndexNotifier,
        builder: (context, tabIndex, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Text(title.toString())),
              if (notificationCount > 0) SizedBox(width: 5.0),
              if (currentTabIndex == 2 && (tabIndex == currentTabIndex))
                Badge(
                  animationDuration: Duration(
                    milliseconds: 200,
                  ),
                  animationType: BadgeAnimationType.fade,
                  badgeColor: (tabIndex == currentTabIndex)
                      ? Theme.of(context).indicatorColor
                      : Colors.grey,
                ),
              if (currentTabIndex == 2 && ((tabIndex != currentTabIndex)))
                Badge(
                  animationDuration: Duration(
                    milliseconds: 200,
                  ),
                  animationType: BadgeAnimationType.fade,
                  badgeColor: (tabIndex == currentTabIndex)
                      ? Theme.of(context).indicatorColor
                      : Colors.grey,
                ),
              if (currentTabIndex != 2)
                Badge(
                  animationDuration: Duration(
                    milliseconds: 200,
                  ),
                  animationType: BadgeAnimationType.fade,
                  showBadge: notificationCount > 0 ? true : false,
                  badgeContent: Text(
                    notificationCount.toString(),
                    style: TextStyle(
                      color: Theme.of(context).appBarTheme.color,
                    ),
                  ),
                  badgeColor: (tabIndex == currentTabIndex)
                      ? Theme.of(context).indicatorColor
                      : Colors.grey,
                ),
            ],
          );
        },
      ),
    );
  }
}
