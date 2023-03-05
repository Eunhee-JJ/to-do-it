import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoit/models/todo.dart';
import 'package:todoit/screens/personal/todo_modal.dart';

import '../login/login_screen.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalCalendarState();
}

class _PersonalCalendarState extends State<PersonalCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCalendar(
      view: CalendarView.month,
      controller: _calendarController,
      showDatePickerButton: true,
      onSelectionChanged: (CalendarSelectionDetails details) {
        DateTime date = details.date!;
        // CalendarResource resource = details.resource!;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: TodoModal(),
              );
            });
      },
    ));
  }
}
