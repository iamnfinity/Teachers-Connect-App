import 'package:flutter/foundation.dart';

class AttendanceSetModel {
  final String sessionId;
  final String branchId;
  final String branchName;
  final String semesterId;
  final String semesterName;
  final String subjectId;
  final String subjectName;
  final String periodId;
  final String periodStart;
  final String periodEnd;
  String unqiueId = "";
  final String userId;

  AttendanceSetModel({
    this.userId,
    this.sessionId,
    this.branchId,
    this.branchName,
    this.semesterId,
    this.semesterName,
    this.subjectId,
    this.subjectName,
    this.periodId,
    this.periodStart,
    this.periodEnd
  });


  // Function to return map
  Map < String, dynamic > toMap() {
    return {
      "userId": userId,
      "sessionId": sessionId,
      "branchId": branchId,
      "branchName": branchName,
      "semesterId": semesterId,
      "semesterName": semesterName,
      "subjectId": subjectId,
      "subjectName": subjectName,
      "periodId": periodId,
      "periodStart": periodStart,
      "periodEnd": periodEnd,
    };
  }

}