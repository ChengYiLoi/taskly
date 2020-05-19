import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskly/constants.dart';

List myDates = ['2020-06-21 12:00:00.000Z', '2020-06-25 12:00:00.000Z'];

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarController _controller;
  @override
  Widget build(BuildContext context) {
    _controller = CalendarController();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
              child: TableCalendar(
            calendarController: _controller,
            startingDayOfWeek: StartingDayOfWeek.monday,
            builders: buildCalendarBuilders(), // builder property allows you to make your own customized widgets
          ),)
          
        ],
      )),
    );
  }


  CalendarBuilders buildCalendarBuilders() {
    return CalendarBuilders( 
           dayBuilder: (context, date, events) {
             if(myDates.contains(date.toString())){
               return Text('poop');
             }
             else if(date.day == DateTime.now().day && date.month == DateTime.now().month) {
               return Container(
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                   color: lightYellow,
                   shape: BoxShape.circle
                 ),
                 child: Text(date.day.toString()),
               );
             }
             return Center(child: Text(date.day.toString()));
           }, 
            );
  }
}
