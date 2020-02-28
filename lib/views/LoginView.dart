import 'package:flutter/material.dart';

// Import Screen Utils Package
import 'package:flutter_screenutil/flutter_screenutil.dart';


// Import Custom Colors
import 'package:teacher_app/configs/ColorConfig.dart';

// Import Teacher Login Model And Teacher Login Controller
import 'package:teacher_app/controllers/LoginController.dart';
import 'package:teacher_app/models/LoginModel.dart';

// Import Font Awesome
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Login View Statefull Widget
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  // Setting Global Key For Scaffold to Display Snack Bar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  TextEditingController _userIdController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool isPasswordHidden = true;


  void _showSnackBar(message){
     _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        message
      ),
    ));
  }

  // Start Login Function
  _startLogin() async{

    // Make login model to store UserId And Password
    LoginModel _teacherModel = new LoginModel(
      userId: _userIdController.text,
      password: _passwordController.text
    );

    // Start Login Procedure
    dynamic data = await LoginController.doLogin(_teacherModel);
    print(data);

    if(data["status"] == "failed"){
      _showSnackBar(data["message"]);
    }
    else{
      _showSnackBar(data["message"]);
      Navigator.of(context).pushReplacementNamed("/menu");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Adding Screen Util to adjust things according to screen
    // Default Screen Parameters width : 1080px , height:1920px
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    // Adding Font Scaling property to devices
    ScreenUtil(allowFontScaling: true).setSp(28.0);

    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConfig.backgroundColor,
        body: new SafeArea(
          child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      width: ScreenUtil().setWidth(900.0),
                      height: ScreenUtil().setHeight(800.0),
                      child: new Column(
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.only(top: 25.0),
                          ),

                          // Welcome Text
                          new Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(70.0),
                              fontWeight: FontWeight.w300,
                            ),
                          ),

                          // Log In To Continue Text
                          new Text(
                            "Log in to continue"
                          ),

                          // Padding
                          new Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),

                          new Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: new TextField(
                              controller: _userIdController,
                              decoration: InputDecoration(
                                hintText: "Teacher ID",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ColorConfig.textSecondry
                                  )
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 20.0),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorConfig.textSecondry
                                    )
                                )
                              ),
                            ),
                          ),

                          new Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),

                          new Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: new TextField(
                              obscureText: isPasswordHidden,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConfig.textSecondry
                                      )
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConfig.textSecondry
                                      )
                                  ),
                                  suffixIcon: GestureDetector(
                                    child: new Icon(
                                      isPasswordHidden == true ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                                      color: ColorConfig.textSecondry,
                                    ),
                                    onTap: (){
                                      setState(() {
                                       isPasswordHidden = !isPasswordHidden; 
                                      });
                                    },
                                  )
                              ),
                            ),
                          ),

                          new Padding(
                            padding: EdgeInsets.only(top: 15.0),
                          ),

                          new FractionallySizedBox(
                            widthFactor: 0.60,
                            child: new RaisedButton(
                              color: ColorConfig.backgroundColor,
                              onPressed: _startLogin,
                              child: new Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(60.0)
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
    );
  }
}
