import 'package:chat_app/component/theme/theme.dart';
import 'package:chat_app/services/shared_preferences.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'login.dart';
Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            radius: 40,
            child: myName == ''
                ? Text(' ')
                : Text(
                    myName.substring(0, 1),
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Theme.of(context).accentColor.withOpacity(0.85),
              size: 35,
            ),
            title: Text(
              myName,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Theme.of(context).accentColor.withOpacity(0.85),
              size: 35,
            ),
            title: Text(
              email,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).accentColor.withOpacity(0.85),
              size: 35,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              authFirebaseMethods.signOut().then((value) {
                SharedPreferencesDatabase.saveUserLoggedInKey(true);
                Navigator.pushReplacementNamed(context, Login.id);
              });
            },
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Dark mode',
                style: TextStyle(fontSize: 20),
              ),
              ChangeThemeWidget()
            ],
          ),
        ],
      ),
    ),
  );
}
