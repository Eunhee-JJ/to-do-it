import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoit/models/auth_model.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  State<StatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String email = '@';
  late String code = '';
  late String phone = '';
  // Auth temp = new Auth(
  //     email: 'example',
  //     phone: '01038802105',
  //     message: '',
  //     code: '',
  //     accessToken: '',
  //     refreshToken: '');

  Future<void> Certification() async {
    var dio = Dio();
    var param = {
      'email': '$email',
      'phone': '$phone',
    };
    Response response = await dio.post(
        'http://43.200.184.84:8080/api/auth/sms-certification',
        data: param);

    if (response.data['message'] == "사용자에게 인증번호를 전송하였습니다.") {
      print("사용자에게 인증번호를 전송하였습니다.");
    } else {
      print("인증번호 전송 실패");
    }
  }

  Future<void> Verification() async {
    // String email = temp.email.toString();
    // String code = temp.code.toString();
    var dio = Dio();
    var param = {
      'email': '$email',
      'code': '$code',
    };
    Response response = await dio.post(
        'http://43.200.184.84:8080/api/auth/sms-verification',
        data: param);

    if (response.data['message'] == "인증번호가 일치합니다.") {
      print("인증번호가 일치합니다.");
      Navigator.pushNamed(context, '/home');
    } else {
      print("인증번호가 일치하지 않습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          //child:SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "본인인증이 필요합니다.",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(labelText: "휴대폰 번호를 입력하세요."),
                          onChanged: (text) {
                            setState(() {
                              phone = text;
                            });
                          },
                          autofocus: true,
                        ),
                        TextButton(
                          onPressed: () =>
                              //Navigator.pushNamed(context, '/home')
                              Certification(),
                          child: Text("인증"),
                        ),
                        TextField(
                          decoration:
                              InputDecoration(labelText: "전송된 인증 번호를 입력하세요."),
                          onChanged: (text) {
                            setState(() {
                              code = text;
                            });
                          },
                          autofocus: true,
                        ),
                        TextButton(
                          onPressed: () =>
                              //Navigator.pushNamed(context, '/home'),
                              Verification(),
                          child: Text("확인"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 3, child: SizedBox()),
                ],
              ))
          //padding: EdgeInsets.all(10),
          ),
    );
  }
}
