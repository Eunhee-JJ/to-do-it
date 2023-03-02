import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoit/models/user.dart';
import 'package:todoit/screens/personal/personal_calendar.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  User user = User();

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
                    child: Text("${user.name}님의 투두잇",
                        style: TextStyle(fontSize: 30))),
                Expanded(child: SizedBox()),
                Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(user.profileImg),
                      radius: 30,
                    )),
                SizedBox(
                  width: 40,
                ),
              ]),
            ),

            // 캘린더
            Expanded(
                flex: 9,
                child: Container(
                  margin: EdgeInsets.all(37),
                  child: PersonalCalendar(),
                  // decoration: BoxDecoration(
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey.withOpacity(0.5),
                  //     )
                  //   ],
                  // ),
                )),

            Expanded(
              flex: 1,
              child: SizedBox(),
            ),

            // 전체 투두 모달
            Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      CupertinoIcons.chevron_up,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '전체 할 일 목록()',
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ],
                ),
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 248, 248, 248),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        offset: Offset(0, -1),
                        blurRadius: 10,
                      )
                    ])),
          ],
        )),
      ),
    );
  }
}
