import 'package:flutter/material.dart';

// Import Screen Utils Package
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import Custom Colors
import 'package:teacher_app/configs/ColorConfig.dart';

// Import Data Get Contoller
import 'package:teacher_app/controllers/AttendanceSetController.dart';

// Import Attendance Set Model
import 'package:teacher_app/models/AttendanceSetModel.dart';

// To Get User ID
import 'package:teacher_app/utils/GetFromStorage.dart';


class AttendanceSetView extends StatefulWidget {
  @override
  _AttendanceSetViewState createState() => _AttendanceSetViewState();
}

class _AttendanceSetViewState extends State < AttendanceSetView > {


  // Global Key For Scaffold To Show Snackbar
  GlobalKey < ScaffoldState > _scaffoldKey = new GlobalKey();

  // Boolean value for button progess bar
  bool isCalculating = false;

  // Boolean Value to Show drop down accordingly
  bool isBranchSelecterVisible = false;
  bool isSemisterSelecterVisible = false;
  bool isSubjectSelecterVisible = false;
  bool isPeriodSelecterVisible = false;

  // Default Value For Selected Sesion
  String selectedSession = "-1";
  String selectedBranch = "-1";
  String selectedSemister = "-1";
  String selectedSubject = "-1";
  String selectedPeriod = "-1";


  // JSON Objects For Later Use
  dynamic selectedSessionData = "-1";
  dynamic selectedBranchData = "-1";
  dynamic selectedSemisterData = "-1";
  dynamic selectedSubjectData = "-1";
  // End

  // Map For Period Selecter
  List < Map > periods = [{
      "Id": 0,
      "Start": "9:40",
      "End": "10:40"
    },
    {
      "Id": 1,
      "Start": "10:40",
      "End": "11:40"
    },
    {
      "Id": 2,
      "Start": "11:40",
      "End": "12:30"
    },
    {
      "Id": 3,
      "Start": "12:30",
      "End": "1:50"
    },
    {
      "Id": 4,
      "Start": "1:50",
      "End": "2:50"
    },
    {
      "Id": 5,
      "Start": "2:50",
      "End": "3:50"
    }
  ];

