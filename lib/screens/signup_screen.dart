import 'package:flutter/material.dart';
import 'package:user_login_session/components/button_component.dart';
import 'package:user_login_session/components/custom_input.dart';
import 'package:user_login_session/components/password.dart';
import 'package:user_login_session/login_page.dart';
import 'package:user_login_session/services/api_manager.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _pwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.deepPurple[100]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView(
          children: [
            pageTitle(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                children: [
                  CustomInputField(
                    controller: _emailCtrl,
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordField(controller: _pwdCtrl),
                ],
              ),
            ),
            Button(
              labelText: 'Sign Up',
              color: Colors.deepPurple,
              press: () async {
                if (_emailCtrl.text != null && _pwdCtrl.text != null) {
                  Map response =
                      await APIManager().signUp(_emailCtrl.text, _pwdCtrl.text);
                  if (response['id'] != null) {
                    // pop here Signed up successfully
                    setState(() {
                      _emailCtrl.clear();
                      _pwdCtrl.clear();
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }),
                    );
                  }
                }
              },
            ),
            Button(
              labelText: 'Login',
              color: Colors.deepPurple[300],
              press: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Center pageTitle() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Text(
          "User Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
