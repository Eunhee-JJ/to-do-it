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
            // 프로필
            Expanded(
              flex: 2,
              child: Row(children: <Widget>[
                SizedBox(
                  width: 40,
                ),
                Expanded(
                    flex: 8,
                    child: Text("은희님의 투두잇", style: TextStyle(fontSize: 30))),
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
                flex: 5,
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: PersonalCalendar(),
                )),
          ],
        )),
      ),
    );
  }
}
