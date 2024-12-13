import 'package:flutter/material.dart';
import 'package:yescom/screen/bell_screen.dart';
import 'package:yescom/screen/login_screen.dart';
import 'package:yescom/screen/main_screen.dart';
import 'package:yescom/widget/appbar.dart';

class Routes {
  Routes._();

  static const String login_screen = "/login_screen";
  static const String main_screen = "/main_screen";

  static final routes = <String, WidgetBuilder>{
  login_screen: (BuildContext context) => LoginScreen(),
  main_screen: (BuildContext context) => MainScreen(),
  };
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white, // 기본 색상
          )),
      // 실행 시 첫 화면은 로그인
      home: LoginScreen(),
    );
  }
}

