import 'package:flutter/material.dart';

// Import Screen Utils Package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import Custom Colors
import 'package:teacher_app/configs/ColorConfig.dart';

// Import Teacher Login Model And Teacher Login Controller
import 'package:teacher_app/controllers/LoginController.dart';
import 'package:teacher_app/models/LoginModel.dart';

// Import Font Awesome
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Custom Widgets Menu Button
import 'package:teacher_app/customWidgets/MenuBigButton.dart';

// Get Details From Storage
import 'package:teacher_app/utils/GetFromStorage.dart';

class MainMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Adding Screen Util to adjust things according to screen
    // Default Screen Parameters width : 1080px , height:1920px
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    // Adding Font Scaling property to devices
    ScreenUtil(allowFontScaling: true).setSp(28.0);

    return new Scaffold(
      backgroundColor: ColorConfig.backgroundColor,
      body: new SafeArea(
        child: new Container(
          width: double.infinity,
          height: double.infinity,
          child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Card(
              child: new Container(
                width: ScreenUtil().setWidth(1000.0),
                height: ScreenUtil().setHeight(1800.0),
                child: new Padding(
                  padding: EdgeInsets.all(8.0),
                  child:  new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // Show Teacher Name and ID
                    // Teacher Name 
                    FutureBuilder(
                      future: GetFromStorage.getName(),
                      initialData: "Please Wait...",
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return new Text(
                            snapshot.data,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(70.0),
                              fontWeight: FontWeight.bold
                            ),
                          );
                        }
                      },
                    ),

                    // Show Teacher ID
                    FutureBuilder(
                      future: GetFromStorage.getUserId(),
                      initialData: "Please Wait...",
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return new Text(
                            "(${snapshot.data})",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(55.0),
                              fontWeight: FontWeight.bold
                            ),
                          );
                        }
                      },
                    ),

                    // Padding Before Menu Buttons
                    new Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),


                    // Show Menu Buttons
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new MenuBigButton(
                          icon: FontAwesomeIcons.clipboardList,
                          text: "Take Attendance",
                          callback: (){
                            print("Take Attendance Pressed");
                            Navigator.of(context).pushNamed("/attendnaceSet");
                          },
                        ),
                        new MenuBigButton(
                          icon: FontAwesomeIcons.powerOff,
                          text: "Log Out",
                          callback: (){
                            Navigator.of(context).pushReplacementNamed("/login");
                          },
                        )
                      ],
                    )
                    // Menu Buttons First Row End

                  ],
                ),
                ),
              ),
            )
          ],
        ),
        )
      )
    );
  }
}