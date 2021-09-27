import 'package:chat_app/utilities/constant.dart';
import 'package:flutter/material.dart';
reusedDeleteDialog(context, String chatRoomId ) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete contact'),
          content: Text('Are You Sure..?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('No')),
            TextButton(
                onPressed: () {
                  fireStoreDatabaseMethods.deleteContact(chatRoomId);
                  Navigator.pop(context);

                }, child: Text('Yes')),
          ],
        );
      });
}