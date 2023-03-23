import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoit/models/todo.dart';

class DayTodoModal extends StatefulWidget {
  const DayTodoModal({super.key});

  @override
  State<StatefulWidget> createState() => _DayTodoModalState();
}

class _DayTodoModalState extends State<DayTodoModal> {
  List<Todo> TodoList = [
    Todo(id: 1, done: false, date: DateTime.now(), name: 'Sample1'),
    Todo(id: 2, done: false, date: DateTime.now(), name: 'Sample2'),
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
        body: ListView.builder(
      shrinkWrap: true,
      itemCount: TodoList.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            key: Key(TodoList[index].name),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: TodoList[index].done,
                  onChanged: (bool? value) {
                    setState(() {
                      TodoList[index].done = value!;
                    });
                  },
                ),
                Text(TodoList[index].name),
              ],
            ));
      },
    ));
  }
}
