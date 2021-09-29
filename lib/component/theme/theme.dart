import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      inputDecorationTheme: InputDecorationTheme(fillColor: Colors.deepPurple),
      colorScheme: ColorScheme.dark(),
      iconTheme: IconThemeData(color: Colors.deepPurple, opacity: 0.7),
      appBarTheme: AppBarTheme(
        color: Colors.deepPurple,
      ),
      buttonColor: Colors.deepPurple[700],
      accentColor: Colors.deepPurple,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurple))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple, foregroundColor: Colors.white));
  static final ligthTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue, opacity: 0.7),
      inputDecorationTheme: InputDecorationTheme(),
      appBarTheme: AppBarTheme(
        color: Colors.blue,
      ),
      buttonColor: Colors.blue[700],
      accentColor: Colors.blue,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue))),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue, foregroundColor: Colors.black));
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  get myTheme => isDarkMode ? MyTheme.darkTheme : MyTheme.ligthTheme;

  void toggoleTheme(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ChangeThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        activeColor: Colors.deepPurple,
        inactiveThumbColor: Colors.blue,
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          themeProvider.toggoleTheme(value);
        });
  }
}
