import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todoit/models/models.dart';

class TodoProvider extends ChangeNotifier {
  //Map<DateTime, List<Todo>> _allTodo = {};
  List<Todo> _todoList = [];
  String _date = DateFormat('yyyy').format(DateTime.now());

  List<Todo> get todoList => _todoList;
  String get date => _date;
  //Map<DateTime, List<Todo>> get allTodo => _allTodo;
  // List<Todo>? getTodo(DateTime date) {
  //   return _allTodo[date];
  // }

  void setTodoList(List<Todo> newTodoList) {
    _todoList = newTodoList;
    notifyListeners();
  }

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }

  void add(Todo todo) {
    _todoList.add(todo);
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

  void toggleDone(int id) {
    for (int i = 0; i < _todoList.length; i++) {
      if (_todoList[i].taskId == id) {
        _todoList[i].complete = !_todoList[i].complete;
        print("토글: [${id}]" + _todoList[i].task);
        break;
      }
    }
    notifyListeners();
  }

  void remove(int id) {
    for (int i = 0; i < _todoList.length; i++) {
      if (_todoList[i].taskId == id) {
        _todoList.removeAt(i);
        print("삭제됨: [${id}]" + _todoList[i].task);
        break;
      }
    }
    notifyListeners();
  }
}
