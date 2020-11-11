import 'package:app_settings/app_settings.dart';
import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_template/app_screens/home/new_chat.dart';
import 'package:whatsapp_template/app_screens/home/tabs/call_tab.dart';
import 'package:whatsapp_template/app_screens/home/tabs/camera_tab.dart';
import 'package:whatsapp_template/app_screens/home/tabs/chat_tab.dart';
import 'package:whatsapp_template/app_screens/home/tabs/status_tab.dart';
import 'package:whatsapp_template/app_screens/settings/settings_screen.dart';
import 'package:whatsapp_template/app_utils/app_theme.dart';
import 'package:whatsapp_template/app_utils/size_config.dart';

import 'package:whatsapp_template/app_utils/ui_components.dart';
import 'package:whatsapp_template/app_utils/util_functions.dart';

TabController tabController;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    ///Initializing Controller
    tabController = TabController(
      length: _tabLength,
      vsync: this,
      initialIndex: 1,
    );
    _tabIndexNotifier = ValueNotifier<int>(tabController.index);
    _tabActionNotifier =
        ValueNotifier<TabAction>(getTabActionByIndex(tabController.index));
    tabController.addListener(() {
      _tabIndexNotifier.value = tabController.index;
      _tabActionNotifier.value = getTabActionByIndex(tabController.index);
    });
    requestPermission();
  }

  @override
  void dispose() {
    tabController.removeListener(() {});
    tabController.dispose();
    _tabIndexNotifier.dispose();
    super.dispose();
  }

  int _tabLength = 4;
  ValueNotifier<int> _tabIndexNotifier;
  ValueNotifier<TabAction> _tabActionNotifier;

  requestPermission() async {
    await [
      Permission.contacts,
      Permission.camera,
      Permission.storage,
      Permission.microphone,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: Theme.of(context).appBarTheme.color,
      ),
    );
    SizeConfig()..init(context);
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool value) {
            return [
              SliverAppBar(
                title: Text("WhatsApp"),
                pinned: true,
                floating: true,
                snap: true,
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
                  controller: tabController,
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
            controller: tabController,
            children: [
              CameraTab(),
              ChatTab(),
              StatusTab(),
              CallTab(),
            ],
          ),
        ),
        floatingActionButton: Container(
          width: 60.0,
          height: 60.0,
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: [
              ValueListenableBuilder(
                valueListenable: _tabActionNotifier,
                builder: (context, tabAction, _) {
                  if (TabAction.chat == tabAction &&
                      tabController.indexIsChanging &&
                      (getTabActionByIndex(tabController.previousIndex) ==
                              TabAction.status ||
                          getTabActionByIndex(tabController.previousIndex) ==
                              TabAction.call)) {
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
                          child: (getTabActionByIndex(
                                      tabController.previousIndex) ==
                                  TabAction.status)
                              ? _getEditStatusButton
                              : _getGroupVideoCallingButton,
                        );
                      },
                    );
                  } else if (TabAction.status == tabAction) {
                    return TweenAnimationBuilder(
                      duration:
                          (getTabActionByIndex(tabController.previousIndex) ==
                                  TabAction.call)
                              ? Duration(milliseconds: 0)
                              : Duration(milliseconds: 100),
                      tween: Tween<double>(
                        begin: 0,
                        end: 70,
                      ),
                      curve: Curves.easeInExpo,
                      builder: (context, value, _) {
                        if (getTabActionByIndex(tabController.previousIndex) ==
                            TabAction.call) {
                          return Transform.translate(
                            offset: Offset.fromDirection(
                                getRadiansFromDegree(180.0 + 90.0), 70),
                            child: _getEditStatusButton,
                          );
                        } else {
                          return Transform.translate(
                            offset: Offset.fromDirection(
                                getRadiansFromDegree(180.0 + 90.0), value),
                            child: _getEditStatusButton,
                          );
                        }
                      },
                    );
                  } else if (TabAction.call == tabAction) {
                    return TweenAnimationBuilder(
                      duration:
                          (getTabActionByIndex(tabController.previousIndex) ==
                                  TabAction.status)
                              ? Duration(milliseconds: 0)
                              : Duration(milliseconds: 100),
                      tween: Tween<double>(
                        begin: 0,
                        end: 70,
                      ),
                      curve: Curves.easeInExpo,
                      builder: (context, value, _) {
                        if (getTabActionByIndex(tabController.previousIndex) ==
                            TabAction.status) {
                          return Transform.translate(
                            offset: Offset.fromDirection(
                                getRadiansFromDegree(180.0 + 90.0), 70),
                            child: _getGroupVideoCallingButton,
                          );
                        } else {
                          return Transform.translate(
                            offset: Offset.fromDirection(
                                getRadiansFromDegree(180.0 + 90.0), value),
                            child: _getGroupVideoCallingButton,
                          );
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              buildFloatingActionButton(_tabActionNotifier),
            ],
          ),
        ),
      ),
    );
  }

  get _getEditStatusButton {
    return BuildCircularButton(
      width: 45.0,
      height: 45.0,
      backgroundColor: (Theme.of(context).brightness == Brightness.light)
          ? AppTheme.chatBackground
          : Theme.of(context).appBarTheme.color,
      icon: Icon(Icons.edit),
      iconColor: (Theme.of(context).brightness == Brightness.light)
          ? Colors.black.withOpacity(0.6)
          : AppTheme.chatBackground,
      onPressed: () {},
    );
  }

  get _getGroupVideoCallingButton {
    return BuildCircularButton(
      width: 45.0,
      height: 45.0,
      backgroundColor: (Theme.of(context).brightness == Brightness.light)
          ? AppTheme.chatBackground
          : Theme.of(context).appBarTheme.color,
      icon: Icon(Icons.video_call),
      iconColor: (Theme.of(context).brightness == Brightness.light)
          ? Colors.black.withOpacity(0.6)
          : AppTheme.chatBackground,
      onPressed: () {},
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
                onPressed: () async {
                  await checkPermission(
                      context: context,
                      permissionElement: [
                        Permission.contacts,
                      ],
                      permissionTitle:
                      "To help you message friends and family on WhatsApp")
                      .then((res) async {
                    switch (res) {
                      case "GRANTED":
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewChat(),
                          ),
                        );
                        break;
                      case "CONTINUE":
                        await [Permission.contacts].request().then((value) {
                          if (value.values
                              .toList()
                              .every((element) => element.isGranted)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewChat(),
                              ),
                            );
                          }
                        });
                        break;
                      case "SETTINGS":
                        await AppSettings.openAppSettings().then((_) async {
                          if (await Permission.contacts.isGranted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewChat(),
                              ),
                            );
                          }
                        });
                        break;
                      default:
                        break;
                    }
                  });
                },
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
        buildPopupMenuItem(
          title: "New group",
        ),
        buildPopupMenuItem(
          title: "New broadcast",
        ),
        buildPopupMenuItem(
          title: "WhatsApp Web",
        ),
        buildPopupMenuItem(
          title: "Starred Messages",
        ),
        buildPopupMenuItem(
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
