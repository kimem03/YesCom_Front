import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';
import 'bell_screen.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() =>  _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String phone = "";    // 사용자 전화 번호
  String id = "";       // 사용자 id
  String hexPw = "";    // 비밀번호 (hexadecimal)


  // 원격 요청 이벤트
  Future<void> _handleRemoteBtnPress() async {
    ApiService apiService = ApiService();
    String serverAddress = await apiService.loadServerAddress();

  }

  int _currentIndex = 0;

  final List<Widget> _pages = [MainScreen(), BellScreen()];

  void _onItemTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/slice/home_on.png'),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/slice/bell_on.png'),
            label: '알림',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white, backgroundColor: Color.fromRGBO(0, 93, 171, 1),
        unselectedItemColor: Color.fromRGBO(204, 204, 204, 0),
        onTap: _onItemTapped,
      ),
    );

    throw UnimplementedError();
  }
}
