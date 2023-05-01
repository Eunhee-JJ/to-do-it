import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todoit/models/models.dart';

class TodoProvider extends ChangeNotifier {
  //Map<DateTime, List<Todo>> _allTodo = {};
  List<Todo> _todoList = [];
  String _date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<Todo> get todoList => _todoList;
  String get date => _date;
  //Map<DateTime, List<Todo>> get allTodo => _allTodo;
  // List<Todo>? getTodo(DateTime date) {
  //   return _allTodo[date];
  // }

  void setTodoList(List<Todo> newTodoList) {
    _todoList = newTodoList;
  }

  void setDate(String date) {
    _date = date;
  }

  void add(int id, String date, String input) {
    // _todoList.add(Todo(
    //     taskId: id,
    //     date: date,
    //     task: input,
    //     complete: false,
    //     challenge: false));
    //_todoList.add(Todo(id, date, input, false, false));
    notifyListeners();
  }

  int getDegree(DateTime date) {
    int done = 0;

    // for (int i = 0; i < _allTodo[date]!.length; i++) {
    //   if (_allTodo[date]![i].complete == true) {
    //     done++;
    //   }
    // }
    // return _allTodo[date] == null ? 0 : done ~/ _allTodo[date]!.length * 4;

    return 0;
  }

  void edit() {}

  void toggleDone() {}

  void remove(int id) {}
}
