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
  List<Todo> _todoList = [
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
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/todo?date=' + date,
        options: Options(
          method: 'GET',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print(response);
      context
          .read<TodoProvider>()
          .setTodoList((response.data["task"]).map<Todo>((json) {
            return Todo(
              taskId: json["taskId"],
              task: json["task"],
              date: date,
              complete: json["complete"],
              isFromChallenge: false,
              //json["isFromChallenge"],
              challenge: '',
            );
          }).toList());
      _todoList = context.read<TodoProvider>().todoList;
      // for (int i = 0; i < _todoList.length; i++) {
      //   print(_todoList[i].task);
      // }
      //context.read<TodoProvider>().setTodoList(todoList);
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

      context.read<TodoProvider>().add(Todo(
            taskId: response.data["taskId"],
            task: response.data["task"],
            date: context.read<TodoProvider>().date,
            complete: response.data["complete"] == "true" ? true : false,
            isFromChallenge: false,
            //response.data["isFromChallenge"] == "true" ? true : false,
            challenge: '',
          ));
      //context.watch<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteTodo(int taskId) async {
    print("Delete Task:" + taskId.toString());

    var dio = Dio();
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/todo?taskId=' + taskId.toString(),
        options: Options(
          method: 'DELETE',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print(response);

      if (response.data['message'] != "존재하지 않는 투두 번호입니다.") {
        context.watch<TodoProvider>().remove(taskId);
      }
      print("hi");
      //context.watch<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  Future<void> completeTodo(int taskId) async {
    print("Complete Task:" + taskId.toString());

    // context.read<TodoProvider>().toggleDone(taskId);

    var dio = Dio();
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/todo/complete?taskId=' +
            taskId.toString(),
        options: Options(
          method: 'POST',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
      );
      print(response);

      //context.watch<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("modal");
    sDate = context.read<TodoProvider>().date;
    // getTodos(context.read<TodoProvider>().date).then((value) => {});
    // //_todoList = context.read<TodoProvider>().todoList;
    // print(_todoList.length);

    return FutureBuilder(
      future: getTodos(context.read<TodoProvider>().date),
      builder: (context, snapshot) {
        //if(snapshot.hasData){
        return AlertDialog(
            content: Container(
                width: 500,
                height: 600,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        // 날짜
                        flex: 3,
                        child: Container(
                          child: Text(sDate, style: TextStyle(fontSize: 25)),
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                      Expanded(
                          // 투두 목록
                          flex: 15,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _todoList.length,
                            itemBuilder: (context, int index) {
                              //print("Elqk");
                              //print("HI");
                              //print(todoList);
                              //getTodos(context.read<TodoProvider>().date);
                              return Dismissible(
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      setState(() {
                                        deleteTodo(_todoList[index].taskId);
                                        getTodos(
                                            context.watch<TodoProvider>().date);
                                        print("index: ${index}");
                                      });
                                    }
                                  },
                                  key: Key(context
                                      .read<TodoProvider>()
                                      .todoList[index]
                                      .task),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: context
                                            .read<TodoProvider>()
                                            .todoList[index]
                                            .complete,
                                        onChanged: (bool? value) async {
                                          await completeTodo(
                                              _todoList[index].taskId);
                                          // await new Future.delayed(
                                          //     const Duration(seconds: 5));

                                          // context
                                          //     .read<TodoProvider>()
                                          //     .toggleDone(
                                          //         _todoList[index].taskId);

                                          setState(() {
                                            // completeTodo(
                                            //     _todoList[index].taskId);

                                            // _todoList[index].complete =
                                            //     !_todoList[index].complete;

                                            // getTodos(context
                                            //     .read<TodoProvider>()
                                            //     .date);
                                          });
                                        },
                                      ),
                                      Text(_todoList[index].task),
                                    ],
                                  ));
                            },
                          )),
                      Expanded(
                          // Add 버튼
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
                                                    setState(() {
                                                      addTodo(input);
                                                    });
                                                    Navigator.pop(context);
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
        //}
      },
    );
  }
}
