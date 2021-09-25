import 'package:chat_app/services/auth_firebase.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///variables
AuthFirebaseMethods authFirebaseMethods = AuthFirebaseMethods();
FireStoreDatabaseMethods fireStoreDatabaseMethods = FireStoreDatabaseMethods();
SharedPreferencesDatabase sharedPreferencesDatabase =
    SharedPreferencesDatabase();
 String myName='';
///styles
TextStyle kResultSearch = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

TextStyle kMessageSender=TextStyle(
    color: Colors.black54,
    fontSize: 10.0
);

TextStyle kWeChatText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 27.0,
  color: Colors.green[900],
);
TextStyle kChatText = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: Colors.green[50],
);
InputDecoration kFieldTextStyle = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
    borderRadius: BorderRadius.circular(5.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
    borderRadius: BorderRadius.circular(5.0),
  ),
  hintText: 'Enter Your Email',
);
