import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_login_session/utils/strings.dart';

class APIManager {
  Future signIn(String email, String password, [String baseUrl]) async {
    Map data = {'email': email, 'password': password};
    dynamic responseJson = {};
    String uri = baseUrl.isEmpty ? Strings.baseUrl : baseUrl;
    try {
      var response = await http.post('$uri/api/login', headers: {}, body: data);
      print('API Manger : ${response.statusCode}');
      if (response.statusCode == 200) {
        responseJson = jsonDecode(response.body);
        print('API Manger Body : $responseJson');
      } else if (response.statusCode == 400) {
        responseJson = {'status': 400, 'message': 'Invalid credentials'};
      } else {
        responseJson = {'status': 500, 'message': 'Something went wrong.'};
      }
      return responseJson;
    } catch (ex) {
      responseJson = {'status': 500, "message": ex};
      return responseJson;
    }
  }
}
