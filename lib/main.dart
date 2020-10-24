import 'package:flutter/material.dart';
// import 'package:user_login_session/home_page.dart';
import 'package:user_login_session/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Session App',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
// HomePage()
