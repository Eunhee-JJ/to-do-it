class Challenge {
  String challengeName = '';
}

class Todo {
  // 반복 데이터 챌린지에서 연동...?
  Todo({this.id = -1, this.done = false, required this.date, this.name = ''});
  int id;
  bool done;
  DateTime date; // JSON 파싱 해야함
  String name;
}

class MyUser {
  String name = '';
  String profileImg = '';
}

class Login {
  final String accountName;
  final String password;
  //final String user_id;

  Login(this.accountName, this.password);

  Login.fromJson(Map<String, dynamic> json)
      : accountName = json['accountName'],
        password = json['password'];
  //user_id = json['user_id'];

  Map<String, dynamic> toJson() => {
        'accountName': accountName,
        'password': password,
        //'user_id': user_id,
      };
}
