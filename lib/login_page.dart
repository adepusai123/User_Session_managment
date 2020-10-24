import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_login_session/home_page.dart';
import 'package:user_login_session/services/api_manager.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _pwdCtrl = TextEditingController();
  bool _isLoading = false;

  Future userAuthenticate(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    // signin(_emailCtrl.text, _pwdCtrl.text);
    Map response = await APIManager().signIn(email, password);

    if (response['token'] != null) {
      sharedPreferences.setString("token", response['token']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    }
    setState(() {
      _isLoading = false;
    });
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
          userAuthenticate(_emailCtrl.text, _pwdCtrl.text);
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
