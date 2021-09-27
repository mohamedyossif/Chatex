import 'package:chat_app/screens/app.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/chat_list.dart';
import 'package:chat_app/screens/flash.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/screens/search.dart';
import 'package:flutter/material.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
        accentColor: Colors.blue,
      ),
      initialRoute: App.id,
      routes: {
        App.id: (context) => App(),
        Flash.id: (context) => Flash(),
        Login.id: (context) => Login(),
        Register.id: (context) => Register(),
        ChatList.id: (context) => ChatList(),
        Chat.id: (context) => Chat(),
        Search.id:(context)=>Search(),
      },
    );
  }
}
