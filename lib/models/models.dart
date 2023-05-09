import 'package:intl/intl.dart';

class Friends {
  String nickname = '';
  String phone = '';
}

class Challenge {
  String title = '';
  String content = '';
  List<String> day = [];
  List<String> off_day = [];
  String start_date = '';
  String end_date = '';
  List<Friends> friends = [];

  Challenge(
      {required this.title,
      required this.content,
      required this.day,
      required this.off_day,
      required this.start_date,
      required this.end_date,
      required this.friends});
}

class Todo {
  // 반복 데이터 챌린지에서 연동...?
  final int taskId;
  //final String userID;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now()); // JSON 파싱 해야함
  final String task;
  late final bool complete;
  late final bool isFromChallenge;
  final String challenge;

  Todo(
      {required this.taskId,
      //this.userID,
      required this.date,
      required this.task,
      required this.complete,
      required this.isFromChallenge,
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
