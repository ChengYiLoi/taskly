import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskly/classes/User.dart';
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
              builders:
                  buildCalendarBuilders(), // builder property allows you to make your own customized widgets
            ),
          )
        ],
      )),
    );
  }

  CalendarBuilders buildCalendarBuilders() {
    return CalendarBuilders(
      dayBuilder: (context, date, events) {
        String formatDate = date.day.toString() +
            date.month.toString() +
            date.year.toString(); // DDMMYYYY
        User user = Provider.of<User>(context);
        Map datesWithEvents = user.getDatesWithEvents();
      
          return Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: (date.day == DateTime.now().day && date.month == DateTime.now().month ) ? BoxDecoration(
                          color: lightYellow, shape: BoxShape.circle) : null,
                      child: Center(child: Text(date.day.toString())),
                    ),
                  ),
                ),
                (datesWithEvents.keys.contains(formatDate) && datesWithEvents[formatDate].getLength() > 0 ) ?
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: grey, shape: BoxShape.rectangle)),
                ) : SizedBox()
              ],
            ),
          );
         
        return Center(child: Text(date.day.toString()));
      },
    );
  }
}
