import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:todoit/screens/login/login_screen.dart';
import 'package:todoit/screens/personal/personal_screen.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '7e83021145d33eb03992d460963a2026',
    // javaScriptAppKey: '${YOUR_JAVASCRIPT_APP_KEY}',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'To Do It',
      theme: CupertinoThemeData(brightness: Brightness.light),
      routes: {
        '/': (context) => LoginScreen(),
        '/personal': (context) => PersonalScreen(),
      },
    );
  }
}
