import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/widget/appbar.dart';
import 'package:http/http.dart' as http;

import '../api/api_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String phone = "";    // 사용자 전화 번호
  String id = "";       // 사용자 id
  String pw = "";       // 사용자 비밀번호
  String hexPw = "";    // 비밀번호 (hexadecimal)
  String custId = "";   // 관리번호
  String hexCustName = "";  // 관리명 hexadecimal
  String custName = "";     // 관리명 decode

  Future<void> _getStateInfo() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();

    String state = "phone=$phone&id=$id&pw=$hexPw&method=currentstatus";
    String stateUrl = serverAddress + state;

    try {
      final response = await http.get(Uri.parse(stateUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
      }
    } catch (e) {
    }
  }

  // 드롭 다운 기본값
  String dropdownValue = "";
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Image _image = Image.asset('assets/slice/_Reset.png', width: size.width*0.5,);

    // 상단 바, 드롭 다운
    var top = SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Appbar(),
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildArea(),
                  ],
                ),
              ),
            )
        )
    );

    // 중앙
    var center = Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/slice/bg_lock.png',
            height: 600,
            width: size.width,
          fit: BoxFit.contain,),
          Positioned(
            top: 10,
            child: Text.rich(
              TextSpan(
                text: "현재 ",
                children: [
                  TextSpan(
                    text: "해제 ",
                    style: TextStyle(color: Colors.green),
                    children: [
                      TextSpan(
                        text: "상태 입니다.",
                        style: TextStyle(color: Colors.black)
                      ),
                    ],
                  ),
                ],
              ),
              style: TextStyle(fontSize: 25),
            ),
          ),
          Positioned(
            bottom: 0,
            child: _image,
          )
        ],
      ),
    );

    // 버튼 (경계, 해제, 문열림)
    var button = btn();

    // 배너
    var banner = Container(
      margin: EdgeInsets.fromLTRB(0, size.height*0.06, 0, 0),
      child: Scaffold(
        body: Image.asset('assets/slice/banner.png',
        fit: BoxFit.fitWidth,
        width: double.infinity,),
      ),
    );

    // 전체 결과값 출력
    return MaterialApp(
      home: Column(
        children: [
          Expanded(flex: 1, child: top,),
          Expanded(flex: 1, child: center,),
          Expanded(flex: 1, child: button,),
          Expanded(flex: 1, child: banner,),
          // Expanded(flex: 1, child: navBar,),
        ],
      ),
    );
  }
  // 드롭 다운 요소
  Widget _buildArea() {
    List<String> dropdownList = ['서한1', '서한2'];
    if(dropdownValue == ""){
      dropdownValue = dropdownList.first;
    }
    return DropdownButton(
      value: dropdownValue,
      items: dropdownList.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value)
        );
      }).toList()
      , onChanged: (String? value) {
      setState(() {
        dropdownValue = value!;
        print(value);
      });
    },);
  }
}

// 버튼 스타일 및 다이얼로그 쿼리
class btn extends StatelessWidget{
  const btn({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // 경계
    var lock = MaterialButton(
      onPressed: (){_showLockDialog(context);},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/slice/btn_3.png'),
          Text('경계', style: TextStyle(
              fontSize: 18
          ),),
        ],
      ),
    );

    // 해제
    var unlock = MaterialButton(
      onPressed: (){_showUnlockDialog(context);},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/slice/btn_3.png'),
          Text('해제', style: TextStyle(
              fontSize: 18
          ),)
        ],
      ),
    );

    // 문열림
    var open = MaterialButton(
      onPressed: (){_showOpenDialog(context);},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/slice/btn_3.png'),
          Text('문열림', style: TextStyle(
              fontSize: 18
          ),)
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: lock,
          ),
          Expanded(
            child: unlock,
          ),
          Expanded(
            child: open,
          ),
        ],
      ),
    );
  }

  // 경계 다이얼로그
  Future<dynamic> _showLockDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('경계'),
          content: Text('경계 모드로 전환 하겠습니까?'),
          actions: [
            TextButton(
                onPressed: () => {
                  Navigator.of(context).pop(),
                  Image.asset('assets/slice/_Set.png'),
                  Text('경계', style: TextStyle(color: Colors.red),)
                },
                child: Text('예')
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('아니오')
            ),
          ],
        )
    );
  }

  // 해제 다이얼로그
  Future<dynamic> _showUnlockDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('해제'),
          content: Text('해제 모드로 전환 하겠습니까?'),
          actions: [
            TextButton(
                onPressed: () => {
                  Navigator.of(context).pop(),
                  Image.asset('assets/slice/_Reset.png'),
                  Text('해제', style: TextStyle(color: Colors.green),)
                },
                child: Text('예')
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('아니오')
            ),
          ],
        )
    );
  }

  // 문열림 다이얼로그
  Future<dynamic> _showOpenDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('문열림'),
          content: Text('문을 열겠습니까?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('예')
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('아니오')
            ),
          ],
        )
    );
  }
}
// 버튼 쿼리 끝