import 'package:flutter/material.dart';

Widget getIconButton(IconData iconData, function, double width) {
  return Transform.translate(
    offset: Offset(width, 7),
    child: IconButton(
      icon: Icon(
        iconData,
        size: 37,
      ),
      onPressed: function,
    ),
  );
}