import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/todo_provider.dart';
import 'package:todoit/providers/user_provider.dart';

class DayTodoModal extends StatefulWidget {
  const DayTodoModal({super.key});

  @override
  State<StatefulWidget> createState() => _DayTodoModalState();
}

class _DayTodoModalState extends State<DayTodoModal> {
  List<Todo> todoList = [
    // Todo(1, DateTime.now(), 'Dummy1', false, false),
    // Todo(2, DateTime.now(), 'Dummy2', false, false),
  ];
  String sDate = '';

  String input = "";

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

  Future<void> getTodos(String date) async {
    print(date);

    var dio = Dio();
    print("AT:" + Provider.of<UserProvider>(context).accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/todo?date=' + date,
        options: Options(
          method: 'GET',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print(response);
      todoList = (response.data["task"]).map<Todo>((json) {
        return Todo(
          taskId: json["taskId"],
          task: json["task"],
          date: date,
          complete: json["complete"],
          challenge: json["challenge"],
        );
      }).toList();
      context.read<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> addTodo(String task) async {
    print("addTask:" + task);

    var dio = Dio();
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/todo?task=' + task,
        options: Options(
          method: 'POST',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print(response);

      ;
      todoList.add(Todo(
        taskId: response.data["taskId"],
        task: response.data["task"],
        date: context.read<TodoProvider>().date,
        complete: response.data["complete"] == "true" ? true : false,
        challenge: response.data["challenge"] == "true" ? true : false,
      ));
      context.read<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    sDate = context.read<TodoProvider>().date;
    getTodos(context.read<TodoProvider>().date);
    return AlertDialog(
        content: Container(
            width: 500,
            height: 600,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(sDate, style: TextStyle(fontSize: 25)),
                  padding: EdgeInsets.all(15),
                ),
              ),
              Expanded(
                  flex: 15,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      getTodos(context.read<TodoProvider>().date);
                      return Dismissible(
                          key: Key(todoList[index].task),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: todoList[index].complete,
                                onChanged: (bool? value) {
                                  setState(() {
                                    todoList[index].complete = value!;
                                  });
                                },
                              ),
                              Text(todoList[index].task),
                            ],
                          ));
                    },
                  )),
              Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 230,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text("Add Todolist"),
                                    content: TextField(
                                      onChanged: (String value) {
                                        input = value;
                                      },
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            addTodo(input);
                                            getTodos(context
                                                .read<TodoProvider>()
                                                .date);
                                            //setState(() {
                                            // todoList.add(
                                            //   Todo(1, DateTime.now(), input,
                                            //       false, false),
                                            // );
                                            //});
                                          },
                                          child: Text("Add"))
                                    ]);
                              });
                        },
                        child: Icon(Icons.add),
                      )
                    ],
                  )),
            ])));
  }
}
