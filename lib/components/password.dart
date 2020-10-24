import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key key,
    @required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: true,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.white),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
