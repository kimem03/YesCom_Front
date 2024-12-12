import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/screen/main_screen.dart';
import 'package:yescom/widget/appbar.dart';
import 'package:yescom/widget/login_app_bar.dart';

import '../page/main_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class Routes {
  Routes._();

  static const String login_screen = "/login_screen";
  static const String main_screen = "/main_screen";
  static const String main_page = "./page/main_page";

  static final routes = <String, WidgetBuilder>{
    login_screen: (BuildContext context) => LoginScreen(),
    main_screen: (BuildContext context) => MainScreen(),
    main_page: (BuildContext context) => MainPage(),
  };
}

class _LoginScreenState extends State<LoginScreen> {
  // 전화번호
  final TextEditingController _phoneController = TextEditingController();
  // id
  final TextEditingController _idController = TextEditingController();
  // 비밀번호
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _phoneController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _handleAuthBtnPress(){
    // 전화 번호 미입력
    if(_phoneController.text.isEmpty){
      return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('오류'),
            content: const Text('전화번호를 입력하세요.'),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.pop(context, 'OK'), child: const Text('OK'))
            ],
          )
      );
    }
  }

  _handleLoginBtnPress(){
    // 아이디 비밀번호
    if(_phoneController.text.isEmpty){
      return Text('아이디와 비밀번호를 확인해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: LoginAppBar(),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 30)),
          Form(
              child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.grey,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 15))),

                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            key: Key('ID'),
                            decoration: InputDecoration(labelText: "ID를 입력해주세요"),
                            keyboardType: TextInputType.text,
                          ),
                          TextField(
                            key: Key('password'),
                            decoration: InputDecoration(labelText: "비밀번호를 입력해주세요"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          TextField(
                            key: Key('phone'),
                            decoration: InputDecoration(labelText: "전화번호를 입력해주세요"),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 40,),

                          SizedBox(
                            height: size.height * 0.06,
                            width: size.width*0.9,
                            child: MaterialButton(
                              onPressed: (){  // 문자 인증 쿼리
                              },
                              color: Colors.blueAccent,
                              child: Text('인증하기', style:
                              TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),),
                            ),
                          ),
Text('\n'),
                          SizedBox(
                          height: size.height * 0.06,
                          width: size.width*0.9,
                              child: MaterialButton(
                              onPressed: (){ // 로그인 후 이동으로 변경 해야함
                                Navigator.of(context).pushNamed(Routes.main_page);
                              },
                            color: Colors.blueAccent,
                            child: Text('로그인', style:
                              TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),),
                          )),
                          Text(' \n'),
                          Row(
                            children: [
                              MaterialButton(
                                  onPressed: () => {
                                    Image.asset('assets/slice/check_on.png')
                                  },
                                child: Image.asset('assets/slice/check_off.png'),
                              ),
                              Text('ID 저장'),
                              MaterialButton(
                                onPressed: () => {
                                  Image.asset('assets/slice/check_on.png')
                                },
                                child: Image.asset('assets/slice/check_off.png'),
                              ),
                              Text('비밀번호 저장'),
                            ],
                          )

                        ],
                      ),
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
