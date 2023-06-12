import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todoit/models/models.dart';

class FriendProvider extends ChangeNotifier {
  //Map<DateTime, List<Todo>> _allTodo = {};
  List<Friend> _friendsList = [];
  List<Friend> _pendingList = [];
  List<Friend> _watingList = [];
  List<Friend> _joinedList = [];
  String _date = DateFormat('yyyy').format(DateTime.now());

  List<Friend> get friendsList => _friendsList;
  List<Friend> get pendingList => _pendingList;
  List<Friend> get watingList => _watingList;
  List<Friend> get joinedList => _joinedList;

  set friendsList(List<Friend> newFriendsList) {
    _friendsList = newFriendsList;
    notifyListeners();
  }

  set pendingList(List<Friend> newFriendsList) {
    _pendingList = newFriendsList;
    notifyListeners();
  }

  set watingList(List<Friend> newFriendsList) {
    _watingList = newFriendsList;
    notifyListeners();
  }

  set joinedList(List<Friend> newFriendsList) {
    _joinedList = newFriendsList;
    notifyListeners();
  }

  // void setFriendsList(List<Friend> newFriendsList) {
  //   _friendsList = newFriendsList;
  //   notifyListeners();
  // }

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }

  void add(Friend friend) {
    _friendsList.add(friend);
    notifyListeners();
  }

  void edit() {}

  void removeFriend(String id) {
    for (int i = 0; i < _friendsList.length; i++) {
      if (_friendsList[i].userId == id) {
        _friendsList.removeAt(i);
        print("삭제됨: [${id}]" + _friendsList[i].name);
        break;
      }
    }
    notifyListeners();
  }

  void removeAccept(String id) {
    for (int i = 0; i < _watingList.length; i++) {
      if (_watingList[i].userId == id) {
        _watingList.removeAt(i);
        print("삭제됨: [${id}]" + _watingList[i].name);
        break;
      }
    }
    notifyListeners();
  }

  void removePending(String id) {
    for (int i = 0; i < _pendingList.length; i++) {
      if (_pendingList[i].userId == id) {
        _pendingList.removeAt(i);
        print("삭제됨: [${id}]" + _pendingList[i].name);
        break;
      }
    }
    notifyListeners();
  }
}
