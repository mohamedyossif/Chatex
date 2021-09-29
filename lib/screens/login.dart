import 'package:chat_app/component/reused_button.dart';
import 'package:chat_app/screens/chat_list.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/services/shared_preferences.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const id = '/login';

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visibility = false;
  final _formKey = GlobalKey<FormState>();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _listSnapShots = [];
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(
                    image: AssetImage(
                      'assets/cover.png',
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.fill,
                  ),

                  /// text field for email
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      /// check email is not empty
                      if (value!.isEmpty) {
                        return 'Required Email';

                        ///cheek form email is correct
                      } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
                        return 'Enter a Valid Email';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: kFieldTextStyle(context).copyWith(
                        hintText: 'Enter Your Email',
                        prefixIcon: Icon(
                          Icons.person,
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  /// text field for password
                  TextFormField(
                    controller: _passwordController,

                    ///check password is not empty and less than 6 letters
                    validator: (value) =>
                        value!.isEmpty ? 'Required Password' : null,
                    keyboardType: TextInputType.text,
                    obscureText: !visibility,
                    decoration: kFieldTextStyle(context).copyWith(
                      suffixIcon: IconButton(
                        icon: visibility
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                      ),
                      hintText: 'Enter Your Password',
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///button for sign in
                  SizedBox(
                    height: 50,
                    child: reusedButton(
                      nameButton: 'Sign In',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          authFirebaseMethods
                              .signInWithEmailAndPassword(
                                  context,
                                  _emailController.text,
                                  _passwordController.text)
                              .then((value) {
                            if (value != null) {
                              /// to get loggedInEmail and UserName
                              fireStoreDatabaseMethods
                                  .getDataByAllString(_emailController.text)
                                  .then((value) {
                                _listSnapShots = value.docs;
                                SharedPreferencesDatabase.saveUserNameKey(
                                    _listSnapShots[0].data()['name']);
                                SharedPreferencesDatabase.saveUserEmailKey(
                                    _listSnapShots[0].data()['email']);
                              });
                              SharedPreferencesDatabase.saveUserLoggedInKey(
                                  false);

                              Navigator.of(context)
                                  .pushReplacementNamed(ChatList.id);
                            }
                          });
                        }
                      },
                    ),
                  ),

                  /// to go sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don`t have an account ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Register.id);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
