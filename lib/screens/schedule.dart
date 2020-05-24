import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
import 'package:taskly/classes/User.dart';
import 'package:taskly/constants.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly/components/modalBottomSheet.dart';
import 'package:taskly/components/bottomAppBar.dart';

class Schedule extends StatefulWidget {
  final DateFormat _formattedDate = DateFormat('EEEE');
  final date = DateTime.now();

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  Events events;

  @override
  Widget build(BuildContext context) {
    final String currentFullDate = widget.date.day.toString() +
        widget.date.month.toString() +
        widget.date.year.toString();
    final String currentDate = widget._formattedDate.format(widget.date) +
        ' ' +
        widget.date.day.toString();

    User user = Provider.of<User>(context);

    if (user.scheduleExist(currentFullDate)) {
      events = user.getSchedule(currentFullDate);
    } else {
      user.createSchedule(currentFullDate);
      events = user.getSchedule(currentFullDate);
    }

    void createEvent(String eventDescription, time, List notes) {
      setState(() {
        if (eventDescription != '') {
          events.add(eventDescription, time, notes);
          Navigator.pop(context);
        }
      });
    }

    void displayBottomSheet() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return EventBottomSheet(mainFunction: createEvent, type: 'create');
          });
    }

    return ChangeNotifierProvider<Events>(
      create: (context) => events,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SafeArea(
              child: Consumer<Events>(builder: (_, events, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Today\'s schedule',
                      style: scheduleTitleText,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      currentDate,
                      style: scheduleDate,
                    ),
                    events.events.length > 0
                        ? Expanded(
                            child: SingleChildScrollView(
                                child: Column(children: events.getEvents())),
                          )
                        : Expanded(
                            child: Container(
                            child: Center(
                              child: Text('You have no events today',
                                  style: scheduleTitleText),
                            ),
                          )),
                  ],
                );
              }),
            ),
          ),
          bottomNavigationBar: BuildBottomAppBar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: lightYellow,
            onPressed: () => displayBottomSheet(),
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked),
    );
  }
}
