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
bool isCheck = true;
String chatRoomID2 = '';
String myName = '';
String email = FirebaseAuth.instance.currentUser!.email!;

///styles
TextStyle kResultSearch = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

TextStyle kMessageSender = TextStyle(color: Colors.black54, fontSize: 10.0);

TextStyle kWeChatText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 35.0,
  color: Colors.blue[600],
);
TextStyle kChatText = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: Colors.green[50],
);
InputDecoration kFieldTextStyleChat = InputDecoration(
  hintText: 'Type a message',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(0.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
    borderRadius: BorderRadius.circular(0.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1),
    borderRadius: BorderRadius.circular(0.0),
  ),
);

InputDecoration kFieldTextStyle = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
    borderRadius: BorderRadius.circular(30.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1),
    borderRadius: BorderRadius.circular(30.0),
  ),
  hintText: 'Enter Your Email',
);
