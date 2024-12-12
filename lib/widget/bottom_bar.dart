import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
              onPressed: (){}
              , child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/slice/tab_off.png',),
                Image.asset('assets/slice/bell_off.png',)
              ]
          )
          ),)

        ],
      ),
    );
  }
}
