import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/friend_provider.dart';
import 'package:todoit/providers/user_provider.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<StatefulWidget> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact> contacts = [];
  List<String> phoneNumbers = [];
  List<Friend> joinedUsers = [];
  int j = 0;

  Future<String> loadContacts() async {
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      contacts = await FlutterContacts.getContacts(withProperties: true);
      //await isJoined();
    }
    return 'Call Data';
  }

  Future<void> isJoined() async {
    await loadContacts();
    //print("contacts:" + contacts.toString());
    await pickPhone(contacts);
    var dio = Dio();
    //print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response =
          await dio.request('http://43.200.184.84:8080/api/friend/join',
              options: Options(
                method: 'POST',
                headers: {
                  "Authorization": context.read<UserProvider>().accessToken
                },
              ),
              data: phoneNumbers);
      print("isJoined:" + response.toString());
      context.read<FriendProvider>().joinedList =
          ((response.data["join_check"]).map<Friend>((json) {
        return Friend(
          name: json["nickname"],
          userId: json["userId"].toString(),
          phone: json["phone"],
        );
      }).toList());
      joinedUsers = context.read<FriendProvider>().joinedList;
      print("joinedUsers len: ${joinedUsers.length}");
      // for (int i = 0; i < _todoList.length; i++) {
      //   print(_todoList[i].task);
      // }
      //context.read<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> requestFriend(String friendId) async {
    var dio = Dio();
    //print("AT:" + context.read<UserProvider>().accessToken);
    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/friend?friendId=' + friendId,
        options: Options(
          method: 'POST',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print("requestFriend:" + response.toString());
      // for (int i = 0; i < _todoList.length; i++) {
      //   print(_todoList[i].task);
      // }
      //context.read<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> pickPhone(List<Contact> _contacts) async {
    phoneNumbers.clear();
    for (int i = 0; i < _contacts.length; i++) {
      if (_contacts[i].phones.length > 0)
        phoneNumbers.add(
            _contacts[i].phones[0].number.replaceAll(new RegExp(r'[^\w]'), ''));
    }
    //print("pickPhone:" + phoneNumbers.toString());
  }

  Widget setTextButton(int idx, String phone) {
    //print("joinedUser len: ${joinedUsers.length}");
    for (int i = 0; i < joinedUsers.length; i++) {
      if (phone == joinedUsers[i].phone) {
        print(joinedUsers[i].name +
            contacts[idx].phones[0].number +
            joinedUsers[i].phone +
            phone);
        return TextButton(
            child: Text("추가"),
            onPressed: () {
              requestFriend(joinedUsers[i].userId);
            });
      }
    }
    return TextButton(child: Text("초대"), onPressed: () {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isJoined(),
        builder: (context, snapshot) {
          //if (snapshot.hasData) {
          return Container(
            // 친구가 아닌 연락처 목록
            padding: EdgeInsets.only(left: 20, right: 10, bottom: 10),
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  if (contacts[index].phones.length > 0) {
                    return ListTile(
                      title: Text(contacts[index].displayName),
                      trailing: setTextButton(
                          index,
                          contacts[index]
                              .phones[0]
                              .number
                              .replaceAll(new RegExp(r'[^\w]'), '')),
                    );
                  } else {
                    return ListTile(
                      title: Text(contacts[index].displayName),
                      trailing: setTextButton(
                          index,
                          phoneNumbers[index]
                              .replaceAll(new RegExp(r'[^\w]'), '')),
                    );
                  }
                }),
          );
        }
        // else {
        //   return Text("연락처 목록을 불러오는 데에 실패했습니다.");
        // }
        //}
        );
  }
}
