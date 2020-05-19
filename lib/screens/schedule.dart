import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
import 'package:taskly/constants.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:taskly/components/modalBottomSheet.dart';
import 'package:taskly/components/bottomAppBar.dart';

var date = DateTime.now();
DateFormat formattedDate = DateFormat('EEEE');

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<Events>(context, listen: false);
    String currentDate = formattedDate.format(date) + ' ' + date.day.toString();

    void createEvent(String eventDescription, time, List notes) {
      setState(() {
        if (eventDescription != '') {
          events.add(eventDescription, time, notes);
          Navigator.pop(context);
        }
      });
    }

    void onButtonPressed() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return EventBottomSheet(createEvent);
          });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
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
                          ? Consumer<Events>(
                              builder: (_, events, __) => Expanded(
                                  flex: 6,
                                  child: ListView.builder(
                                      itemCount: events.events.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        String key =
                                            events.events.keys.elementAt(index);
                                        return Dismissible(key: UniqueKey(), child: events.events[key]);
                                      })),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BuildBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: lightYellow,
          onPressed: () => onButtonPressed(),
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }
}
