// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:todoit/models/TodoDataSource.dart';
// import 'package:todoit/models/todo.dart';

// Widget monthCellBuilder_custom(BuildContext context, MonthCellDetails details) {
//   // var length = details.todoList.length;
//   // var done_cnt = 0;
//   var length = 3;
//   var done_cnt = 2;
//   for (int i = 0; i < length; i++) {
//     if (details.appointments[i].done == true) done_cnt += 1;
//   }
//   var percent = done_cnt / length;
//   if (details.appointments.isNotEmpty) {
//     Todo todo = details.appointments[0];
//     return Container(
//       color: Color.fromARGB((percent / 25 * 100) as int, 58, 89, 90),
//       child: Text(details.date.day.toString()),
//     );
//   }
//   return Container(
//     //color: Colors.blueGrey,
//     child: Text(details.date.day.toString()),
//   );
// }
