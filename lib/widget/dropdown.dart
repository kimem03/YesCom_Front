import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = "서한1";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildArea(),
                ],
              ),
            )
        ),
      ),
    );
  }
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
