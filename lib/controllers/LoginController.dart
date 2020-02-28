// Login Manager deals with user login mechanism

// Http Request Package
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// Import Teacher Login
import 'package:teacher_app/models/LoginModel.dart';

// Import Server Config File
import 'package:teacher_app/configs/ServerConfigs.dart';

// Import Shared Prefs
import 'package:shared_preferences/shared_preferences.dart';


class LoginController{

  static Future<Map<String, dynamic>> createPostRequest({Map body}) async{
    var data = json.encode(body);
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(ServerConfigs.ServerUrl+"/doLogin/Teacher",body: data ,headers: headers);
    return json.decode(response.body);
  }

  static doLogin(LoginModel model) async{
    print(model.toMap());
    dynamic data = await createPostRequest(body: model.toMap());

    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(ServerConfigs.auth_key_storage_name, data["auth_token"]);
    pref.setString(ServerConfigs.name, data["name"]);
    pref.setString(ServerConfigs.userId, data["userId"]);
    return data;
  }
}