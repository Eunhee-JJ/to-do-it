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

  Future<void> roadContacts() async {
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      contacts = await FlutterContacts.getContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.only(left: 35, right: 35, top: 30, bottom: 30),
              child: Text(
                "친구 목록",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              )),
          Container(
            padding: EdgeInsets.only(left: 35, right: 35, top: 30, bottom: 30),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  print(contacts.length);
                  return ListTile(
                    title: Text(contacts[index].displayName),
                    trailing: TextButton(
                      child: Text("추가"),
                      onPressed: () {},
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
