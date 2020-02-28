import 'package:flutter/foundation.dart';

class LoginModel{
  final String userId;
  final String password;

  // Constructer to init values
  LoginModel({Key key, @required this.userId, this.password});

  // Function to return map
  Map<String, dynamic> toMap(){
    return {
      "userId" : userId,
      "password" : password
    };
  }

}