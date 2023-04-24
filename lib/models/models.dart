class Challenge {
  String challengeName = '';
}

class Todo {
  // 반복 데이터 챌린지에서 연동...?
  final int todoID;
  final String userID;
  DateTime date = DateTime.now(); // JSON 파싱 해야함
  final String name;
  late final bool done;

  Todo(
    this.todoID,
    this.userID,
    this.date,
    this.name,
    this.done,
  );
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
