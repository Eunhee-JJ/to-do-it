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
  final String userID;
  final String email;
  final String phone;
  final String social;
  final String nickname;
  final String profileImg; // DB에 없네..?

  MyUser(this.userID, this.email, this.phone, this.social, this.nickname,
      this.profileImg);
}

class Login {
  final String nickname;
  final String email;
  final String isJoined;
  final String message;
  //final String user_id;

  Login(
      {required this.nickname,
      required this.email,
      required this.isJoined,
      required this.message});

  Login.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        email = json['email'],
        isJoined = json['isJoined'],
        message = json['message'];
  //user_id = json['user_id'];

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'email': email,
        //'user_id': user_id,
      };
}
