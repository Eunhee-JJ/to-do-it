import 'package:flutter/cupertino.dart';
import 'package:todoit/models/models.dart';

class UserProvider extends ChangeNotifier {
  MyUser _user = MyUser(
      userID: '',
      email: '',
      phone: '',
      social: '',
      nickname: '',
      profileImageUrl: '',
      accessToken: '',
      refreshToken: '');

  MyUser get user => _user;
  String get userID => _user.userID;
  String get email => _user.email;
  String get phone => _user.phone;
  String get social => _user.social;
  String get nickname => _user.nickname;
  String get profileImageUrl => _user.profileImageUrl;
  String get accessToken => _user.accessToken;
  String get refreshToken => _user.refreshToken;

  set user(MyUser user) {
    _user = user;
    notifyListeners();
  }

  void setUserID(String userID) {
    _user.userID = userID;
    notifyListeners();
  }

  void setEmail(String email) {
    _user.email = email;
    notifyListeners();
  }

  void setPhone(String phone) {
    _user.phone = phone;
    notifyListeners();
  }

  void setSocial(String social) {
    _user.userID = social;
    notifyListeners();
  }

  void setNickname(String nickname) {
    _user.nickname = nickname;
    notifyListeners();
  }

  void setProfileImg(String? profileImageUrl) {
    _user.profileImageUrl = profileImageUrl!;
    notifyListeners();
  }

  void setAccessToken(String accessToken) {
    _user.accessToken = accessToken;
    notifyListeners();
  }

  void setRefreshToken(String refreshToken) {
    _user.accessToken = refreshToken;
    notifyListeners();
  }
}
