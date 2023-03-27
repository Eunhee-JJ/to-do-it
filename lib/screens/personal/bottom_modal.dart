import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class BottomModal extends StatefulWidget {
  const BottomModal({super.key});

  @override
  State<StatefulWidget> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  List<Todo> dummyTodo = [
    Todo(id: 1, done: false, date: DateTime.now(), name: 'Dummy1'),
    Todo(id: 2, done: false, date: DateTime.now(), name: 'Dummy2'),
  ];

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // 앱바
        Container(
            padding: EdgeInsets.only(left: 30, right: 20, top: 15, bottom: 10),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.chevron_down,
                color: CupertinoColors.activeBlue,
              ),
              onTap: () => Navigator.pop(context),
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
                  top: Radius.circular(25),
                ),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.grey.withOpacity(0.7),
                  //   offset: Offset(0, -1),
                  //   blurRadius: 6,
                  // )
                ])),

        // 투두리스트
        ListView.builder(
          shrinkWrap: true,
          itemCount: dummyTodo.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(dummyTodo[index].name),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: dummyTodo[index].done,
                      onChanged: (bool? value) {
                        setState(() {
                          dummyTodo[index].done = value!;
                        });
                      },
                    ),
                    Text(dummyTodo[index].name),
                  ],
                ));
          },
        )
      ],
    ));
  }
}
