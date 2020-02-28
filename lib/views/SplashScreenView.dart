import 'package:flutter/material.dart';


// Import Custom Colors
import 'package:teacher_app/configs/ColorConfig.dart';

// Import Session Check Manager
import 'package:teacher_app/utils/CheckSessionManager.dart';

// Take Audio Permission
import 'package:simple_permissions/simple_permissions.dart';
_checkSession(context) async{
  print("Check Session");
  bool isLoggedIn = await CheckSessionManager.checkLoginSession();
  if (isLoggedIn == true) {
      Navigator.of(context).pushReplacementNamed('/menu');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
}

Future<void> _requestPermissions() async {
  bool permission =
  await SimplePermissions.checkPermission(Permission.RecordAudio);
  if (!permission) {
    await SimplePermissions.requestPermission(Permission.RecordAudio);
  }
}

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {


  @override
  Widget build(BuildContext context) {
    _checkSession(context);
    return new Scaffold(
      backgroundColor: ColorConfig.backgroundColor,
      body: new Container(
        width: double.infinity,
        height: double.infinity,
        child: new Center(
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    "Attendance Manager",
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  new Text(
                    "Loading, Please wait....",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  new Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),

                  new Theme(
                    data: ThemeData(
                      accentColor: Colors.white,
                    ),
                    child: new CircularProgressIndicator(),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  @override
  void initState() {
    _requestPermissions();
  }
}
