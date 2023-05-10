import 'package:day_picker/day_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/challenge_provider.dart';
import 'package:todoit/providers/todo_provider.dart';
import 'package:todoit/providers/user_provider.dart';

class AddChallengeModal extends StatefulWidget {
  const AddChallengeModal({super.key});

  @override
  State<StatefulWidget> createState() => _AddChallengeModalState();
}

class _AddChallengeModalState extends State<AddChallengeModal> {
  String title = "";
  String content = "";
  List<String> selectedDays = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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

  Future<void> addChallenge() async {
    print("addChallenge:" + title);

    var dio = Dio();
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response =
          await dio.request('http://43.200.184.84:8080/api/challenge',
              options: Options(
                method: 'POST',
                headers: {
                  "Authorization": context.read<UserProvider>().accessToken
                },
              ),
              data: {
            'title': title,
            'content': content,
            'day': selectedDays,
            'off_day': [],
            'start_date': DateFormat('yyyy-MM-dd').format(startDate),
            'end_date': DateFormat('yyyy-MM-dd').format(endDate),
            'friends': []
          });
      print(response);

      // context.read<ChallengeProvider>().add(Challenge(
      //       title: response.data["title"],
      //       content: response.data["content"],
      //       day: response.data["day"],
      //       off_day: response.data["off_day"],
      //       start_date: response.data["start_date"],
      //       //response.data["isFromChallenge"] == "true" ? true : false,
      //       end_date: response.data["end_date"],
      //       friends: response.data["friends"],
      //     ));
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
    // sDate = context.read<TodoProvider>().date;
    // getTodos(context.read<TodoProvider>().date);

    void getDays(List<String> days) {
      selectedDays.clear();
      for (var day in days) {
        selectedDays.add(day.toUpperCase());
      }
      print(selectedDays);
    }

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
                  onPressed: () => {addChallenge(), Navigator.pop(context)},
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
                style: TextStyle(fontSize: 25),
                //autofillHints: ["챌린지 이름"],
                onChanged: (String value) {
                  title = value;
                  //print(title);
                },
              ),
            ])),

        // 챌린지 설명
        Container(
            padding: EdgeInsets.only(top: 40, left: 40, right: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "챌린지 설명",
                style: TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113), fontSize: 20),
              ),
              TextField(
                style: TextStyle(fontSize: 20),
                //autofillHints: ["챌린지 이름"],
                onChanged: (String value) {
                  content = value;
                  //print(content);
                },
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
                onSelect: (values) {
                  print(values);
                  getDays(values);
                },
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
                        initialDateTime: startDate,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() => startDate = newDate);
                        },
                      ),
                    ),
                    // In this example, the date is formatted manually. You can
                    // use the intl package to format the value based on the
                    // user's locale settings.
                    child: Text(
                      '${startDate.year}년 ${startDate.month}월 ${startDate.day}일',
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
                        initialDateTime: endDate,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() => endDate = newDate);
                        },
                      ),
                    ),
                    // In this example, the date is formatted manually. You can
                    // use the intl package to format the value based on the
                    // user's locale settings.
                    child: Text(
                      '${endDate.year}년 ${endDate.month}월 ${endDate.day}일',
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

        // 함께할 친구
        Container(
          padding: EdgeInsets.only(top: 50, left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "함께할 친구",
                style: TextStyle(
                    color: Color.fromARGB(255, 113, 113, 113), fontSize: 20),
              ),
              IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.blue,
                    size: 40,
                  )),
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
