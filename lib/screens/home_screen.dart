import 'package:flutter/cupertino.dart';
import 'package:todoit/screens/friends/friends_screen.dart';
import 'package:todoit/screens/personal/personal_screen.dart';

import 'challenges/challenges_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.hand_thumbsup)),
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: items,
        border: null,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return FriendsScreen();
                break;
              case 1:
                return PersonalScreen();
                break;
              case 2:
                return ChallengesScreen();
                break;
              default:
                return PersonalScreen();
                break;
            }
          },
        );
      },
    );
  }
}
