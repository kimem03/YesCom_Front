import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
      //   decoration: BoxDecoration(
      //   color: Colors.white,
      // ),
      children: [
        Image.asset('assets/slice/top_bg.png'),
        Image.asset('assets/slice/top_logo02.png', width: 190,)
      ]
    ),
    );
  }
}
