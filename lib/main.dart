import 'package:flutter/material.dart';
import 'package:yescom/page/bell_page.dart';
import 'package:yescom/page/main_page.dart';
import 'package:yescom/screen/login_screen.dart';
import 'package:yescom/screen/main_screen.dart';

class Routes {
  Routes._();

  static const String login_screen = "/login_screen";
  static const String main_screen = "/main_screen";
  static const String main_page = "/main_page";
  static const String bell_page = "/bell_page";

  static final routes = <String, WidgetBuilder>{
  login_screen: (BuildContext context) => LoginScreen(),
  main_screen: (BuildContext context) => MainScreen(),
  main_page: (BuildContext context) => MainPage(),
  bell_page: (BuildContext context) => BellPage(),
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
      home: LoginScreen(),
      routes: Routes.routes,
    );
  }
}
