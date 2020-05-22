import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
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
    final String currentDate =
        widget._formattedDate.format(widget.date) + ' ' + widget.date.day.toString();
    events = Provider.of<Events>(context, listen: false);
   
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SafeArea(
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
                          child: SingleChildScrollView(
                            child: Column(children: events.getEvents()),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                        child: Center(
                          child: Text('You have no events today',style: scheduleTitleText),
                        ),
                      )),
              ],
            ),
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
            FloatingActionButtonLocation.centerDocked);
  }
}

// Consumer<Events>(
//                               builder: (_, events, __) => Expanded(
//                                 flex: 6,
//                                 child: ListView.builder(
//                                   itemCount: events.events.length,
//                                   itemBuilder: (BuildContext context, int index){
//                                     List eventKeys = events.events.keys.toList();
//                                     return events.events[eventKeys[index]];
//                                   },
//                                 ),
//                               ),
//                             )
