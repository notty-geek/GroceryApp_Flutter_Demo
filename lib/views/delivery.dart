import 'package:flutter/material.dart';
import 'package:groceryapptesting/views/orders.dart';

class DeliveryPage extends StatefulWidget {

  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final formKey = new GlobalKey<FormState>();

  String email, full_name,address,pincode;

  Color greenColor = Color(0xFF00AF19);


  //To check fields during submiat
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildDeliveryForm())));
  }

  _buildDeliveryForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Delivery Details',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                  //Dot placement
                ],
              )),
          SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.full_name = value;
              },
              validator: (value) =>
              value.isEmpty ? 'Full Name is required' : null),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.address = value;
              },
              validator: (value) =>
              value.isEmpty ? 'Address is required' : null),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
              value.isEmpty ? 'Email is required' : validateEmail(value)),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Pincode',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.pincode = value;
              },
              validator: (value) =>
              value.isEmpty ? 'Pincode is required' : null),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {

              if (checkFields()) {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderView()),
              );
              }
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('Create Order',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: greenColor,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }
}