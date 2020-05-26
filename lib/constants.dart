import 'package:flutter/material.dart';

const Color lightYellow = Color(0xFFF8D57E);
const Color grey = Color(0xFFccced1);

const mainActionButtonText = TextStyle(fontSize: 26);

const mainScreenTitleText = TextStyle(color: Colors.black, fontSize: 50.0);
const descriptionText = TextStyle(color: Color(0xFF959595), fontSize: 16);

const scheduleTitleText = TextStyle(fontSize: 28);
const scheduleDate = TextStyle(color: lightYellow, fontSize: 28);

const noteText = TextStyle(fontSize: 16);

const inputDescription = TextStyle(fontSize: 22);

const eventInputPadding = EdgeInsets.symmetric(horizontal: 30, vertical: 10);

BoxDecoration eventContainer =
    BoxDecoration( color: grey);

Container bullet = Container(height: 10, width: 10, padding: EdgeInsets.all(8.0), decoration: BoxDecoration(shape: BoxShape.circle, color: lightYellow),);

const eventTitle = TextStyle(fontSize: 30);
const eventTime = TextStyle(fontSize: 20);

const calendarButtonText = TextStyle(fontSize: 20);

const alertDialogbuttonText = TextStyle(fontSize:  20);
const alertDialogOptionsPadding = EdgeInsets.all(10.0);
