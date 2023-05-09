import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:todoit/models/models.dart';
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
  Challenge dummy = Challenge(
      title: "챌린지 이름",
      content: "챌린지 설명",
      day: ["MON"],
      off_day: ["2023-05-09"],
      start_date: "2023-05-08",
      end_date: "2023-05-30",
      friends: []);
  List<Challenge> challenges = [
    Challenge(
        title: "챌린지 이름",
        content: "챌린지 설명",
        day: ["MON"],
        off_day: ["2023-05-09"],
        start_date: "2023-05-08",
        end_date: "2023-05-30",
        friends: []),
    Challenge(
        title: "챌린지 이름2",
        content: "챌린지 설명2",
        day: ["TUE"],
        off_day: ["2023-05-09"],
        start_date: "2023-05-08",
        end_date: "2023-05-30",
        friends: []),
  ];

  MenuType? selectedMenu;

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage:
                        AssetImage(context.read<UserProvider>().profileImage),
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
                                    left: 20, top: 20, bottom: 2, right: 20),
                              )),
                          Expanded(
                            // 메뉴 버튼
                            flex: 1,
                            child: PopupMenuButton<MenuType>(
                              child: Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                    color: Colors.blueGrey, Icons.more_horiz),
                              ),
                              onSelected: (MenuType result) {
                                final snackBar = SnackBar(
                                  content: Text("$result is selected."),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              // itemBuilder 에서 PopMenuItem 리스트 리턴해줘야 함.
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<MenuType>>[
                                const PopupMenuItem<MenuType>(
                                  value: MenuType.first,
                                  child: Text('편집'),
                                ),
                                const PopupMenuItem<MenuType>(
                                  value: MenuType.second,
                                  child: Text('삭제'),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
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
