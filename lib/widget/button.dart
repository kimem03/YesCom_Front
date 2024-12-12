import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: btn(),
      ),
    );
  }
}

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