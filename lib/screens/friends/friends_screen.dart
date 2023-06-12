import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/friend_provider.dart';
import 'package:todoit/providers/user_provider.dart';
import 'package:todoit/screens/friends/accept_list.dart';
import 'package:todoit/screens/friends/contacts_list.dart';
import 'package:todoit/screens/friends/friends_list.dart';
import 'package:todoit/screens/friends/pending_list.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      //if (snapshot.hasData) {
      return Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  padding:
                      EdgeInsets.only(left: 35, right: 35, top: 30, bottom: 10),
                  child: Text(
                    "친구 목록",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  )),
            ),
            Expanded(
                flex: 8,
                child: ListView(children: [
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: new Text("친구 목록"),
                    children: [
                      FriendsList(),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text("받은 요청 목록"),
                    children: [
                      AcceptList(),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text("보낸 요청 목록"),
                    children: [
                      PendingList(),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text("친구 추가"),
                    children: [
                      ContactsList(),
                    ],
                  ),
                ]))
          ],
        ),
      ));
    }
        // else {
        //   return Text("연락처 목록을 불러오는 데에 실패했습니다.");
        // }
        //}
        );
  }
}
