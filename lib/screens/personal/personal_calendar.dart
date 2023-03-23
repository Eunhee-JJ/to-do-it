import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
//import 'package:todoit/models/TodoDataSource.dart';
import 'package:todoit/models/todo.dart';
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
  // // 데이터 로드 필요
  // TodoDataSource _getCalendarDataSource() {
  //   List<Todo> appointments = <Todo>[];
  //   appointments.add(Todo(
  //     id: 0,
  //     done: false,
  //     date: now,
  //     name: 'sample',
  //   ));

  //   return TodoDataSource(appointments);
  // }
  Color _getMonthCellBackgroundColor(DateTime date) {
    return Colors.blue;
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
        CalendarResource resource = details.resource!;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                content: DayTodoModal(),
              );
            });
      },
    ));
  }
}
