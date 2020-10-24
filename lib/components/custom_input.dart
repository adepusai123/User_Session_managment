import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  // final TextEditingController controller;
  const CustomInputField({
    Key key,
    @required TextEditingController controller,
    this.hintText,
    // this.controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
