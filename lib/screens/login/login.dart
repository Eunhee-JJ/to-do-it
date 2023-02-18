import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/personal');
            },
            child: Image.asset(
              "assets/kakao_login_medium_wide.png",
            ),
          ),
        ],
      )),
    );
  }
}