  // Drop Down Button Decoratons
  InputDecoration dropDownButtonDecoration = new InputDecoration(

    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: ColorConfig.textSecondry
      )
    ),


  );

  // Get Session List
  getSessionsList() async {

    dynamic data = await AttendanceSetContoller.getSession();
    selectedSessionData = data;

    List < DropdownMenuItem < String >> items = [];
    // Default Value
    items.add(
      DropdownMenuItem(
        child: new Text(
          "Please Select Session"
        ),
        value: "-1",
      )
    );
    data.forEach((da) => {
      items.add(
        DropdownMenuItem(
          child: new Text(
            da["Session_Name"]
          ),
          value: da["Session_ID"].toString(),
        )
      )
    });
    return items;
  }

  // Get Branch List
  getBranchList() async {

    dynamic data = await AttendanceSetContoller.getBranch();
    selectedBranchData = data;

    List < DropdownMenuItem < String >> items = [];
    // Default Value
    items.add(
      DropdownMenuItem(
        child: new Text(
          "Please Select Branch"
        ),
        value: "-1",
      )
    );
    data.forEach((da) => {
      items.add(
        DropdownMenuItem(
          child: new Text(
            da["BR_Branch_Name"]
          ),
          value: da["BR_Branch_Id"].toString(),
        )
      )
    });
    return items;
  }

  // Get Semister List
  getSemisterList() async {

    dynamic data = await AttendanceSetContoller.getSemister(selectedBranch);
    selectedSemisterData = data;
    //print(data);

    List < DropdownMenuItem < String >> items = [];
    // Default Value
    items.add(
      DropdownMenuItem(
        child: new Text(
          "Please Select Semester"
        ),
        value: "-1",
      )
    );
    data.forEach((da) => {
      items.add(
        DropdownMenuItem(
          child: new Text(
            da["SM_Sem_Name"]
          ),
          value: da["SM_Sem_Id"].toString(),
        )
      )
    });
    return items;
  }

  // Get Subject List
  getSubjectList() async {

    dynamic data = await AttendanceSetContoller.getSubject(selectedSemister);
    //print(data);
    selectedSubjectData = data;


    List < DropdownMenuItem < String >> items = [];
    // Default Value
    items.add(
      DropdownMenuItem(
        child: new Text(
          "Please Select Subject"
        ),
        value: "-1",
      )
    );
    data.forEach((da) => {
      items.add(
        DropdownMenuItem(
          child: new Text(
            da["SY_Syllabus_Name"]
          ),
          value: da["SY_Syllabus_Id"].toString(),
        )
      )
    });
    return items;
  }

  // Period Selecter 
  // Get Subject List
  getPeriodList() {

    List < DropdownMenuItem < String >> items = [];
    // Default Value

    items.add(
      DropdownMenuItem(
        child: new Text(
          "Please Select Period"
        ),
        value: "-1",
      )
    );
    periods.forEach((da) => {
      items.add(
        DropdownMenuItem(
          child: new Text(
            (da["Id"] + 1).toString()
          ),
          value: da["Id"].toString(),
        )
      )
    });
    return items;
  }


  // Show Message In Snackbar
  _showMessage(data) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: new Text(
        data
      ),
    ));

  }

  // Start Taking Attendance Start 
  _startTakingAttendance() async {
    if(isCalculating != true){
      
    // Show Snackbar
    _showMessage("Please Wait");

    // Start Progress Bar
    isCalculating = true;
    setState(() {
      
    });

    // Get Selected Session ID
    String sessionId = selectedSession;

    // Get Selected Branch Name And ID

    // Get Branch Id
    String branchId = selectedBranch;

    // Get Branch Name
    String branchName = "";
    for (final data in selectedBranchData) {
      if (data["BR_Branch_Id"].toString() == branchId) {
        branchName = data["BR_Branch_Name"];
        break;
      }
    }


    // Get Selected Semester Name And ID

    // Get Semester Id
    String semesterId = selectedSemister;

    // Get Semester Name
    String semesterName = "";
    for (final data in selectedSemisterData) {
      if (data["SM_Sem_Id"].toString() == semesterId) {
        semesterName = data["SM_Sem_Name"];
        break;
      }
    }


    // Get Selected Subject Name And ID

    // Get Subject Id
    String subjectId = selectedSubject;

    // Get Subject Name
    String subjectName = "";
    for (final data in selectedSubjectData) {
      if (data["SY_Syllabus_Id"].toString() == subjectId) {
        subjectName = data["SY_Syllabus_Name"];
        break;
      }
    }


    // Get Selected Period Name And ID

    // Get Period Id
    String periodId = selectedPeriod;

    // Get Period Start And End
    String periodStart = periods[int.parse(periodId)]["Start"];
    String periodEnd = periods[int.parse(periodId)]["End"];

    // Get userId
    String userId = await GetFromStorage.getUserId();

    // Create Model
    AttendanceSetModel attendanceSetModel = new AttendanceSetModel(
      userId: userId,
      sessionId: sessionId,
      branchId: branchId,
      branchName: branchName,
      semesterId: semesterId,
      semesterName: semesterName,
      subjectId: subjectId,
      subjectName: subjectName,
      periodId: periodId,
      periodStart: periodStart,
      periodEnd: periodEnd
    );

    print(attendanceSetModel.toMap());
    // Send Data To Server Now
    dynamic data = await AttendanceSetContoller.startTakingAttendanceServerCall(attendanceSetModel);
    if(data["error"] == false){
      _showMessage(data["message"]);
      attendanceSetModel.unqiueId = data["uniqueId"].toString();
      print(attendanceSetModel.unqiueId.toString());
      Navigator.of(context).pushReplacementNamed("/attendanceTake",arguments: attendanceSetModel);
    }
    }
  }
  // Start Taking Attendance End

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
        child: new Container(
          width: double.infinity,
          height: double.infinity,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: < Widget > [
                        // Paddding Before Text
                        new Padding(
                          padding: EdgeInsets.only(top: 15.0),
                        ),

                        new Text(
                          "Select Values For Attendance",
                          style: TextStyle(
                            color: ColorConfig.textPrimary,
                            fontSize: ScreenUtil().setSp(60.0)
                          ),
                          textAlign: TextAlign.center,
                        ),


                        // Padding Before Session Dropdown
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),

                        // Session Dropdown Start
                        FutureBuilder(
                          future: int.parse(selectedSession) < 0 ? getSessionsList() : null,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return new DropdownButtonFormField(
                                value: selectedSession,
                                hint: new Text("Please  Select Session"),
                                decoration: dropDownButtonDecoration,

                                onChanged: (data) {
                                  print("Selected Session Id : ${data}");
                                  // Enable Branch Selecter If Something is Selected
                                  isBranchSelecterVisible = true;
                                  // Reset Everything If Changed and rebuild
                                  selectedBranch = "-1";
                                  selectedSemister = "-1";
                                  selectedSubject = "-1";
                                  selectedPeriod = "-1";
                                  // End Reset
                                  print(selectedSession);
                                  setState(() {
                                    selectedSession = data;
                                  });
                                },
                                items: snapshot.data,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),

                        // Padding Before Branch Selecter
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),

                        // Branch Selecter 
                        isBranchSelecterVisible ?
                        new FutureBuilder(
                          future: int.parse(selectedBranch) < 0 ? getBranchList() : null,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return new DropdownButtonFormField(
                                decoration: dropDownButtonDecoration,
                                value: selectedBranch,
                                hint: new Text("Please Select Session"),

                                onChanged: (data) {
                                  print("Selected Branch Id : ${data}");
                                  // Enable Semsiter Selecter if Something is Selected
                                  isSemisterSelecterVisible = true;
                                  // Reset Everything If Changed and rebuild
                                  selectedSemister = "-1";
                                  selectedSubject = "-1";
                                  selectedPeriod = "-1";
                                  // End Reset

                                  setState(() {
                                    selectedBranch = data;
                                  });
                                },
                                items: snapshot.data,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ) : new Container(),


                        // End of Branch Selecter
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),


                        // Semister Selecter
                        isSemisterSelecterVisible ?
                        new FutureBuilder(
                          future: int.parse(selectedSemister) < 0 ? getSemisterList() : null,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return new DropdownButtonFormField(
                                decoration: dropDownButtonDecoration,
                                value: selectedSemister,
                                hint: new Text("Please Select Session"),

                                onChanged: (data) {
                                  print("Selected Semister Id : ${data}");
                                  // Enable Semsiter Selecter if Something is Selected
                                  isSubjectSelecterVisible = true;
                                  // Reset Everything If Changed and rebuild
                                  selectedSubject = "-1";
                                  selectedPeriod = "-1";
                                  // End Reset
                                  setState(() {
                                    selectedSemister = data;
                                  });
                                },
                                items: snapshot.data,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ) : new Container(),
                        // Semister Slecter End

                        // Padding before subject selecter
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),

                        // Subject Selecter Start
                        isSubjectSelecterVisible ?
                        new FutureBuilder(
                          future: int.parse(selectedSubject) < 0 ? getSubjectList() : null,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return new DropdownButtonFormField(
                                decoration: dropDownButtonDecoration,
                                value: selectedSubject,
                                hint: new Text("Please Select Subject"),

                                onChanged: (data) {
                                  print("Selected Subject Id : ${data}");
                                  // Enable Semsiter Selecter if Something is Selected
                                  isPeriodSelecterVisible = true;
                                  // Reset Everything If Changed and rebuild
                                  selectedPeriod = "-1";
                                  // End Reset
                                  setState(() {
                                    selectedSubject = data;
                                  });
                                },
                                items: snapshot.data,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ) : new Container(),
                        // Subject Selecter End

                        // Padding Before Period Selecter
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),


                        // Period Selecter Start
                        isPeriodSelecterVisible ?
                        new DropdownButtonFormField(
                          decoration: dropDownButtonDecoration,
                          value: selectedPeriod,
                          hint: new Text("Please Select Subject"),

                          onChanged: (data) {
                            print("Selected Period Id : ${data}");

                            setState(() {
                              selectedPeriod = data;
                            });
                          },
                          items: getPeriodList(),
                        ) : new Container(),

                        // Period Selecter end

                        // Padding Before Start And End Time
                        new Padding(
                          padding: EdgeInsets.only(top: 15.0),
                        ),


                        // Show Period Start And End Times
                        (selectedPeriod != "-1") ?
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: < Widget > [
                            new Text(
                              "Start Time\n${periods[int.parse(selectedPeriod)]["Start"]}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(60.0),
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                            new Text(
                              "End Time\n${periods[int.parse(selectedPeriod)]["End"]}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(60.0),
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ) : new Container(),
                        // Show Period Start And End Time End


                        // Padding Before Button
                        new Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        // Mark Attendance Button
                        new SizedBox(
                          width: ScreenUtil().setWidth(800.0),
                          height: ScreenUtil().setHeight(150.0),

                          child: new RaisedButton(
                            onPressed: _startTakingAttendance,
                            color: ColorConfig.backgroundColor,
                            child: new Padding(
                              padding: EdgeInsets.all(5.0),
                              child: isCalculating == true ?
                                ProgressBarCust() : 
                                new Text(
                                  "Start Taking Attendance",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(60.0),
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                            )
                          ),
                        )

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


class ProgressBarCust extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: ThemeData(
        accentColor: Colors.white
      ),
      child: CircularProgressIndicator(),
    );
  }
}