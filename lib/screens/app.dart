import 'package:chat_app/screens/flash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  static const id = '/app';
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw 'Error in fireBase';
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Flash();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
