import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_login_session/utils/strings.dart';

class APIManager {
  Future signIn(String email, String password, [String baseUrl]) async {
    Map data = {'email': email, 'password': password};
    dynamic responseJson = {};
    String uri = baseUrl.isEmpty ? Strings.baseUrl : baseUrl;
    try {
      var response = await http.post(uri, headers: {}, body: data);
      print('API Manger : ${response.statusCode}');
      if (response.statusCode == 200) {
        responseJson = jsonDecode(response.body);
        print('API Manger Body : $responseJson');
      } else {
        responseJson = {'status': 401, 'message': 'Unauthorized'};
      }
      return responseJson;
    } catch (ex) {
      responseJson = {'status': 500, "message": ex};
      return responseJson;
    }
  }
}
