class Auth {
  late final String email;
  late final String phone;
  late final String message;
  late final String code;
  late final String accessToken;
  late final String refreshToken;

  Auth({
    required this.email,
    required this.phone,
    required this.message,
    required this.code,
    required this.accessToken,
    required this.refreshToken,
  });

  Auth.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        phone = json['phone'],
        message = json['message'],
        code = json['code'],
        accessToken = json['accessToken'],
        refreshToken = json['refreshToken'];

  Map<String, dynamic> certificationRequest() => {
        'email': email,
        'phone': phone,
      };

  Map<String, dynamic> verificationRequest() => {
        'email': email,
        'code': code,
      };
}
