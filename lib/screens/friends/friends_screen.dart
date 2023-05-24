import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:todoit/models/models.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<Friend> friends = [
    Friend(name: "dummy", userId: '', phone: "010-1234-5678")
  ];
  List<Contact> contacts = [];

  Future<String> roadContacts() async {
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      contacts = await FlutterContacts.getContacts();
    }
    return 'Call Data';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: roadContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 35, right: 35, top: 30, bottom: 10),
                        child: Text(
                          "친구 목록",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        )),
                  ),
                  Expanded(
                    flex: 17,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 10, bottom: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(contacts[index].displayName),
                              trailing: TextButton(
                                child: Text("추가"),
                                onPressed: () {},
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ));
          } else {
            return Text("연락처 목록을 불러오는 데에 실패했습니다.");
          }
        });
  }
}
