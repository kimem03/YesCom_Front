import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/widget/appbar.dart';
import 'package:yescom/widget/login_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
                      labelStyle: TextStyle(color: Colors.teal, fontSize: 15))),
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: "ID를 입력해주세요"),
                            keyboardType: TextInputType.text,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: "비밀번호를 입력해주세요"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          SizedBox(height: 40,),
                          ButtonTheme(
                            minWidth: 100,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: (){

                                },
                                child: Text(
                                    '로그인', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                  ),
                                ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent
                              )
                            ),
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
