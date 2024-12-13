import 'package:flutter/cupertino.dart';
import 'package:yescom/screen/bell_screen.dart';

import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import '../screen/main_screen.dart';

class Routes {
  Routes._();

  static const String login_screen = "../screen/login_screen";
  static const String main_screen = "../screen/main_screen";
  static const String bell_screen = "../screen/bell_page";
  static const String home_screen = "../screen/home_screen";

  static final routes = <String, WidgetBuilder>{
    login_screen: (BuildContext context) => LoginScreen(),
    main_screen: (BuildContext context) => MainScreen(),
    bell_screen: (BuildContext context) => BellScreen(),
    home_screen: (BuildContext context) => HomeScreen(),
  };
}