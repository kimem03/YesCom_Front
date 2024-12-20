import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // JSON 인코딩/디코딩을 위해 필요
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yescom/api/api_service.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _idChecked = false;  // id 저장 확인
  bool _pwChecked = false;  // pw 저장 확인
  bool isFirstRun = true;   // 최초 실행 여부 확인

  String phone = "";    // 사용자 전화 번호
  String id = "";       // 사용자 id
  String pw = "";       // 사용자 비밀번호
  String hexPw = "";    // 비밀번호 (hexadecimal)
  String authNo = "";  // 사용자가 입력한 인증 번호
  String serverAuthNo = "";  // 서버에서 전송한 인증 번호
  String dkind = "";    // 단말기 종류 (android/ios)
  String? deviceToken = "";   // 단말기 토큰
  String? dtoken = "";        // 단말기 토큰 hexadecimal

  // String baseUrl = "http://192.168.1.88:33338/user/mobile?";

  bool isAuthNoEnabled = false;   // 인증번호 비활성화
  bool isButtonEnabled = false;   // 버튼 비활성화
  bool isPhoneEnabled = true;     // 전화번호 입력 활성화

  // 전화번호
  final TextEditingController _phoneController = TextEditingController();
  // id
  final TextEditingController _idController = TextEditingController();
  // 비밀번호
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkFirstRun();

    // 입력값 변경을 감지하여 버튼 상태를 업데이트
    _phoneController.addListener(() {
      setState(() {
        isButtonEnabled = _phoneController.text.trim().isNotEmpty;
      });
    });
  }

  // SharedPreferences 에서 최초 실행 여부를 확인
  Future<void> _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (!isFirstRun) {
      await prefs.setBool('isFirstRun', false);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _authController.dispose();
    super.dispose();
  }

  // 로그인 정보 전송
  Future<void> _sendLoginInfo() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();

    id = _idController.text.trim();
    pw = _passwordController.text.trim();
    hexPw = utf8.encode(pw).map((e) => e.toRadixString(16).padRight(2, '0')).join();

      String authLogin = "phone=$phone&id=$id&pw=$hexPw&method=login";
      String url = serverAddress + authLogin;

    try {
      // HTTP GET 요청 보내기
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("서버 응답 성공: ${response.body}");
      } else {
        print("서버 응답 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("데이터 전송 중 오류 발생: $e");
    }
  }

  // 단말기 정보 전송
  Future<void> _sendMobileInfo() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    deviceToken = await FirebaseMessaging.instance.getToken(); // 단말기 토큰
    dtoken = utf8.encode(deviceToken!).map((e) => e.toRadixString(16).padLeft(2, '0')).join();

    // 단말기 정보 (android/ios)
    if (Platform.isAndroid) {
      dkind = "1"; // Android
    } else if (Platform.isIOS) {
      dkind = "2"; // iOS
    }

    String mobile = "phone=$phone&id=$id&pw=$hexPw&method=mobileinfo&dkind=$dkind&dtoken=$dtoken";
    String url = serverAddress + mobile;

    try {
      // HTTP GET 요청 보내기
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("단말기 정보 전송 성공: ${response.body}");
        print(url);
      } else {
        print("단말기 정보 전송 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("단말기 정보 전송 중 오류 발생: $e");
    }
  }

  // 로그인, 단말기 정보 통합 핸들러 (로그인 버튼 클릭 시)
  Future<void> _handleLoginBtnPress() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();

    await _sendLoginInfo(); // 로그인 정보 전송
    await _sendMobileInfo(); // 단말기 정보 전송

    if (id.isNotEmpty && pw.isNotEmpty) {
      // 로그인 성공 시 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      // 로그인 즉시 현재 상태 요청
      String state = "phone=$phone&id=$id&pw=$hexPw&method=currentstatus";
      String stateUrl = serverAddress + state;
      try {
        // HTTP GET 요청 보내기
        final response = await http.get(Uri.parse(stateUrl));

        if (response.statusCode == 200) {
          print("전송 성공: ${response.body}");
          print(stateUrl);
        } else {
          print("전송 실패: ${response.statusCode}");
        }
      } catch (e) {
        print("오류 발생: $e");
      }

    } else {
      _showDialog("로그인 실패", "ID와 비밀번호를 입력해주세요.");
      print('$id \n $pw');
    }
  }

  // 인증번호 받기 버튼 클릭시 이벤트
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
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        setState(() {
          serverAuthNo = jsonData['Data']['AuthNo'];
          isAuthNoEnabled = true; // 인증번호 입력 창 표시
        });
        print("서버 인증번호: $serverAuthNo");
      } else {
        print("서버 응답 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("데이터 전송 중 오류 발생: $e");
      print(url);
    }
  }

  // 인증번호 컨트롤러
  final TextEditingController _authController = TextEditingController();

  // 인증하기 버튼 클릭시 이벤트
  Future<void> _handleCheckBtnPress() async {
    authNo = _authController.text.trim();

    if (authNo == serverAuthNo) {
      // print("인증 성공! 서버 인증번호와 일치합니다.");
      _showDialog("인증 성공", "인증 번호가 일치합니다.");
    } else {
      _showDialog("인증 실패", "인증 번호가 일치하지 않습니다.");
      // print("인증 실패! 입력한 인증번호가 다릅니다.");
      // print(authNo);
      // print(serverAuthNo);
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                if (title == "인증 성공") {
                  // 인증 성공 시 입력란과 버튼 비활성화
                  setState(() {
                    isAuthNoEnabled = false;
                    isButtonEnabled = false;
                    isPhoneEnabled = false;
                  });
                }
                Navigator.of(context).pop(); // Dialog 닫기
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
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
                          obscureText: true,  // 내용 감추기
                        ),

                        // 전화번호 입력 (최초 1회만)
                        isFirstRun ?
                        TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(labelText: "전화번호를 입력해주세요."),
                          keyboardType: TextInputType.phone,
                          enabled: isPhoneEnabled,
                        )
                        :
                        SizedBox(height: 30,),

                        // 인증 번호 입력란
                        isFirstRun ?
                        TextField(
                          controller: _authController,
                          decoration: InputDecoration(labelText: "인증번호를 입력해주세요."),
                          keyboardType: TextInputType.number,
                          enabled: isAuthNoEnabled,
                        )
                        :
                        SizedBox(height: 30,),
                        Text('\n'),

                        // 인증하기 버튼
                        isFirstRun ?
                        SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.9,
                          child: MaterialButton(
                            onPressed: isAuthNoEnabled
                                ? _handleCheckBtnPress
                                : null,
                            color: isAuthNoEnabled
                                ? Color.fromRGBO(0, 93, 171, 1) // 활성화 시 색상
                                : Color.fromRGBO(204, 204, 204, 0), // 비활성화 시 색상
                            disabledColor: const Color.fromRGBO(204, 204, 204, 1), // 비활성화 색상
                            child: Text('인증하기',
                              style:
                              TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                        :
                        Text('\n'),
                        Text('\n'),

                        // 인증번호 받기 버튼 (최초 1회만)
                        isFirstRun ?
                        SizedBox(
                          height: size.height * 0.06,
                          width: size.width*0.9,
                          child: MaterialButton(
                            onPressed: isButtonEnabled ? _handleAuthBtnPress : null, // 비활성화 시 null 전달
                            color: isButtonEnabled
                                ? Color.fromRGBO(0, 93, 171, 1) // 활성화 시 색상
                                : Color.fromRGBO(204, 204, 204, 0), // 비활성화 시 색상
                            disabledColor: const Color.fromRGBO(204, 204, 204, 1), // 비활성화 색상
                            child: Text('인증번호 받기', style:
                            TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),),
                          )
                        )
                        :
                        Text('\n'),
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
                                if(_idChecked == true) {
                                } else {
                                }
                              },
                              activeColor: Color.fromRGBO(0, 93, 171, 1),

                            ),
                            Text('ID 저장하기', style: TextStyle(fontSize: 18),),

                            Checkbox(
                                value: _pwChecked,
                                onChanged: (bool? value){
                                  setState(() {
                                    _pwChecked = value!;
                                  });
                                  if(_pwChecked == true) {
                                  } else {
                                  }
                                },
                              activeColor: Color.fromRGBO(0, 93, 171, 1),
                            ),
                            Text('PW 저장하기', style: TextStyle(fontSize: 18),),
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
