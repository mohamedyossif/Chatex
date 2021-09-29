import 'package:flutter/material.dart';

Widget getIconButton(IconData iconData, function, double width) {
  return IconButton(
    icon: Icon(
      iconData,
      size: 37,
    ),
    onPressed: function,
  );
}
