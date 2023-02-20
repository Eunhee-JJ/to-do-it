import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  String profileImg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: // 프사 + 캘린더 제목
                  Row(children: <Widget>[
                SizedBox(
                  width: 40,
                ),
                Expanded(
                    flex: 8,
                    child: Text("은희님의 투두잇", style: TextStyle(fontSize: 30))),
                Expanded(child: SizedBox()),
                Expanded(
                    child: Icon(
                  CupertinoIcons.person,
                  size: 40,
                )),
                SizedBox(
                  width: 40,
                ),
              ]),
            ),

            // 캘린더
            const Expanded(
              flex: 4,
              child: Text("캘린더"),
            ),
            // 네비바
          ],
        )),
      ),
    );
  }
}
