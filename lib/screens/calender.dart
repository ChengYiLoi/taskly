import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskly/classes/User.dart';
import 'package:taskly/constants.dart';
import 'package:taskly/screens/schedule.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> with TickerProviderStateMixin {
  bool displayOptions;
  bool scheduleExist = false;
  DateTime selectedDate;
  AnimationController _animationController;
  CalendarController _controller =
      CalendarController(); // dont put in initState
  @override
  void initState() {
    super.initState();
    displayOptions = false;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void popNavigation() {
    Navigator.pop(context);
  }

  Future<bool> deleteEventConfirmation() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Are you sure?'),
              actions: <Widget>[
                Padding(
                  padding: alertDialogOptionsPadding,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text(
                      'No',
                      style: alertDialogbuttonText,
                    ),
                  ),
                ),
                Padding(
                  padding: alertDialogOptionsPadding,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Yes',
                      style: alertDialogbuttonText,
                    ),
                  ),
                )
              ],
            ));
  }

  void updateDisplayOptions(User user, DateTime date) {
    if (user.scheduleExist(date) && user.getSchedule(date).getLength() > 0) {
      print('Schedule found on $date');
      scheduleExist = true;
    } else {
      print('not Schedule found on $date');
      scheduleExist = false;
    }
    setState(() {
      displayOptions = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TableCalendar(
            rowHeight: MediaQuery.of(context).size.height * 0.13,
            calendarController: _controller,
            calendarStyle: CalendarStyle(markersColor: Colors.brown),
            onDaySelected: (date, events) {
              selectedDate = date;
              _animationController.forward(from: 0.0);
              updateDisplayOptions(user, date);
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            builders: buildCalendarBuilders(
                updateDisplayOptions), // builder property allows you to make your own customized widgets
          ),
          SizedBox(
            height: 20,
          ),
          displayOptions
              ? scheduleExist
                  ? Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                                color: lightYellow,
                                onPressed: () {
                                  popNavigation();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Schedule(selectedDate),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'View Schedule',
                                    style: calendarButtonText,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.red[300],
                              onPressed: () async {
                                bool result = await deleteEventConfirmation();
                                if (result) {
                                  setState(() {
                                    scheduleExist = false;
                                    user.removeSchedule(selectedDate);
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Delete Schedule',
                                  style: calendarButtonText,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : selectedDate.isAfter(DateTime.now())
                      ? Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              popNavigation();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Schedule(selectedDate),
                                ),
                              );
                            },
                            child: Text(
                              'Create Schedule',
                              style: calendarButtonText,
                            ),
                          ),
                        )
                      : SizedBox()
              : SizedBox()
        ],
      )),
    );
  }

  CalendarBuilders buildCalendarBuilders(Function updateDisplayOptions) {
    return CalendarBuilders(
      todayDayBuilder: (context, date, _) {
        String formatDate = date.day.toString() +
            date.month.toString() +
            date.year.toString(); // DDMMYYYY
        User user = Provider.of<User>(context);
        Map datesWithEvents = user.getDatesWithEvents();
        return Container(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: (date.day == DateTime.now().day &&
                              date.month == DateTime.now().month)
                          ? BoxDecoration(
                              color: lightYellow, shape: BoxShape.circle)
                          : null,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(date.day.toString())),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: (datesWithEvents.keys.contains(formatDate) &&
                            datesWithEvents[formatDate].getLength() > 0)
                        ? Container(
                            height: 5,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: grey, shape: BoxShape.rectangle))
                        : SizedBox())
              ],
            ));
      },
      selectedDayBuilder: (context, date, events) {
        String formatDate = date.day.toString() +
            date.month.toString() +
            date.year.toString(); // DDMMYYYY
        User user = Provider.of<User>(context);
        Map datesWithEvents = user.getDatesWithEvents();

        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          child: Container(
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            shape: BoxShape.circle),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(date.day.toString())),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: (datesWithEvents.keys.contains(formatDate) &&
                              datesWithEvents[formatDate].getLength() > 0)
                          ? Container(
                              height: 5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: grey, shape: BoxShape.rectangle))
                          : SizedBox())
                ],
              )),
        );
      },
      dayBuilder: (context, date, events) {
        String formatDate = date.day.toString() +
            date.month.toString() +
            date.year.toString(); // DDMMYYYY
        User user = Provider.of<User>(context);
        Map datesWithEvents = user.getDatesWithEvents();

        return Container(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: (date.day == DateTime.now().day &&
                              date.month == DateTime.now().month)
                          ? BoxDecoration(
                              color: lightYellow, shape: BoxShape.circle)
                          : null,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(date.day.toString())),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: (datesWithEvents.keys.contains(formatDate) &&
                            datesWithEvents[formatDate].getLength() > 0)
                        ? Container(
                            height: 5,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: grey, shape: BoxShape.rectangle))
                        : SizedBox())
              ],
            ));
      },
    );
  }
}
