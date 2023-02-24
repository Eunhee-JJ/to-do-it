import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoit/models/todo.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalCalendarSatae();
}

class _PersonalCalendarSatae extends State<PersonalCalendar> {
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
        //CalendarResource resource = details.resource!;
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("hi"),
              );
            });
      },
      // onTap: (calendarTapDetails) => showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         content: Text("hi"),
      //       );
      //     }),
    ));
  }
}
