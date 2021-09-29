import 'package:chat_app/component/reused_button.dart';
import 'package:chat_app/component/reused_snackBar.dart';
import 'package:chat_app/screens/chat_list.dart';
import 'package:chat_app/services/shared_preferences.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:flutter/material.dart';

int resultUserName = 0;
int resultUserEmail=0;
class Register extends StatefulWidget {
  static const id = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  bool visibility = false;
  final _password1Controller = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  Icon? _icon;
  ///methods
   checkUserName(String name) async {
      await fireStoreDatabaseMethods.checkValidUserName(name).then((value) {

         resultUserName = value.length;
      });
    }
    checkUserEmail(String email) async {
      await fireStoreDatabaseMethods.getDataByAllString(email).then((value) {
          resultUserEmail = value.docs.length;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 30.0, bottom: 15.0),
              child: Text(
                'Create an account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 35.0,
                        ),

                        /// Text Field for name
                        TextFormField(
                          controller: _userNameController,

                          ///check name is not empty
                          validator: (value){
                             if( value!.isEmpty){return 'Required UserName';}
                             else  if (value.length < 4)
                              return 'userName must be more 4 letters';
                          },
                          decoration: kFieldTextStyle(context).copyWith(
                              hintText: 'Enter Your UserName',
                              prefixIcon: Icon(Icons.person)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        /// Text Field for Email
                        TextFormField(
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kFieldTextStyle(context).copyWith(
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(Icons.email)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        /// Text Field for Password
                        TextFormField(
                          controller: _password1Controller,

                          ///check password is not empty and less than 6 letters
                          validator: (value) {
                            if (value!.isEmpty) return 'Required Password';
                            if (value.length < 6)
                              return 'Password must be more 6 letters';
                            return null;
                          },
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
                              prefixIcon: Icon(Icons.lock)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        /// Text Field for confirm Password
                        TextFormField(
                          validator: (value) {
                            /// check password is not equal zero (empty)
                            if (value != _password1Controller.text)
                              return 'Not Match';
                          },
                          onChanged: (value) {
                            /// check Password match
                            if (value == _password1Controller.text) {
                              setState(() {
                                _icon = Icon(
                                  Icons.check,
                                  color: Colors.green,
                                );
                              });
                            } else {
                              setState(() {
                                _icon = Icon(
                                  Icons.close,
                                  color: Colors.red,
                                );
                              });
                            }
                          },
                          obscureText: !visibility,
                          decoration: kFieldTextStyle(context).copyWith(
                            suffix: _icon,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visibility = !visibility;
                                  });
                                },
                                icon: visibility
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            hintText: 'Enter Your Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        ///button for sign up
                        SizedBox(
                          height: 50,
                          child: reusedButton(
                            nameButton: 'Sign Up',
                            onPress: () async {
                              /// check userName and email are unique
                              await  checkUserName(_userNameController.text);
                              await checkUserEmail(_emailController.text);
                              if(resultUserEmail!=0&&resultUserName!=0)
                              {
                                buildSnackBar(context,'UserName and Email are exist ');
                              }
                              else if(resultUserName!=0) {
                                buildSnackBar(context,'UserName is exist ');
                              }
                              else if(resultUserEmail!=0)
                              {
                                buildSnackBar(context,'Email is exist ');
                              }
                              else if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> userInfo = {
                                  'name': _userNameController.text,
                                  "email": _emailController.text,
                                };
                                /// save my data to Shared Preferences
                                SharedPreferencesDatabase.saveUserEmailKey(
                                    _emailController.text);
                                SharedPreferencesDatabase.saveUserNameKey(
                                    _userNameController.text);
                                authFirebaseMethods
                                    .signUp(context, _emailController.text,
                                        _password1Controller.text)
                                    .then((value) {
                                  SharedPreferencesDatabase.saveUserLoggedInKey(false);
                                  fireStoreDatabaseMethods
                                      .upLoadProfile(userInfo);
                                  Navigator.of(context)
                                      .pushReplacementNamed(ChatList.id);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
