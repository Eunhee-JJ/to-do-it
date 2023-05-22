import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/challenge_provider.dart';
import 'package:todoit/providers/user_provider.dart';
import 'package:todoit/screens/challenges/addChallenge_modal.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChallengesScreenState();
}

enum MenuType {
  first,
  second,
  third,
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<Challenge> challenges = [
    // Challenge(
    //     title: "챌린지 이름",
    //     content: "챌린지 설명",
    //     day: ["MON"],
    //     off_day: ["2023-05-09"],
    //     start_date: "2023-05-08",
    //     end_date: "2023-05-30",
    //     friends: []),
    // Challenge(
    //     title: "챌린지 이름2",
    //     content: "챌린지 설명2",
    //     day: ["TUE"],
    //     off_day: ["2023-05-09"],
    //     start_date: "2023-05-08",
    //     end_date: "2023-05-30",
    //     friends: []),
  ];

  MenuType? selectedMenu;

  Future<void> getChallenge() async {
    print("getChallenge");

    var dio = Dio();
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/challenge',
        options: Options(
          method: 'GET',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
        //data: {title, content, selectedDays, [], startDate, endDate, []}
      );
      print(response);

      if (response.data['httpStatus'] == "OK") {
        context.read<ChallengeProvider>().setChallengeList(
                (response.data["userChallenge"]).map<Challenge>((json) {
              return Challenge(
                  title: json["title"],
                  content: json["content"],
                  day: [],
                  // response.data["day"] == Null
                  //     ? []
                  //     : response.data["day"],
                  off_day: [],
                  // response.data["off_day"] == null
                  //     ? []
                  //     : response.data["off_day"],
                  start_date: json["start_date"],
                  //response.data["isFromChallenge"] == "true" ? true : false,
                  end_date: json["end_date"],
                  friends: []
                  // response.data["friends"] == null
                  //     ? []
                  //     : response.data["friends"],
                  );
            }).toList());
        challenges = context.read<ChallengeProvider>().ChallengeList;
      } else
        print("getChallenge fail");
      //context.watch<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteChallenge(String title) async {
    print("deleteChallenge");

    var dio = Dio();
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response =
          await dio.request('http://43.200.184.84:8080/api/challenge',
              options: Options(
                method: 'DELETE',
                headers: {
                  "Authorization": context.read<UserProvider>().accessToken
                },
              ),
              data: {'title': title});
      print(response);

      if (response.data['httpStatus'] == "OK") {
        context.read<ChallengeProvider>().remove(title);
        print("$title 삭제 성공");
      } else
        print("getChallenge fail");
      //context.watch<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getChallenge(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
                child: SafeArea(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                // 프로필
                Expanded(
                  flex: 2,
                  child: Row(children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                        flex: 8,
                        child: Text(
                            "${context.read<UserProvider>().user.nickname}님의 챌린지",
                            style: TextStyle(fontSize: 30))),
                    Expanded(child: SizedBox()),
                    Expanded(
                        flex: 2,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              context.read<UserProvider>().profileImageUrl),
                          radius: 30,
                        )),
                    SizedBox(
                      width: 40,
                    ),
                  ]),
                ),

                // 챌린지
                Expanded(
                  flex: 12,
                  child: ListView.separated(
                    padding: EdgeInsets.all(25),
                    itemCount: challenges.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    // 타이틀
                                    flex: 9,
                                    child: Container(
                                      child: Text(
                                        challenges[index].title,
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                          bottom: 2,
                                          right: 20),
                                    )),
                                Expanded(
                                  // 메뉴 버튼
                                  flex: 1,
                                  child: PopupMenuButton<MenuType>(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                          color: Colors.blueGrey,
                                          Icons.more_horiz),
                                    ),
                                    onSelected: (MenuType result) {
                                      // final snackBar = SnackBar(
                                      //   content: Text("$result is selected."),
                                      // );
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(snackBar);
                                    },
                                    // itemBuilder 에서 PopMenuItem 리스트 리턴해줘야 함.
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<MenuType>>[
                                      PopupMenuItem<MenuType>(
                                        value: MenuType.first,
                                        child: Text('편집'),
                                      ),
                                      PopupMenuItem<MenuType>(
                                        value: MenuType.second,
                                        child: Text('삭제'),
                                        onTap: () async {
                                          await deleteChallenge(
                                              challenges[index].title);
                                          setState(() {
                                            // deleteChallenge(
                                            //     challenges[index].title);
                                          });
                                          //context.watch<ChallengeProvider>().update();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(
                                // 챌린지 설명
                                challenges[index].content,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 128, 128, 128)),
                              ),
                              padding: EdgeInsets.only(
                                  left: 20, top: 2, bottom: 8, right: 20),
                            ),
                            Container(
                              child: Text(
                                // 챌린지 기간
                                "${challenges[index].start_date}~${challenges[index].end_date}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 128, 128, 128)),
                              ),
                              padding: EdgeInsets.only(
                                  left: 20, top: 2, bottom: 20, right: 20),
                            ),
                          ],
                        ),

                        // ListTile(
                        //   title: Text(challenges[index].title),
                        //   subtitle: Text(challenges[index].content),
                        // ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 1,
                  ),
                )
              ],
            ))),
            floatingActionButton: FloatingAction(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endContained,
          );
        });
  }
}

class FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 80, right: 10),
          child: FloatingActionButton(
            onPressed: () {
              print('click en botton');
              showBarModalBottomSheet(
                enableDrag: true,
                expand: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => AddChallengeModal(),
              );
            },
            child: Icon(Icons.add),
            //backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
