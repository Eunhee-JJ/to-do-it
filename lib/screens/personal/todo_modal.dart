import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoit/models/todo.dart';

class TodoModal extends StatefulWidget {
  const TodoModal({super.key});

  @override
  State<StatefulWidget> createState() => _TodoModalState();
}

class _TodoModalState extends State<TodoModal> {
  List<Todo> TodoList = [
    Todo(false, DateTime.now(), 'Sample1'),
    Todo(false, DateTime.now(), 'Sample2'),
  ];

  @override
  Widget build(BuildContext context) {
    bool _isChecked = true;
    return CupertinoPageScaffold(
        child: ListView(
            children: TodoList.map((todo) => CheckboxListTile(
                  title: Text(todo.name),
                  value: todo.done,
                  onChanged: (val) {
                    setState(() {
                      todo.done = val!;
                    });
                  },
                )).toList()
            // itemCount: TodoList.length,
            // itemBuilder: (context, index) {
            //   return ListTile(
            //     title: Text(TodoList[index].name),
            //   );
            // },
            // separatorBuilder: (context, index) {
            //   return Divider();
            // },
            ));
  }
}
