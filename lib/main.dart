import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoit/providers/challenge_provider.dart';
import 'package:todoit/providers/friend_provider.dart';
import 'package:todoit/providers/todo_provider.dart';
import 'package:todoit/providers/user_provider.dart';
import 'package:todoit/screens/challenges/challenges_screen.dart';
import 'package:todoit/screens/login/login_screen.dart';
import 'package:todoit/screens/home_screen.dart';
import 'package:todoit/screens/login/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '7aeec4d4d11ac84983c56eb24b78f6ef',
    // javaScriptAppKey: '${YOUR_JAVASCRIPT_APP_KEY}',
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => TodoProvider()),
      ChangeNotifierProvider(create: (_) => ChallengeProvider()),
      ChangeNotifierProvider(create: (_) => FriendProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      title: 'To Do It',
      theme: CupertinoThemeData(brightness: Brightness.light),
      routes: {
        '/': (context) => CupertinoScaffold(
              body: LoginScreen(),
              //body: HomeScreen(),
            ),
        '/home': (context) => CupertinoScaffold(body: HomeScreen()),
        '/login': (context) => CupertinoScaffold(body: LoginScreen()),
        '/signin': (context) => CupertinoScaffold(body: SigninScreen()),
        '/challenge': (context) => CupertinoScaffold(body: ChallengesScreen()),
      },
    );
  }
}
