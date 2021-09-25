import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatabase {
  static String sharedPreferencesIsLoggedInKey = 'IsLoggedIn';
  static String sharedPreferencesUserEmailKey = 'UserEmailKey';
  static String sharedPreferencesUserNameKey = 'UserNameKey';
  // Save data To SharedPreferences
  static Future<bool> saveUserLoggedInKey(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferencesIsLoggedInKey, isLoggedIn);
  }
  static Future<bool> saveUserEmailKey(String isUserEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencesUserEmailKey, isUserEmail);
  }
  static Future<bool> saveUserNameKey(String isUserName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencesUserNameKey, isUserName);
  }

  // getting data from SharedPreferences

  static Future<bool?> getUserLoggedInKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferencesIsLoggedInKey);
  }
  static Future<String?> getUserEmailKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferencesUserEmailKey);
  }
  static Future<String?> getUserNameKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferencesUserNameKey);
  }
}
