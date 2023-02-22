import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalCalendarSatae();
}

class _PersonalCalendarSatae extends State<PersonalCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14));
  }
}
