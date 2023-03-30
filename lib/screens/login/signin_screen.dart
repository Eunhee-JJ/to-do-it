import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  State<StatefulWidget> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text("본인인증이 필요합니다."),
                TextField(),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'home'),
                  child: Text("인증"),
                ),
              ],
            ),
          ),
          Expanded(flex: 5, child: SizedBox()),
        ],
      )),
    );
  }
}
