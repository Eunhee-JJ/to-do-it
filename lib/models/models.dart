import 'package:intl/intl.dart';

class Challenge {
  String challengeName = '';
}

class Todo {
  // 반복 데이터 챌린지에서 연동...?
  final int taskId;
  //final String userID;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now()); // JSON 파싱 해야함
  final String task;
  late final bool complete;
  late final bool challenge;

  Todo(
      {required this.taskId,
      //this.userID,
      required this.date,
      required this.task,
      required this.complete,
      required this.challenge});
}

class MyUser {
  String userID;
  String email;
  String phone;
  String social;
  String nickname;
  String profileImg; // DB에 없네..?
  String accessToken;
  String refreshToken;

  MyUser(
      {required this.userID,
      required this.email,
      required this.phone,
      required this.social,
      required this.nickname,
      required this.profileImg,
      required this.accessToken,
      required this.refreshToken});
}
