import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yescom/api/routes.dart';

import '../widget/appbar.dart';
import 'login_screen.dart';
import 'main_screen.dart';


class BellScreen extends StatefulWidget {
  const BellScreen({super.key});

  @override
  State<BellScreen> createState() => _BellScreenState();
}

class _BellScreenState extends State<BellScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // 상단 바
    var top = SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height*0.06),
            child: Appbar(),
          ),
      )
    );

    // 알림 내용
    var list = Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: DataTable(
        columns: const [
          DataColumn(label: Text('사용자')),
          DataColumn(label: Text('일자')),
          DataColumn(label: Text('시간')),
          DataColumn(label: Text('신호')),
        ],
        rows: const [
          // DataRow(cells: [
          //   DataCell(Text('홍길동')),
          //   DataCell(Text('2024.12.13')),
          //   DataCell(Text('14:01:12')),
          //   DataCell(Text('해제', style: TextStyle(
          //     color: Colors.red
          //   ),)),
          // ]),
        ],
      ),
    ),
    ),
    );

    return MaterialApp(
      home: Column(
        children: [
          Expanded(flex: 2, child: top,),
          Expanded(flex: 2, child: list,),
          // Expanded(flex: 1, child: navBar,),
        ],
      ),
    );
  }
}