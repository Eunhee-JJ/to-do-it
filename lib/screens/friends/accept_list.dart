import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/friend_provider.dart';
import 'package:todoit/providers/user_provider.dart';

class AcceptList extends StatefulWidget {
  const AcceptList({super.key});

  @override
  State<StatefulWidget> createState() => _AcceptListState();
}

class _AcceptListState extends State<AcceptList> {
  List<Friend> friends_accept = [];

  Future<void> getAccept() async {
    var dio = Dio();
    //print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/friend/accept',
        options: Options(
          method: 'GET',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print("acceptList:" + response.toString());
      context.read<FriendProvider>().watingList =
          ((response.data["friend_list"]).map<Friend>((json) {
        return Friend(
          name: json["nickname"],
          userId: json["userId"].toString(),
          phone: json["phone"],
        );
      }).toList());
      friends_accept = context.read<FriendProvider>().watingList;
      // for (int i = 0; i < _todoList.length; i++) {
      //   print(_todoList[i].task);
      // }
      //context.read<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> acceptFriend(String friendId) async {
    var dio = Dio();
    //print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/friend/accept?friendId=' + friendId,
        options: Options(
          method: 'POST',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print("acceptFriend:" + response.toString());
      if (response.toString() == "친구 신청 수락 성공") {
        setState(() {
          context.read<FriendProvider>().removeAccept(friendId);
        });
      }
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
        future: getAccept(),
        builder: (context, snapshot) {
          if (friends_accept.length > 0) {
            return Container(
              // 친구 신청 목록
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friends_accept.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(friends_accept[index].name),
                      trailing: TextButton(
                        child: Text("수락"),
                        onPressed: () {
                          acceptFriend(friends_accept[index].userId);
                        },
                      ),
                    );
                  }),
            );
          } else {
            return Text("수락 대기 중인 친구 신청 요청이 없습니다.");
          }
        });
  }
}
