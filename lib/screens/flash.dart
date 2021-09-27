import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/screens/chat_list.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/services/shared_preferences.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:flutter/material.dart';

class Flash extends StatelessWidget {
  static const id = '/flash';
  void flashScreen(context) {
    Future.delayed(Duration(seconds: 3), () {
      SharedPreferencesDatabase.getUserLoggedInKey().then((value) {
        /// first time , value is null
        value =value??true;
        /// check if u loggedIn before or not
        if (value == true) {
          Navigator.pushReplacementNamed(context,Login.id);
        }
        else {
          Navigator.pushReplacementNamed(context,ChatList.id);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    flashScreen(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(
                  'assets/iconChat.png',
                ),
                height: 90,
                width: 90,
                fit: BoxFit.fill,
              ),
               SizedBox(width: 10,),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Chatex',
                    textStyle: kWeChatText,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

