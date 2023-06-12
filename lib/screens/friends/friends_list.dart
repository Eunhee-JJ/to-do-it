import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/friend_provider.dart';
import 'package:todoit/providers/user_provider.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<StatefulWidget> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<Friend> friends = [];

  Future<void> getFriends() async {
    var dio = Dio();
    //print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/friend',
        options: Options(
          method: 'GET',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print("FriendsList:" + response.toString());
      context.read<FriendProvider>().friendsList =
          ((response.data["friend_list"]).map<Friend>((json) {
        return Friend(
          name: json["nickname"],
          userId: json["userId"],
          phone: json["phone"],
        );
      }).toList());
      friends = context.read<FriendProvider>().friendsList;
      // for (int i = 0; i < _todoList.length; i++) {
      //   print(_todoList[i].task);
      // }
      //context.read<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteFriends(String id) async {
    var dio = Dio();
    //print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/friend',
        options: Options(
          method: 'DELETE',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print("deleteFriends:" + response.toString());
      context.read<FriendProvider>().removeFriend(id);
      // for (int i = 0; i < _todoList.length; i++) {
      //   print(_todoList[i].task);
      // }
      //context.read<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFriends(),
        builder: (context, snapshot) {
          if (friends.length > 0) {
            return Container(
              // 친구 목록
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(friends[index].name),
                      trailing: TextButton(
                        child: Text("삭제"),
                        onPressed: () {
                          AlertDialog(
                              //title: Text("Add Todolist"),
                              content: Text("삭제하시겠습니까?"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        deleteFriends(friends[index].userId);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("확인")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("취소")),
                              ]);
                        },
                      ),
                    );
                  }),
            );
          } else {
            return Text("친구 목록이 없습니다.");
          }
        });
  }
}
