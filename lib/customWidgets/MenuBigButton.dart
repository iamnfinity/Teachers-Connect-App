import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:teacher_app/configs/ColorConfig.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuBigButton extends StatelessWidget {


  final IconData icon;
  final String text;
  final Function callback;

  MenuBigButton({Key key,@required this.icon,@required this.text,@required this.callback}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // Adding Screen Util to adjust things according to screen
    // Default Screen Parameters width : 1080px , height:1920px
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    // Adding Font Scaling property to devices
    ScreenUtil(allowFontScaling: true).setSp(28.0);
    return new GestureDetector(
      onTap: callback,
      child: Card(
        color: ColorConfig.backgroundColor,
        child: new Container(
          width: ScreenUtil().setWidth(380.0),
          height: ScreenUtil().setHeight(380.0),
          child: new Column(
            children: < Widget > [
              // Padding Above Icon
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),

              // Icon
              new Icon(
                icon,
                color: Colors.white,
                size: 55.0,
              ),

              // Padding Above Button Text
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),

              // Button Text
              new Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(55.0),
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}