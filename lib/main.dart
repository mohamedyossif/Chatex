import 'package:chat_app/component/theme/theme.dart';
import 'package:chat_app/screens/app.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/chat_list.dart';
import 'package:chat_app/screens/flash.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        ThemeProvider themeProvider = Provider.of(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: themeProvider.myTheme,
          initialRoute: App.id,
          routes: {
            App.id: (context) => App(),
            Flash.id: (context) => Flash(),
            Login.id: (context) => Login(),
            Register.id: (context) => Register(),
            ChatList.id: (context) => ChatList(),
            Chat.id: (context) => Chat(),
            Search.id: (context) => Search(),
          },
        );
      },
    );
  }
}
