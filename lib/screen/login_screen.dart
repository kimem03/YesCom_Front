import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/main.dart';
import 'package:yescom/screen/bell_screen.dart';
import 'package:yescom/screen/main_screen.dart';
import 'package:yescom/widget/appbar.dart';
import 'package:yescom/widget/login_app_bar.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 전화번호
  final TextEditingController _phoneController = TextEditingController();
  // id
  final TextEditingController _idController = TextEditingController();
  // 비밀번호
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _handleAuthBtnPress() {
    // 전화 번호 미입력
    if (_phoneController.text.isEmpty) {
      return showDialog(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('오류'),
                content: const Text('전화번호를 입력하세요.'),
                actions: <Widget>[
                  TextButton(onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'))
                ],
              )
      );
    }
  }

  _handleLoginBtnPress() {
    // 아이디 비밀번호
    if (_phoneController.text.isEmpty) {
      return Text('아이디와 비밀번호를 확인해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Image img = Image.asset('assets/slice/check_off.png');
    
    // 입력란
    var input = Scaffold(
      body: SingleChildScrollView(child:
      Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 30)),
        Form(
            child: Theme(
                data: ThemeData(
                  primaryColor: Colors.grey,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(fontSize: 15, color: Colors.grey))),
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // 아이디 입력
                        TextField(
                          decoration: InputDecoration(labelText: "ID를 입력해주세요."),
                          keyboardType: TextInputType.text,
                        ),
                        // 비밀번호 입력
                        TextField(
                          decoration: InputDecoration(labelText: "비밀번호를 입력해주세요."),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),

                        // 전화번호 입력 (최초 1회만)
                        TextField(
                          decoration: InputDecoration(labelText: "전화번호를 입력해주세요."),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 30,),

                        // 인증 버튼 (최초 1회만)
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
                          )
                        ),
                        Text('\n'),

                        // 로그인 버튼
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width*0.9,
                            child: MaterialButton(
                              onPressed: (){ // 로그인 후 이동으로 변경 해야함
                                // 통신 구현되면 Replacement 로 변경
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (context) => new HomeScreen())
                                );
                              },
                              color: Colors.blueAccent,
                              child: Text('로그인', style:
                              TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),),
                            )),

                        // ID, PW 저장
                        Row(
                          children: [
                            InkWell(
                              onTap: () => {
                                if (img == Image.asset('assets/slice/check_off.png')){
                                  img = Image.asset('assets/slice/check_on.png')
                                } else {
                                  img = Image.asset('assets/slice/check_off.png')
                                }
                              },
                              child: MaterialButton(
                                onPressed: () => {  // id 저장 및 체크 표시 쿼리
                                },
                                key: Key('savedId'),
                                child: img = Image.asset('assets/slice/check_off.png',
                                  height: 30, width: 30,),
                              ),
                            ),
                            Text('ID 저장', style: TextStyle(fontSize: 17),),

                            MaterialButton(
                              onPressed: () => {  // pw 저장 및 체크 표시 쿼리
                              },
                              key: Key('savedPw'),
                              child: Image.asset('assets/slice/check_off.png',
                                height: 30, width: 30,),
                            ),
                            Text('PW 저장', style: TextStyle(fontSize: 17),),

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
      ),
    );


    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: Image.asset('assets/slice/login_logo.png'),
            ),
          ),
        ),
        body: input,
      ),
    );
  }
}
