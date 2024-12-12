import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/page/bell_page.dart';

import '../screen/login_screen.dart';
import '../screen/main_screen.dart';
import '../widget/appbar.dart';

class Routes {
  Routes._();

  static const String login_screen = "./screen/login_screen";
  static const String main_screen = "./screen/main_screen";
  static const String bell_page = "/bell_page";

  static final routes = <String, WidgetBuilder>{
    login_screen: (BuildContext context) => LoginScreen(),
    main_screen: (BuildContext context) => MainScreen(),
    bell_page: (BuildContext context) => BellPage(),
  };
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 드롭 다운 기본값
  String dropdownValue = "서한1";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // 상단 바, 드롭 다운
    var dropdown = SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Appbar(),
            ),
          body: MaterialApp(
            home: Center(
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


    // 사진
    var content = Scaffold(
      body: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/slice/bg_lock.png',
          fit: BoxFit.fitWidth,
          width: double.infinity,),
        Image.asset('assets/slice/lock_off.png', height: size.height*0.8,),
        ],
      ),
    );

    // 버튼 (경계, 해제, 문열림)
    var button = btn();

    // 배너
    var banner = Container(
      margin: EdgeInsets.fromLTRB(0, size.height * 0.12, 0, 0),
      child: Scaffold(
        body: Image.asset(
          'assets/slice/banner.png',
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
      ),
    );

    // 하단 내비바
    var bottomNavBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: (){}
            , child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/slice/tab_on.png',),
                Image.asset('assets/slice/home_on.png',),
              ]
          ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed(Routes.bell_page);
              }
              , child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/slice/tab_off.png',),
                Image.asset('assets/slice/bell_off.png',)
              ]
          )
          ),)
      ],
    );


    // 전체 화면 출력
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: dropdown),
          Expanded(flex: 1, child: content),
          Expanded(flex: 1, child: button),
          Expanded(flex: 2, child: banner),
          Expanded(flex: 1, child: bottomNavBar),
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
                },
                child: Text('ㅇㅇ')
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ㄴㄴ')
            ),
          ],
        )
    );
  }

  Future<dynamic> _showUnlockDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('해제'),
          content: Text('해제 모드로 전환 하겠습니까?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ㅇㅇ')
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ㄴㄴ')
            ),
          ],
        )
    );
  }

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
                child: Text('ㅇㅇ')
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ㄴㄴ')
            ),
          ],
        )
    );
  }
}
// 버튼 쿼리 끝