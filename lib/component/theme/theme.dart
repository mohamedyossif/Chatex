import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    appBarTheme: AppBarTheme(
      color: Colors.deepPurple,
    ),
    accentColor: Colors.blue,
  );
  static final ligthTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    appBarTheme: AppBarTheme(
      color: Colors.blue,
    ),
    accentColor: Colors.blue,
  );
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
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          themeProvider.toggoleTheme(value);
        });
  }
}
