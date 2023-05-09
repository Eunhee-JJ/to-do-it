import 'package:day_picker/day_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/todo_provider.dart';
import 'package:todoit/providers/user_provider.dart';

class AddChallengeModal extends StatefulWidget {
  const AddChallengeModal({super.key});

  @override
  State<StatefulWidget> createState() => _AddChallengeModalState();
}

class _AddChallengeModalState extends State<AddChallengeModal> {
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

      context.watch<TodoProvider>().add(Todo(
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

      context.read<TodoProvider>().toggleDone(taskId);

      //context.watch<TodoProvider>().setTodoList(todoList);
    } catch (error) {
      print(error);
    }
  }

  List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek(
      "Mon",
    ),
    DayInWeek("Tue", isSelected: true),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thu",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(2016, 10, 26);
    // sDate = context.read<TodoProvider>().date;
    // getTodos(context.read<TodoProvider>().date);

    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: 216,
                padding: const EdgeInsets.only(top: 6.0),
                // The Bottom margin is provided to align the popup above the system
                // navigation bar.
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                // Provide a background color for the popup.
                color: CupertinoColors.systemBackground.resolveFrom(context),
                // Use a SafeArea widget to avoid system overlaps.
                child: SafeArea(
                  top: false,
                  child: child,
                ),
              ));
    }

    return Scaffold(
        body: ListView(
      children: [
        // 완료 버튼
        Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
            child: Row(children: [
              Expanded(
                flex: 8,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: Text(
                    '완료',
                    style: TextStyle(
                      fontSize: 20,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                ),
              ),
            ])),

        // 챌린지 이름
        Container(
            padding: EdgeInsets.only(top: 10, left: 40, right: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "챌린지 이름",
                style: TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113), fontSize: 20),
              ),
              TextField(
                autofillHints: ["챌린지 이름"],
              ),
            ])),

        // 반복 요일
        Container(
          padding: EdgeInsets.only(top: 50, left: 40, right: 40),
          //width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "반복 요일",
                style: TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113), fontSize: 20),
              ),
              SelectWeekDays(
                onSelect: () => {},
                days: _days,
                boxDecoration: BoxDecoration(),
                daysFillColor: Colors.blue,
                unSelectedDayTextColor: Colors.black,
                border: false,
              ),
            ],
          ),
        ),

        // 시작일
        Container(
          padding: EdgeInsets.only(top: 50, left: 40, right: 40),
          //width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "시작일",
                style: TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113), fontSize: 20),
              ),
              _DatePickerItem(
                children: <Widget>[
                  //const Text('Date'),
                  CupertinoButton(
                    // Display a CupertinoDatePicker in date picker mode.
                    onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: date,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() => date = newDate);
                        },
                      ),
                    ),
                    // In this example, the date is formatted manually. You can
                    // use the intl package to format the value based on the
                    // user's locale settings.
                    child: Text(
                      '${date.year}년 ${date.month}월 ${date.day}일',
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
              // TextField(
              //   autofillHints: ["챌린지 이름"],
              // ),
            ],
          ),
        ),

        // 종료일
        Container(
          padding: EdgeInsets.only(top: 50, left: 40, right: 40),
          //width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "종료일",
                style: TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113), fontSize: 20),
              ),
              _DatePickerItem(
                children: <Widget>[
                  //const Text('Date'),
                  CupertinoButton(
                    // Display a CupertinoDatePicker in date picker mode.
                    onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: date,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() => date = newDate);
                        },
                      ),
                    ),
                    // In this example, the date is formatted manually. You can
                    // use the intl package to format the value based on the
                    // user's locale settings.
                    child: Text(
                      '${date.year}년 ${date.month}월 ${date.day}일',
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
              // TextField(
              //   autofillHints: ["챌린지 이름"],
              // ),
            ],
          ),
        ),
      ],
    ));
  }
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
      //),
    );
  }
}
