import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_login_session/home_page.dart';
import 'package:user_login_session/screens/signup_screen.dart';
import 'package:user_login_session/services/api_manager.dart';

import 'components/button_component.dart';
import 'components/custom_input.dart';
import 'components/password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _pwdCtrl = TextEditingController();
  TextEditingController _baseUrlCtrl = TextEditingController();

  bool _isLoading = false;
  bool _isDeveloper = false;

  List<bool> isSelected;

  Future userAuthenticate(
      String email, String password, String loginUrl) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    // signin(_emailCtrl.text, _pwdCtrl.text);
    Map response = await APIManager().signIn(email, password, loginUrl);

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
  void initState() {
    isSelected = [true, false];
    super.initState();
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
                  urlContainer(),
                  toggleContainer(),
                  buttonContainer(),
                  Button(
                    labelText: 'Sign Up',
                    color: Colors.deepPurple[300],
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return Signup();
                        }),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }

  Container urlContainer() {
    return _isDeveloper
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(bottom: 15),
            child: TextFormField(
              controller: _baseUrlCtrl,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.http_outlined,
                  color: Colors.white,
                ),
                hintText: 'Login URI',
                hintStyle: TextStyle(color: Colors.white),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          )
        : Container();
  }

  Container toggleContainer() {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Are you Developer?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          ToggleButtons(
            borderWidth: 1,
            selectedBorderColor: Colors.white,
            selectedColor: Colors.green,
            borderColor: Colors.black,
            fillColor: Colors.deepPurple,
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              });
              // hide & show here
              setState(() {
                _isDeveloper = isSelected[1] ? true : false;
                if (!_isDeveloper) {
                  // clear if value exist if _isDeveloper is false
                  _baseUrlCtrl.clear();
                }
              });
            },
            isSelected: isSelected,
          ),
        ],
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
          if (_emailCtrl.text != null && _pwdCtrl.text != null) {
            userAuthenticate(_emailCtrl.text, _pwdCtrl.text, _baseUrlCtrl.text);
          }
        },
      ),
    );
  }

  Container inputContainer() {
    return Container(
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
