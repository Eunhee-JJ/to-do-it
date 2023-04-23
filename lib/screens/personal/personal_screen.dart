import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoit/models/user_model.dart';
import 'package:todoit/screens/personal/bottom_modal.dart';
import 'package:todoit/screens/personal/personal_calendar.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  MyUser user =
      MyUser('id', '1234@gmail.com', '01038802105', '', 'nickname', '');

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
                    child: Text("${user.nickname}님의 투두잇",
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
                flex: 12,
                child: Container(
                  margin: EdgeInsets.all(36),
                  child: PersonalCalendar(),
                )),

            Expanded(
              flex: 1,
              child: SizedBox(),
            ),

            // 전체 투두 모달
            Expanded(
              flex: 2,
              child: Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 20, top: 15, bottom: 10),
                  child: ListTile(
                    leading: Icon(
                      CupertinoIcons.chevron_up,
                      color: CupertinoColors.activeBlue,
                    ),
                    onTap: () => showBarModalBottomSheet(
                      enableDrag: true,
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => BottomModal(),
                    ),
                    title: Text(
                      '전체 할 일 목록()',
                      style: TextStyle(
                        fontSize: 21,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ),
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          offset: Offset(0, -1),
                          blurRadius: 10,
                        )
                      ])),
            )
          ],
        )),
      ),
    );
  }
}
