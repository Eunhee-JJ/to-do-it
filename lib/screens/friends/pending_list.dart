import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/friend_provider.dart';
import 'package:todoit/providers/user_provider.dart';

class PendingList extends StatefulWidget {
  const PendingList({super.key});

  @override
  State<StatefulWidget> createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {
  List<Friend> friends_pending = [];

  Future<void> getPending() async {
    var dio = Dio();
    //print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/friend/pending',
        options: Options(
          method: 'GET',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print("pendingList:" + response.toString());
      context.read<FriendProvider>().pendingList =
          ((response.data["friend_list"]).map<Friend>((json) {
        return Friend(
          name: json["nickname"],
          userId: json["userId"].toString(),
          phone: json["phone"],
        );
      }).toList());
      //print("hi");
      friends_pending = context.read<FriendProvider>().pendingList;
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
        future: getPending(),
        builder: (context, snapshot) {
          if (friends_pending.length > 0) {
            return Container(
              // 친구 신청 목록
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: friends_pending.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(friends_pending[index].name),
                      trailing: TextButton(
                        child: Text("취소"),
                        onPressed: () {},
                      ),
                    );
                  }),
            );
          } else {
            return Text("수락 대기 중인 친구 추가 전송 내역이 없습니다.");
          }
        });
  }
}
