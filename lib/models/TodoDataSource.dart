import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoit/models/todo.dart';

// MonthCellDetails Class를 커스텀한 것

class TodoDataSource extends CalendarDataSource {
  /// Default constructor to store the details needed in month cell builder
  TodoDataSource(List<Todo> source) {
    appointments = source;
  }

  @override
  int getId(int index) {
    return appointments![index].id;
  }

  @override
  DateTime getDate(int index) {
    return appointments![index].date;
  }

  @override
  bool getDone(int index) {
    return appointments![index].done;
  }

  @override
  String getName(int index) {
    return appointments![index].name;
  }
}
