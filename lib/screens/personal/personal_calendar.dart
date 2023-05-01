import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoit/models/TodoDataSource.dart';
//import 'package:todoit/models/TodoDataSource.dart';
import 'package:todoit/models/models.dart';
import 'package:todoit/providers/todo_provider.dart';
import 'package:todoit/providers/user_provider.dart';
import 'package:todoit/screens/personal/dayTodo_modal.dart';
//import 'package:todoit/models/MonthCellDetails_custom.dart';

//import 'monthCellBuilder_custom.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalCalendarState();
}

class _PersonalCalendarState extends State<PersonalCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  CalendarController _calendarController = CalendarController();

  final DateTime now = DateTime.now();
  // 데이터 로드 필요
  // TodoDataSource _getCalendarDataSource(todoList) {
  //   // List<Todo> appointments = <Todo>[];
  //   // appointments.add(Todo(
  //   //   id: 0,
  //   //   done: false,
  //   //   date: now,
  //   //   name: 'sample',
  //   // ));

  //   return TodoDataSource(todoList);
  //}
  Color _getMonthCellBackgroundColor(DateTime date) {
    if (context.read<TodoProvider>().getDegree(date) == 0) {
      return Color.fromARGB(64, 33, 150, 243);
    } else if (context.read<TodoProvider>().getDegree(date) == 1) {
      return Color.fromARGB(128, 33, 150, 243);
    } else if (context.read<TodoProvider>().getDegree(date) == 2) {
      return Color.fromARGB(192, 33, 150, 243);
    } else if (context.read<TodoProvider>().getDegree(date) == 3) {
      return Color.fromARGB(255, 33, 150, 243);
    }
    return Colors.white;
  }

  Future<void> getTodos(DateTime date) async {
    // var _options = BaseOptions(
    //   method: 'GET',
    //   baseUrl: 'http://43.200.184.84:8080/api',
    //   connectTimeout: 5000,
    //   receiveTimeout: 3000,
    // );

    var dio = Dio();
    print("AT:" + context.read<UserProvider>().accessToken);

    try {
      final response = await dio.request(
        'http://43.200.184.84:8080/api/todo',
        options: Options(
          method: 'GET',
          headers: {"Authorization": context.read<UserProvider>().accessToken},
        ),
        data: {'date': date},
      );

      context.watch<TodoProvider>().todoList;
    } catch (error) {
      print(error);
    }

    //context.read<TodoProvider>().allTodo = Map<>response;

    // 서비스 가입 여부 확인
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCalendar(
      view: CalendarView.month,
      monthCellBuilder: (BuildContext buildContext, MonthCellDetails details) {
        final Color backgroundColor =
            _getMonthCellBackgroundColor(details.date);
        final Color defaultColor =
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black54
                : Colors.white;
        return Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: defaultColor, width: 0.5)),
          child: Center(
            child: Text(
              details.date.day.toString(),
              //style: TextStyle(color: _getCellTextColor(backgroundColor)),
            ),
          ),
        );
      },
      //controller: _calendarController,
      showDatePickerButton: true,
      monthViewSettings: MonthViewSettings(
        showTrailingAndLeadingDates: false,
      ),
      onSelectionChanged: (CalendarSelectionDetails details) {
        DateTime date = details.date!;
        context
            .read<TodoProvider>()
            .setDate(DateFormat('yyyy-MM-dd').format(date));
        //getTodos(date);

        //CalendarResource resource = details.resource!;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DayTodoModal();
              //);
            });
      },
    ));
  }
}
