import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/widget/appbar.dart';
import 'package:yescom/widget/bottom_bar.dart';
import 'package:yescom/widget/button.dart';
import 'package:yescom/widget/dropdown.dart';

import 'login_screen.dart';

class Routes {
  Routes._();

  static const String login_screen = "/login_screen";
  static const String main_screen = "/main_screen";

  static final routes = <String, WidgetBuilder>{
    login_screen: (BuildContext context) => LoginScreen(),
    main_screen: (BuildContext context) => MainScreen(),
  };
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    var top = SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.inactiveGray,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Appbar(),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          width: double.infinity,
          height: double.infinity,
          child: DropDown(),
        ),
      ),
    );

    var content = Scaffold(
      body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/slice/bg_lock.png',
              fit: BoxFit.fitWidth,
              width: double.infinity,),
            Image.asset('assets/slice/lock_off.png', height: size.height*0.8,),
          ]
      ),
    );

    var btn = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(size.width * 0.05, 0, size.width * 0.01, 0),
      child: Scaffold(
        body: Button(),
      ),
    );

    var banner = Container(
      margin: EdgeInsets.fromLTRB(0, size.height * 0.12, 0, 0),
      child: Scaffold(
        body: Image.asset(
          'assets/slice/banner.png',
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
      ),
    );

    var bottom = Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          body: BottomBar(),
        )
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: top,
          ),
          Expanded(
            flex: 1,
            child: content,
          ),
          Expanded(
            flex: 1,
            child: btn,
          ),
          Expanded(
            flex: 2,
            child: banner,
          ),
          Expanded(
            flex: 1,
            child: bottom,
          ),
        ],
      ),
    );
  }
}