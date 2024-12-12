import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/widget/appbar.dart';
import 'package:yescom/widget/bottom_bar.dart';
import 'package:yescom/widget/button.dart';
import 'package:yescom/widget/dropdown.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var top = SafeArea(
        child: Scaffold(
          backgroundColor: CupertinoColors.inactiveGray,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Appbar(),
          ),
          body: Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: double.infinity,
            child: DropDown(),
          ),
        ),
    );
    
    var content = Scaffold(
      body: Stack(
        alignment: Alignment.center,
          children: [
            Image.asset('assets/slice/bg_lock.png',
              fit: BoxFit.fitWidth,
              width: double.infinity,),
            Image.asset('assets/slice/lock_off.png', height: 180,),
          ]
      ),
    );

    var btn = SafeArea(
        child: Scaffold(
          body: Button(),
        ),
    );

    var banner = SafeArea(
      child: Scaffold(
        body: Image.asset(
          'assets/slice/banner.png',
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
      ),
    );

    var bottom = SafeArea(
        child: Scaffold(
          body: BottomBar(),
        )
    );
    
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: top,
          ),
          Expanded(
            flex: 1,
            child: content,
          ),
          Expanded(
          flex: 3,
          child: btn,
          ),
          Expanded(
          flex: 1,
          child: banner,
          ),
          Expanded(
            flex: 1,
            child: bottom,
          ),
        ],
      ),
    );
  }
}