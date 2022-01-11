import 'package:flutter/material.dart';

class CommonAppButton extends StatelessWidget {
  const CommonAppButton({Key key, this.onTap, this.buttonText})
      : super(key: key);

  final Function onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: RaisedButton(
          color: Colors.amber,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          padding: EdgeInsets.all(20),
          onPressed: onTap,
          child: new Text(buttonText,
              style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
