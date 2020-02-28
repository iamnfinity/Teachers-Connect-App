 import 'dart:async';
 import 'dart:convert';

 import 'package:flutter/material.dart';
 import 'package:flutter/widgets.dart';

 // Import Screen Utils Package
 import 'package:flutter_screenutil/flutter_screenutil.dart';

 // Import Custom Colors
 import 'package:teacher_app/configs/ColorConfig.dart';

 // Import Font Awesome
 import 'package:font_awesome_flutter/font_awesome_flutter.dart';
 import 'package:teacher_app/configs/ServerConfigs.dart';

 // Get Details From Storage
 import 'package:teacher_app/utils/GetFromStorage.dart';

 // Import Attendance Set Model
 import 'package:teacher_app/models/AttendanceSetModel.dart';

 // import http module
 import 'package:http/http.dart'
 as http;

 // Import Audio QR Code SDK
 import 'package:chirpsdk/chirpsdk.dart';
 import 'dart:typed_data';
 import 'package:simple_permissions/simple_permissions.dart';

 class TakeAttendanceView extends StatefulWidget {
   @override
   _TakeAttendanceViewState createState() => _TakeAttendanceViewState();

   // Attendance Model
   AttendanceSetModel model;
   TakeAttendanceView(this.model);
 }

 class _TakeAttendanceViewState extends State < TakeAttendanceView > {
   // Divider Width Variable
   double dividerWidth = 80.0;

   // Bool Sending Data
   bool isSendingData = false;

   // Roll Number Text Controller
   TextEditingController _rollNumber = new TextEditingController();


   // Stop Taking Attendance Function
   _stopTakingAttendance() async {
     dynamic data = await http.get(ServerConfigs.ServerUrl+"/stopTakingAttendance/"+widget.model.unqiueId);
     dynamic gotData = json.decode(data.body);
     if(gotData["status"] == "success"){
       Navigator.of(context).pushReplacementNamed("/menu");
     }
     else{
       _showSnackBar("Error Re!");
     }
   }

   // Audio Attendance Important Variables

   String _appKey = 'EE6f0ecB322D8be8f0dDfc35A';
   String _appSecret = '1Ec8af101e7a21CF6A8Cf39D88b0aFD1B508BAbae0fc6Cc85A';
   String _appConfig = "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";
   // Audio Attendance Important Variable End

   // Some Important Variable Configs
   String _chirpStringState = "Not Active";
   ChirpState _chirpState = ChirpState.not_created;
   String _chirpErrors = '';
   String _chirpVersion = 'Unknown';
   String _chirpTextData = "Unknown";
   Uint8List _chirpData = Uint8List(0);
   // Some Important Variable Configs


   // Data Transmission Functions
   Future < void > _initChirp() async {
     await ChirpSDK.init(_appKey, _appSecret);
   }

   Future < void > _configureChirp() async {
     await ChirpSDK.setConfig(_appConfig);
   }

   Future < void > _sendData() async {
     await ChirpSDK.send(Uint8List.fromList((widget.model.unqiueId.toString()).codeUnits));
   }

   Future < void > _startAudioProcessing() async {
     await ChirpSDK.start();
   }

   Future < void > _stopAudioProcessing() async {
     await ChirpSDK.stop();
   }


   Future < void > _setChirpCallbacks() async {
     ChirpSDK.onStateChanged.listen((e) {
       setState(() {
         if (e.current == ChirpState.running) {
           _chirpStringState = "Running Listner";
         }
         if (e.current == ChirpState.sending) {
           _chirpStringState = "Sending Data";
         }
         if (e.current == ChirpState.receiving) {
           _chirpStringState = "Receiving Data Please Wait";
         }
       });
     });
     ChirpSDK.onSending.listen((e) {
       print("Sending");
       this.isSendingData = true;
       setState(() {});
     });
     ChirpSDK.onSent.listen((e) {
       this.isSendingData = false;
       setState(() {
         _chirpData = e.payload;
       });
     });
     ChirpSDK.onReceived.listen((e) {
       setState(() {
         _chirpData = e.payload;
         _chirpTextData = new String.fromCharCodes(e.payload);
       });
     });
     ChirpSDK.onError.listen((e) {
       print(e);
       setState(() {
         _chirpErrors = e.message;
       });
     });
   }

   // To Request Mic Permession
   Future < void > _requestPermissions() async {
     bool permission =
       await SimplePermissions.checkPermission(Permission.RecordAudio);
     if (!permission) {
       await SimplePermissions.requestPermission(Permission.RecordAudio);
     }
   }

   // Function to request headCount every 5 seconds
   Future < dynamic > _getHeadCount() async {
     dynamic data = await http.get(ServerConfigs.ServerUrl + "/getHeadCount/" + widget.model.unqiueId);
     return json.decode(data.body);
   }

   _reloadHeadCount() async {
     new Timer.periodic(new Duration(seconds: 8), (Timer t) {
       print("Reloading");
       setState(() {

       });
     });
   }

   // Make Global Key To Show Snackbar
   final GlobalKey < ScaffoldState > scaffoldKey = new GlobalKey < ScaffoldState > ();

   void _showSnackBar(message) {
     scaffoldKey.currentState.showSnackBar(new SnackBar(
       content: new Text(
         message,
         style: new TextStyle(
           color: Colors.green
         ),
       ),
     ));
   }

   // Mark Attendance Manually Function
   _markAttendanceManually() async {
     print("Marking Manually");
     Map < String, String > headers = {
       "Content-type": "application/json"
     };
     dynamic body = json.encode({
       "rollNumber": _rollNumber.text,
       "code": widget.model.unqiueId
     });
     dynamic data = await http.post(ServerConfigs.ServerUrl + "/markManualAttendance", body: body, headers: headers);
     dynamic resData = json.decode(data.body);
     print(resData);
     _showSnackBar(resData["message"] + " : " + resData["studentName"]);
   }

   @override
   void initState() {
     super.initState();
     _requestPermissions();
     _initChirp();
     _configureChirp();
     _setChirpCallbacks();
     _reloadHeadCount();
     _startAudioProcessing();
   }

   // Get Attendance Marked Student Data
   Future _getMarkedStudentData() async {
     dynamic data = await http.get(ServerConfigs.ServerUrl + "/getMarkedAttendanceList/" + widget.model.unqiueId);
     return json.decode(data.body);
   }
  
   void _showModalAttendance(context) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return new AlertDialog(
           title: new Text("Attendance Marked of: "),
           content: new Padding(
             padding: EdgeInsets.all(5.0),
             child: new FutureBuilder(
               future: _getMarkedStudentData(),
               builder: (BuildContext context, AsyncSnapshot snap) {
                 if (snap.hasData) {
                   return new Container(
                     width: double.maxFinite,
                     child: ListView.builder(
                       itemCount: (snap.data).length,
                       itemBuilder: (BuildContext context, int index) {
                         print(snap.data[index]["studentName"]);
                         return new Padding(
                           padding: EdgeInsets.only(top: 3.0),
                           child: new Container(
                             decoration: new BoxDecoration(
                               border: Border.all()
                             ),
                             child: new Row(
                               children: < Widget > [
                                 new Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: < Widget > [
                                     new Text(
                                       snap.data[index]["studentName"],
                                       style: TextStyle(
                                         fontSize: 20.0,
                                         fontWeight: FontWeight.bold
                                       ),
                                     ),
                                     new Text(
                                       snap.data[index]["rollNumber"],
                                       style: TextStyle(
                                         fontSize: 16.0,
                                         fontWeight: FontWeight.w700,
                                         color: ColorConfig.textSecondry
                                       )
                                     )
                                   ],
                                 ),
                                 new Padding(
                                   padding: EdgeInsets.only(right: 4.0),
                                   child: new Icon(
                                   Icons.check_circle,
                                    color: Colors.green,
                                    size: 20.0,
                                 ),
                                 )

                               ],
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             ),
                           ),
                         );
                       },
                     ),
                   );
                 } else {
                   return new Container(
                     width: 200.0,
                     height: 200.0,
                     child: CircularProgressIndicator(),
                   );
                 }
               },
             ),
           ),
         );
       }
     );
   }
   @override
   void dispose() {
     _stopAudioProcessing();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     // Adding Screen Util to adjust things according to screen
     // Default Screen Parameters width : 1080px , height:1920px
     ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

     // Adding Font Scaling property to devices
     ScreenUtil(allowFontScaling: true).setSp(28.0);

     return new Scaffold(
       key: scaffoldKey,
       backgroundColor: ColorConfig.backgroundColor,
       body: new SafeArea(
         child: new SingleChildScrollView(
           child: new Container(
             width: ScreenUtil().setWidth(1080.0),
             height: ScreenUtil().setHeight(1900.0),
             child: new Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: < Widget > [
                 new Card(
                   child: new Container(
                     width: ScreenUtil().setWidth(1000.0),
                     height: ScreenUtil().setHeight(1800.0),
                     child: new Padding(
                       padding: EdgeInsets.all(8.0),
                       child: new Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: < Widget > [
                           // Show Teacher Name and Subject and Branch [Start]
                           new Row(
                             children: < Widget > [
                               // Teacher Name And Subject Start
                               new Column(
                                 children: < Widget > [
                                   // Teacher Name
                                   FutureBuilder(
                                     future: GetFromStorage.getName(),
                                     initialData: "Please Wait...",
                                     builder: (BuildContext context,
                                       AsyncSnapshot snapshot) {
                                       if (snapshot.hasData) {
                                         return new Text(
                                           snapshot.data,
                                           style: TextStyle(
                                             fontSize: ScreenUtil().setSp(70.0),
                                             fontWeight: FontWeight.bold),
                                         );
                                       }
                                     },
                                   ),
                                   // Show Teacher Subject
                                  new Container(
                                    width: ScreenUtil().setWidth(700.0),
                                    child:  new Text(
                                     "[ ${widget.model.subjectName} ]",
                                     style: TextStyle(
                                       fontSize: ScreenUtil().setSp(55.0),
                                       fontWeight: FontWeight.w400),
                                   ),
                                  )
                                 ],
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                               ),
                               // Teacher Name And Subject End

                               // Branch Display Start
                               new Card(
                                 color: ColorConfig.backgroundColor,
                                 child: new Container(
                                   height: ScreenUtil().setHeight(200.0),
                                   width: ScreenUtil().setWidth(200.0),
                                   child: new Center(
                                     child: new Padding(
                                       padding: EdgeInsets.all(5.0),
                                       child: new Text(
                                         "${widget.model.branchName}",
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize:
                                           ScreenUtil().setSp(60.0),
                                           fontWeight: FontWeight.bold),
                                       ),
                                     ),
                                   )))
                             ],
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           ),
                           // Show Teacher Name and Subject and Branch [Start]

                           // Padding Before Code
                           new Padding(
                             padding: EdgeInsets.only(top: 40.0),
                           ),

                           // Show Unique Code [Start]
                           new Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: < Widget > [
                               new Card(
                                 color: ColorConfig.backgroundColor,
                                 child: new Container(
                                   width: ScreenUtil().setWidth(800.0),
                                   child: new Padding(
                                     padding: EdgeInsets.all(6.0),
                                     child: new Text(
                                       "CODE : [ ${widget.model.unqiueId} ]",
                                       textAlign: TextAlign.center,
                                       style: TextStyle(
                                         fontSize: ScreenUtil().setSp(60.0),
                                         color: Colors.white,
                                         fontWeight: FontWeight.bold),
                                     ),
                                   )),
                               )
                             ],
                           ),
                           // Show Unique Code [End]

                           // Padding Before Play Button
                           new Padding(
                             padding: EdgeInsets.only(top: 30.0),
                           ),
                           // Show Audio Play Button [Start]
                           new Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: < Widget > [
                               // Show Divider
                               new Container(
                                 width: dividerWidth,
                                 child: Divider(
                                   color: ColorConfig.textPrimary,
                                 ),
                               ),

                               // Audio Play Button
                               new Padding(
                                 padding: EdgeInsets.all(8.0),
                                 child: new SizedBox(
                                   width: ScreenUtil().setWidth(200.0),
                                   height: ScreenUtil().setHeight(200.0),
                                   child: FloatingActionButton(
                                     onPressed: _sendData,
                                     backgroundColor: ColorConfig.backgroundColor,
                                     elevation: 1,
                                     tooltip: "Press To Send Code",
                                     child: new Icon(
                                       isSendingData ? Icons.pause : Icons.play_arrow,
                                       size: 36.0,
                                     ),
                                   ),
                                 ),
                               ),
                               // Show Divider
                               new Container(
                                 width: dividerWidth,
                                 child: Divider(
                                   color: ColorConfig.textPrimary,
                                 ),
                               ),
                             ],
                           ),
                           // Show Audio Play Button [End]

                           // Padding Berfore Manual Attendance Mode
                           new Padding(
                             padding: EdgeInsets.only(top: 15.0),
                           ),
                           // Manual Attendance Mode [Start]
                           new TextField(
                             controller: _rollNumber,
                             decoration: InputDecoration(
                               hintText: "Enter Roll Number",
                               border: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   width: 1.0,
                                   color: ColorConfig.textSecondry,
                                 ),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   width: 1.0,
                                   color: ColorConfig.textSecondry,
                                 ),
                               ),
                               contentPadding: EdgeInsets.symmetric(
                                 vertical: 20.0, horizontal: 15.0),
                               prefixIcon: Icon(
                                 FontAwesomeIcons.idCard,
                                 color: ColorConfig.textPrimary,
                               ),
                             ),
                             style: TextStyle(fontSize: ScreenUtil().setSp(45.0)),
                           ),

                           // Padding Before Button
                           new Padding(padding: EdgeInsets.only(top: 12.0)),


                           new FractionallySizedBox(
                             widthFactor: 1,
                             child: new RaisedButton(
                               onPressed: _markAttendanceManually,
                               color: ColorConfig.backgroundColor,
                               child: new Padding(
                                 padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                 child: new Text(
                                   "Mark Attendance For Above\nRoll Number",
                                   style: TextStyle(
                                     fontSize: ScreenUtil().setSp(48.0),
                                     color: Colors.white,
                                     fontWeight: FontWeight.w600
                                   ),
                                   textAlign: TextAlign.center,
                                 ),
                               )
                             ),
                           ),

                           new Padding(padding: EdgeInsets.only(top: 20.0)),


                           new FractionallySizedBox(
                             widthFactor: 1,
                             child: new RaisedButton(
                               onPressed: _stopTakingAttendance,
                               color: ColorConfig.backgroundColor,
                               child: new Padding(
                                 padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                                 child: new Text(
                                   "Stop Taking Attendance",
                                   style: TextStyle(
                                     fontSize: ScreenUtil().setSp(48.0),
                                     color: Colors.white,
                                     fontWeight: FontWeight.w600
                                   ),
                                   textAlign: TextAlign.center,
                                 ),
                               )
                             ),
                           ),
                           // Manual Attendance Mode [End]

                           // Padding Before Head Count
                           new Padding(
                             padding: EdgeInsets.only(top: 10.0),
                           ),


                           // Head Count Show
                           new Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: < Widget > [
                               new GestureDetector(
                                 child: new Card(
                                   color: ColorConfig.backgroundColor,
                                   child: new Container(
                                     width: 85.0,
                                     height: 85.0,
                                     child: new Column(
                                       children: < Widget > [

                                         // Progress Bar
                                         Theme(
                                           data: ThemeData(
                                             accentColor: Colors.white,
                                           ),
                                           child: LinearProgressIndicator(
                                             backgroundColor: Colors.green,
                                           ),
                                         ),

                                         // Text To Show Count
                                         new Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: < Widget > [
                                             FutureBuilder(
                                               future: _getHeadCount(),
                                               builder: (BuildContext context, AsyncSnapshot snapshot) {
                                                 if (snapshot.hasData) {
                                                   print(snapshot.data);
                                                   return new Text(
                                                     snapshot.data["count"].toString(),
                                                     style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 50.0
                                                     ),
                                                   );
                                                 } else {
                                                   return CircularProgressIndicator();
                                                 }
                                               },
                                             ),
                                             new Text(
                                               "Head Count",
                                               style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 13.0,
                                                 fontWeight: FontWeight.w600
                                               ),
                                             )
                                           ],
                                         )
                                       ],
                                     )
                                   ),
                                 ),
                                 onLongPress: () {
                                   _showModalAttendance(context);
                                 },
                               )
                             ],
                           )

                         ],
                       ),
                     ),
                   ),
                 )
               ],
             ),
           ),
         )),
     );
   }
 }