import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/api_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String phone = "";    // 사용자 전화 번호
  String id = "";       // 사용자 id
  String pw = "";       // 사용자 비밀번호
  String authNo = "";  // 사용자가 입력한 인증 번호
  String serverAuthNo = "";  // 서버에서 전송한 인증 번호
  String url = "";
  String baseUrl = "http://192.168.1.88:33338/user/mobile?";

  // 인증번호
  final TextEditingController _authController = TextEditingController();

  Future<void> fetchAuthData() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();
    String authPhone = "phone=$phone&id=&pw=&method=auth";

    url = baseUrl + authPhone;

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
      print(url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("인증 실패!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
          children: [
            // 인증 번호 입력란
            TextField(
              controller: _authController,
              decoration: InputDecoration(labelText: "인증번호를 입력해주세요."),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30,),

            // 인증 버튼
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.9,
              child: MaterialButton(
                onPressed: _handleCheckBtnPress,
                color: Color.fromRGBO(0, 93, 171, 1),
                child: Text('확인',
                  style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Text('\n'),
          ],
      );
  }
}

