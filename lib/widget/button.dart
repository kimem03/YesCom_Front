import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
              onPressed: (){},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/slice/btn_3.png'),
                  Text('경계')
                ],
              ),
          ),
          Text(' '),
          TextButton(
            onPressed: (){},
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/slice/btn_3.png'),
                Text('해제')
              ],
            ),
          ),
          Text(' '),
          TextButton(
            onPressed: (){},
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/slice/btn_3.png'),
                Text('문열림')
              ],
            ),
          ),
        ]
      ),
    );
  }
}