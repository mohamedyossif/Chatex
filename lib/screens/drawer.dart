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
          /* PreferredSize(
            preferredSize: MediaQuery.of(context).size * 0.1,
            child: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Settings'),
            ),
          ), */
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 40,
            child: myName == ''
                ? Text(' ')
                : Text(
                    myName.substring(0, 1),
                    style: TextStyle(fontSize: 50),
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.person,
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
                'dark mode',
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
