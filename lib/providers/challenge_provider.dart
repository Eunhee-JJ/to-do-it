import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todoit/models/models.dart';

class ChallengeProvider extends ChangeNotifier {
  //Map<DateTime, List<Todo>> _allTodo = {};
  List<Challenge> _ChallengeList = [];
  String _date = DateFormat('yyyy').format(DateTime.now());

  List<Challenge> get ChallengeList => _ChallengeList;
  String get date => _date;
  //Map<DateTime, List<Todo>> get allTodo => _allTodo;
  // List<Todo>? getTodo(DateTime date) {
  //   return _allTodo[date];
  // }

  void update() {
    notifyListeners();
  }

  void setChallengeList(List<Challenge> newChallengeList) {
    _ChallengeList = newChallengeList;
    notifyListeners();
  }

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }

  void add(Challenge _challenge) {
    _ChallengeList.add(_challenge);
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

  // void toggleDone(int id) {
  //   for (int i = 0; i < _todoList.length; i++) {
  //     if (_todoList[i].taskId == id) {
  //       _todoList[i].complete = !_todoList[i].complete;
  //       print("토글: [${id}]" + _todoList[i].task);
  //       break;
  //     }
  //   }
  //   notifyListeners();
  // }

  void remove(String title) {
    for (int i = 0; i < _ChallengeList.length; i++) {
      if (_ChallengeList[i].title == title) {
        _ChallengeList.removeAt(i);
        print("삭제됨: [${title}]" + _ChallengeList[i].title);
        break;
      }
    }
    notifyListeners();
  }
}
