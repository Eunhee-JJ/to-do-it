import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:todoit/models/models.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /* ==================== 로그인 상태 유지 ==================== */
  // final storage = new FlutterSecureStorage();
  // dynamic userInfo = '';

  // @override
  // void initState() {
  //   super.initState();
  //   print("initState");
  //   // 비동기로 flutter secure storage 정보를 불러오는 작업
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _asyncMethod();
  //   });
  // }

  // _asyncMethod() async {
  //   // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
  //   // 데이터가 없을때는 null을 반환
  //   userInfo = await storage.read(key: 'login');

  //   // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
  //   if (userInfo != null) {
  //     Navigator.pushNamed(context, '/home');
  //   } else {
  //     print('로그인이 필요합니다');
  //   }
  // }
  /* ============================================================*/

  dynamic userEmail = '';
  dynamic userNickname = '';

  Future<void> signInWithKakao() async {
    try {
      /* ==================== 카카오 인증 요청 ==================== */
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.http('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );

      TokenManagerProvider.instance.manager.setToken(token);

      try {
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}' // 카카오 회원 번호
            '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
            '\n이메일: ${user.kakaoAccount?.email}');
        userNickname = user.kakaoAccount?.profile?.nickname;
        userEmail = user.kakaoAccount?.email;
      } catch (error) {
        print('사용자 정보 요청 실패 $error');
      }
      final profileInfo = json.decode(response.body); // Dio
      print('카톡 로그인 성공 ${token.accessToken}');
      print(profileInfo.toString());
    } catch (error) {
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }

      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
    /* ============================================================ */

    /* ==================== 서비스 로그인 요청 ==================== */
    //
    try {
      var dio = Dio();
      var param = {
        'nickname': '$userNickname',
        'email': '$userEmail',
      };
      // 서비스 가입 여부 확인
      Response response = await dio
          .post('http://43.200.184.84:8080/api/auth/kakao', data: param);

      Login LoginResponse = Login.fromJson(response.data);
      print(LoginResponse);

      if (LoginResponse.isJoined != "false") {
        final ourAccesToken =
            json.decode(response.data['accessToken'].toString());
        // 직렬화를 이용하여 데이터를 입출력하기 위해 model.dart에 Login 정의 참고
        var val = jsonEncode(LoginResponse);

        // await storage.write(
        //   key: 'login',
        //   value: val,
        // );
        print('접속 성공!');

        Navigator.pushNamed(context, '/home');
      } else {
        print('Not found');
        Navigator.pushNamed(context, '/signin');
        //return false;
      }
    } catch (e) {
      print(e);
      //return false;
    }
    /* ============================================================ */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/logo.png",
            width: 200,
          ),
          const SizedBox(
            height: 100,
          ),
          CupertinoButton(
            onPressed: signInWithKakao,
            child: Image.asset(
              "assets/kakao_login_medium_wide.png",
            ),
          ),
        ],
      )),
    );
  }
}

// onPressed: () {
//               // Navigator.pushNamed(context, '/personal');
//             },
