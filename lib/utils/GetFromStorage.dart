import 'package:flutter/foundation.dart';

// Import Shared Preference
import 'package:shared_preferences/shared_preferences.dart';
// Import Services Package
import 'package:teacher_app/configs/ServerConfigs.dart';

class GetFromStorage{
  
  // Get Username From Storage
  static Future<String> getName() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(ServerConfigs.name);
  }

  // Get UserId From Storage
  static Future<String> getUserId() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(ServerConfigs.userId);
  }

  // Get Auth Token From Storage
  static Future<String> getAuthToken() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(ServerConfigs.auth_key_storage_name);
  }
}