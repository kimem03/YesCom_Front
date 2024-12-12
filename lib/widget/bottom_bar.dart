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
          ElevatedButton(
              onPressed: (){}
              , child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/slice/tab_on.png', width: 150,),
                Image.asset('assets/slice/home_on.png', width: 150,)
              ]
            )
          ),
          ElevatedButton(
              onPressed: (){}
              , child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/slice/tab_off.png', width: 150,),
                  Image.asset('assets/slice/bell_off.png', width: 150,)
                ]
            )
          ),
        ],
      ),
    );
  }
}
