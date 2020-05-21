import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget eventEditButton() {
  return Container(
  decoration: BoxDecoration(
      color: Colors.teal[400],
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
  child: Align(
    alignment: Alignment.center,
    child: Icon(
      FontAwesomeIcons.edit,
      color: Colors.white,
      size: 20,
    ),
  ),
    );
}
