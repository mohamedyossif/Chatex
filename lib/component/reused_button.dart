import 'package:flutter/material.dart';
Widget reusedButton({required nameButton,required  onPress})
{
  return ElevatedButton(
    child: Text(
      nameButton,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(Colors.green),
        shape:
        MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        )),
    onPressed: onPress,
  );
}
