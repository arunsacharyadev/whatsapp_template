import 'package:collection/collection.dart' show IterableExtension;
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../app_utils/app_theme.dart';
import '../../app_utils/size_config.dart';
import '../../app_utils/ui_components.dart';
import '../../app_utils/util_functions.dart';

class NewChat extends StatefulWidget {
  const NewChat({Key? key}) : super(key: key);

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  Future _getContacts() async {
    List<Contact> contacts = (await ContactsService.getContacts()).toList();
    _contactCount.value = contacts.length;
    contactsData = contacts;
    return contacts;
  }

  List<Contact> contactsData = [];
  late ValueNotifier<int> _contactCount;

  @override
  void initState() {
    super.initState();
    _contactCount = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ValueListenableBuilder(
              valueListenable: _contactCount,
              builder: (context, dynamic count, _) {
                return Container(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                      color: Colors.white,
                      iconSize: SizeConfig.textScaleFactor * 26,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      'Select contact',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: (count > 0)
                        ? Text(
                            '$count contacts',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )
                        : null,
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.white,
                          iconSize: SizeConfig.textScaleFactor * 26,
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: SearchContact(
                                contactList: contactsData,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          color: Colors.white,
                          iconSize: SizeConfig.textScaleFactor * 26,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: _getContacts(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(AppTheme.tealGreenLight),
                          ),
                        ),
                      );

                    case ConnectionState.done:
                      List<Contact>? contactList = [];
                      if (snapshot.hasData) {
                        contactList = snapshot.data as List<Contact>?;
                      }
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: SizeConfig.textScaleFactor * 20.0,
                              backgroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                              child: Icon(
                                Icons.group_rounded,
                                size: SizeConfig.textScaleFactor * 25,
                                color: Colors.white,
                              ),
                            ),
                            title: Text('New group'),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: SizeConfig.textScaleFactor * 20.0,
                              backgroundColor: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                              child: Icon(
                                Icons.person_add_rounded,
                                size: SizeConfig.textScaleFactor * 25,
                                color: Colors.white,
                              ),
                            ),
                            title: Text('New Contact'),
                            trailing: Icon(
                              Icons.qr_code,
                              size: SizeConfig.textScaleFactor * 25,
                              color: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .backgroundColor,
                            ),
                          ),
                          if (contactList!.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: contactList.length,
                              itemBuilder: (context, index) {
                                Contact data = contactList![index];
                                return ListTile(
                                  leading: (data.avatar != null &&
                                          data.avatar!.isNotEmpty)
                                      ? CircleAvatar(
                                          radius:
                                              SizeConfig.textScaleFactor * 20.0,
                                          backgroundImage:
                                              MemoryImage(data.avatar!),
                                        )
                                      : CircleAvatar(
                                          radius:
                                              SizeConfig.textScaleFactor * 20.0,
                                          backgroundColor: Colors.grey,
                                          child: Text(
                                            data.initials().toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  SizeConfig.textScaleFactor *
                                                      25,
                                            ),
                                          ),
                                        ),
                                  title: Text(data.displayName!),
                                  subtitle: Text(
                                    'Hey there! I am using WhatsApp',
                                  ),
                                );
                              },
                            ),
                          if (contactList.isEmpty)
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 70.0),
                              title: Text('No WhatsApp contacts'),
                            ),
                          ListTile(
                            leading: Icon(
                              Icons.share,
                              size: SizeConfig.textScaleFactor * 25,
                            ),
                            title: Text('Invite friends'),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.help,
                              size: SizeConfig.textScaleFactor * 25,
                            ),
                            title: Text('Contacts help'),
                          ),
                        ],
                      );

                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SearchContact extends SearchDelegate {
  final List<Contact> contactList;

  SearchContact({
    String hintText = 'Search...',
    required this.contactList,
  }) : super(
          searchFieldLabel: hintText,
        );

  get _getFilteredContacts {
    List<Contact> filteredContacts = [];
    filteredContacts.addAll(contactList);
    if (query.isNotEmpty) {
      filteredContacts.retainWhere((element) {
        var phone = element.phones!.firstWhereOrNull((element) {
          return flattenPhoneNumber(element.value!).contains(query);
        });
        if (query.isNotEmpty) {
          if (element.displayName!
              .toLowerCase()
              .contains(query.toLowerCase())) {
            return true;
          } else if (phone != null) {
            return true;
          }
        }
        return false;
      });
    }
    return filteredContacts;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.close),
          color: Theme.of(context).brightness == Brightness.light
              ? AppTheme.tealGreenLight
              : AppTheme.chatBackground,
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Theme.of(context).brightness == Brightness.light
          ? AppTheme.tealGreenLight
          : AppTheme.chatBackground,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Contact> resultList = _getFilteredContacts;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: resultList.length,
      itemBuilder: (context, index) {
        Contact data = resultList[index];
        return ListTile(
          leading: (data.avatar != null && data.avatar!.isNotEmpty)
              ? CircleAvatar(
                  radius: SizeConfig.textScaleFactor * 24.0,
                  backgroundImage: MemoryImage(data.avatar!),
                )
              : CircleAvatar(
                  radius: SizeConfig.textScaleFactor * 24.0,
                  backgroundColor: Colors.grey,
                  child: Text(
                    data.initials().toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textScaleFactor * 25,
                    ),
                  ),
                ),
          title: Text(data.displayName!),
          subtitle: Text(
            'Hey there! I am using WhatsApp',
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> suggestionList = [];
    suggestionList = (query.isEmpty) ? contactList : _getFilteredContacts;
    if (suggestionList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          Contact data = suggestionList[index];
          return ListTile(
            leading: (data.avatar != null && data.avatar!.isNotEmpty)
                ? CircleAvatar(
                    radius: SizeConfig.textScaleFactor * 20.0,
                    backgroundImage: MemoryImage(data.avatar!),
                  )
                : CircleAvatar(
                    radius: SizeConfig.textScaleFactor * 20.0,
                    backgroundColor: Colors.grey,
                    child: Text(
                      data.initials().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textScaleFactor * 25,
                      ),
                    ),
                  ),
            title: RichText(
              text: TextSpan(
                children: highlightOccurrences(data.displayName, query),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            subtitle: Text(
              'Hey there! I am using WhatsApp',
            ),
          );
        },
      );
    } else {
      return ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 70.0),
            title: Text("No results found for '$query'"),
          ),
          ListTile(
            leading: Icon(
              Icons.share,
            ),
            title: Text('Invite friends'),
          ),
          ListTile(
            leading: Icon(
              Icons.help,
            ),
            title: Text('Contacts help'),
          ),
        ],
      );
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      primaryColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.grey.withOpacity(0.5),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.grey,
            ),
      ),
    );
  }
}
