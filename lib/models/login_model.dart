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
        //message = json['message'];
  //user_id = json['user_id'];

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'email': email,
        //'user_id': user_id,
      };
}
