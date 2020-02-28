// Login Manager deals with user login mechanism

// Http Request Package
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


// Import Server Config File
import 'package:teacher_app/configs/ServerConfigs.dart';

// Import Shared Prefs
import 'package:shared_preferences/shared_preferences.dart';

// Import Attendance Model
import 'package:teacher_app/models/AttendanceSetModel.dart';


class AttendanceSetContoller{

  // Get Sessions
  static Future<dynamic> getSession() async{
    http.Response response = await http.get(ServerConfigs.ServerUrl+"/getSession");
    dynamic sessions = json.decode(response.body);
    return sessions;
  }

  // Get Branch List 
  static Future<dynamic> getBranch() async{
    http.Response response = await http.get(ServerConfigs.ServerUrl+"/getBranch");
    dynamic branch = json.decode(response.body);
    return branch;
  }

  // Get Semister List
  static Future<dynamic> getSemister(branch) async{
    http.Response response = await http.get(ServerConfigs.ServerUrl+"/getSemester/"+branch);
    dynamic semister = json.decode(response.body);
    return semister;
  }

  // Get Subject List
  static Future<dynamic> getSubject(sem) async{
    http.Response response = await http.get(ServerConfigs.ServerUrl+"/getSyllabus/"+sem);
    dynamic subject = json.decode(response.body);
    return subject;
  }

  // Send Data To Server
  static Future<Map<String, dynamic>> sendAttendanceDataToServer({Map body}) async{
    var data = json.encode(body);
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(ServerConfigs.ServerUrl+"/doMakeCodeForAttendance",body: data ,headers: headers);
    return json.decode(response.body);
  }

  static startTakingAttendanceServerCall(AttendanceSetModel model) async{
    dynamic data = await sendAttendanceDataToServer(body: model.toMap());
    print(data);
    return data;
  }
}