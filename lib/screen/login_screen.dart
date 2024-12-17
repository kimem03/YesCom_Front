import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // JSON 인코딩/디코딩을 위해 필요
import 'package:http/http.dart' as http;
import 'package:yescom/api/api_service.dart';
import 'package:yescom/screen/phone_auth_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _idChecked = false;
  bool _pwChecked = false;

  String phone = "";    // 사용자 전화 번호
  String id = "";       // 사용자 id
  String pw = "";       // 사용자 비밀번호
  String authNo = "";  // 사용자가 입력한 인증 번호
  String serverAuthNo = "";  // 서버에서 전송한 인증 번호
  // String baseUrl = "http://192.168.1.88:33338/user/mobile?";

  // 전화번호
  final TextEditingController _phoneController = TextEditingController();
  bool isButtonEnabled = false;   // 버튼 비활성화
  // id
  final TextEditingController _idController = TextEditingController();
  // 비밀번호
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 입력값 변경을 감지하여 버튼 상태를 업데이트
    _phoneController.addListener(() {
      setState(() {
        isButtonEnabled = _phoneController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // 로그인 버튼 클릭시 이벤트
  Future<void> _handleLoginBtnPress() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();

    id = _idController.text.trim();
    pw = _passwordController.text.trim();

    String authLogin = "phone=$phone&id=$id&pw=$pw&method=login";
    String url = serverAddress + authLogin;

    try {
      // HTTP GET 요청 보내기
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("서버 응답 성공: ${response.body}");
        print(url);
      } else {
        print("서버 응답 실패: ${response.statusCode}");
        print(url);
      }
    } catch (e) {
      print("데이터 전송 중 오류 발생: $e");
      print(url);
    }

      // 통신 구현 되면 Replacement 로 변경
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) => new HomeScreen())
      );
  }

  // 인증하기 버튼 클릭시 이벤트
  Future<void> _handleAuthBtnPress() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();

    phone = _phoneController.text.trim();
    String authPhone = "phone=$phone&id=&pw=&method=auth";

    String url = serverAddress + authPhone;

    try {
      // HTTP GET 요청 보내기
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("서버 응답 성공: ${response.body}");
        print(url);
      } else {
        print("서버 응답 실패: ${response.statusCode}");
        print(url);
      }
    } catch (e) {
      print("데이터 전송 중 오류 발생: $e");
      print(url);
    }
  }

  // 인증번호
  final TextEditingController _authController = TextEditingController();

  Future<void> fetchAuthData() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();
    String authPhone = "phone=$phone&id=&pw=&method=auth";

    String url = serverAddress + authPhone;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "request": "getAuthNo",
          "phone": phone // 예시 전화번호, 필요 시 변수로 대체
        }),
      );

      if (response.statusCode == 200) {
        // 응답 데이터(JSON)를 파싱
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print("서버 응답: $jsonData");

        // JSON에서 AuthNo 값 추출
        setState(() {
          serverAuthNo = jsonData['Data']['AuthNo'];
        });
        print("서버 인증번호: $serverAuthNo");
      } else {
        print("서버 요청 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("오류 발생: $e");
    }
  }

  void _handleCheckBtnPress() {
    authNo = _authController.text.trim();
    if (authNo == serverAuthNo) {
      print("인증 성공! 서버 인증번호와 일치합니다.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("인증 성공!")),
      );
    } else {
      print("인증 실패! 입력한 인증번호가 다릅니다.");
      print(authNo);
      print(serverAuthNo);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("인증 실패!")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // 입력란
    var input = GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
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
                    child: Column(
                      children: [
                        // 아이디 입력
                        TextField(
                          controller: _idController,
                          decoration: InputDecoration(
                            labelText: "ID를 입력해주세요.",
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        // 비밀번호 입력
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: "비밀번호를 입력해주세요."),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),

                        // 전화번호 입력 (최초 1회만)
                        TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(labelText: "전화번호를 입력해주세요."),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 30,),

                        // 인증번호 입력 및 비교 화면
                        PhoneAuthScreen(),

                        // 인증 버튼 (최초 1회만)
                        SizedBox(
                          height: size.height * 0.06,
                          width: size.width*0.9,
                          child: MaterialButton(
                            onPressed: isButtonEnabled ? _handleAuthBtnPress : null, // 비활성화 시 null 전달
                            color: isButtonEnabled
                                ? Color.fromRGBO(0, 93, 171, 1) // 활성화 시 색상
                                : Color.fromRGBO(204, 204, 204, 0), // 비활성화 시 색상
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
                              onPressed: (){  _handleLoginBtnPress(); },
                              color: Color.fromRGBO(0, 93, 171, 1),
                              child: Text('로그인', style:
                              TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),),
                            )),

                        // ID, PW 저장
                        Row(
                          children: [
                            Checkbox(
                              value: _idChecked,
                              onChanged: (bool? value){
                                setState(() {
                                  _idChecked = value!;
                                });
                              },
                              activeColor: Color.fromRGBO(0, 93, 171, 1),

                            ),
                            Text('id 저장하기', style: TextStyle(fontSize: 18),),

                            Checkbox(
                                value: _pwChecked,
                                onChanged: (bool? value){
                                  setState(() {
                                    _pwChecked = value!;
                                  });
                                },
                              activeColor: Color.fromRGBO(0, 93, 171, 1),
                            ),
                            Text('pw 저장하기', style: TextStyle(fontSize: 18),),
                          ],
                        )
                      ],
                    ),
                  ),
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
