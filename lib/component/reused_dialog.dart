import 'package:flutter/material.dart';

reusedDialog(context, messege) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Text(messege),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('OK'))
          ],
        );
      });
}
