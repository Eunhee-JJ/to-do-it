import 'package:flutter/cupertino.dart';
import 'package:todoit/models/models.dart';

class UserProvider extends ChangeNotifier {
  late MyUser _user;

  //MyUser get user => _user;

  set user(String newID) {
    _user.userID = newID;
  }
}
