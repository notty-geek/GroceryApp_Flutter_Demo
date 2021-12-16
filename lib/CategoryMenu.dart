import 'package:flutter/material.dart';

class CategoryMenu extends StatefulWidget {
  @override
  _CategoryMenu createState() => new _CategoryMenu();
}

class _CategoryMenu extends State<CategoryMenu> {

  String dropdownValue = "Snacks & Drinks";


  @override
  Widget build(BuildContext context){
    return new DropdownButtonHideUnderline(child:
    new DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Snacks & Drinks'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        );
      }).toList(),
    ));
  }

}