import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/appbar.dart';

class BellPage extends StatefulWidget {
  const BellPage({super.key});

  @override
  State<BellPage> createState() => _BellPageState();
}

class _BellPageState extends State<BellPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Appbar(),
        ),
      ),
    );
  }
}
