import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomModal extends StatefulWidget {
  const BottomModal({super.key});

  @override
  State<StatefulWidget> createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 30, right: 20, top: 15, bottom: 10),
          child: ListTile(
            leading: Icon(
              CupertinoIcons.chevron_down,
              color: CupertinoColors.activeBlue,
            ),
            onTap: () => Navigator.pop(context),
            title: Text(
              '전체 할 일 목록()',
              style: TextStyle(
                fontSize: 21,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 248, 248, 248),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  offset: Offset(0, -1),
                  blurRadius: 6,
                )
              ])),
    );
  }
}
