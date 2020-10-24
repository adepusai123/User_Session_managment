import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_login_session/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _pwdCtrl = TextEditingController();
  bool _isLoading = false;

  Future signin(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': password};
    dynamic jsonResponse = {};
    try {
      var response =
          await http.post('http://192.168.1.100:3000', headers: {}, body: data);
      print('-------Valid Response : ${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        String jsonString = response.body;
        jsonResponse = jsonDecode(jsonString);
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (ex) {
      print('Exception $ex');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurple[100]],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: ListView(
                children: [
                  // header section
                  headerContainer(),
                  inputContainer(),
                  buttonContainer()
                ],
              ),
            ),
    );
  }

  Container buttonContainer() {
    return Container(
      height: 68,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.deepPurple,
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          signin(_emailCtrl.text, _pwdCtrl.text);
        },
      ),
    );
  }

  Container inputContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Column(
        children: [
          TextFormField(
            controller: _emailCtrl,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _pwdCtrl,
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
          ),
        ],
      ),
    );
  }

  Container headerContainer() {
    return Container(
      margin: EdgeInsets.only(top: 85),
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Text(
        "User Session Application",
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
