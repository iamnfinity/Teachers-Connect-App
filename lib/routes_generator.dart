import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Import Login View
import 'views/LoginView.dart';
// Import Main Menu View
import 'views/MainMenuView.dart';
// Import Spalash Screen View
import 'views/SplashScreenView.dart';
// Attendance Set
import 'views/AttendanceSetView.dart';
// Take Attendance View
import 'views/TakeAttendanceView.dart';


// Attednance Set View Model
import 'models/AttendanceSetModel.dart';

class routes_generator{
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_) => new SplashScreenView());
      case "/login":
        return MaterialPageRoute(builder: (_) => new LoginView());
      case "/menu":
        return MaterialPageRoute(builder: (_) => new MainMenuView());
      case "/attendnaceSet":
        return MaterialPageRoute(builder: (_) => new AttendanceSetView());
      case "/attendanceTake":
        final AttendanceSetModel model = settings.arguments;
        return MaterialPageRoute(builder: (_) => new TakeAttendanceView(model));
    }
  }
}