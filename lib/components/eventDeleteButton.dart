import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


Widget eventDeleteButton() {

  return Container(
    decoration: BoxDecoration(
        color: Colors.orange[200],
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
    child: Align(
      alignment: Alignment.center,
      child: Icon(
        FontAwesomeIcons.trash,
        color: Colors.redAccent[200],
        size: 20,
      ),
    ),
  );
}
