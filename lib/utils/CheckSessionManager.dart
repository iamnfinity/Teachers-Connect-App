
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teacher_app/configs/ServerConfigs.dart';

class CheckSessionManager{
  static Future<bool> checkLoginSession() async{
    Map<String, String> headers = {"Content-type": "application/json"};
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> auth_data = {
      "auth_token" : pref.getString(ServerConfigs.auth_key_storage_name),
      "userId" : pref.getString(ServerConfigs.userId) 
    };
    print("Checking");
    var data = json.encode(auth_data);
    http.Response response = await http.post(ServerConfigs.ServerUrl+"/checkTokenStatus",body: data ,headers: headers);
    return json.decode(response.body)["valid"];
  }
}