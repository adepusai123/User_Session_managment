import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function press;
  final String labelText;
  final Color color;
  const Button({
    Key key,
    this.press,
    this.labelText,
    this.color,
  });

// Colors.deepPurple[300]
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(),
      child: RaisedButton(
        color: color,
        onPressed: press,
        child: Text(
          labelText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
