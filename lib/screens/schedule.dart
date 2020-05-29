import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
import 'package:taskly/classes/User.dart';
import 'package:taskly/constants.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly/components/modalBottomSheet.dart';
import 'package:taskly/components/bottomAppBar.dart';
import 'package:taskly/screens/eventReminder.dart';
import 'package:taskly/screens/settings.dart';

class Schedule extends StatefulWidget {
  final DateFormat _formattedDate = DateFormat('EEEE');
  final DateTime _date;

  Schedule(this._date);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  Events events;

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  @override
  void initState() {
    initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EventReminder()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('test test'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user.scheduleExist(widget._date)) {
      events = user.getSchedule(widget._date);
    } else {
      events = Events(DateTime.now());
    }
    final String currentDate = widget._formattedDate.format(widget._date) +
        ' ' +
        widget._date.day.toString();

    void createEvent(String eventDescription, time, List notes) {
      if (events.getLength() == 0) {
        user.createSchedule(widget._date, events);
      }

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
            return EventBottomSheet(
              mainFunction: createEvent,
              type: 'create',
              notificationsPlugin: notificationsPlugin,
            );
          });
    }

    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('Do you want to exit the App?'),
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
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: events,
        ),
        ChangeNotifierProvider.value(
          value: user,
        )
      ],
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SafeArea(
                child: Consumer<Events>(builder: (_, events, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Title(
                        color: Colors.white,
                        child: Text(
                          widget._date.day == DateTime.now().day
                              ? 'Today\'s schedule'
                              : 'Schedule for',
                          style: scheduleTitleText,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        currentDate,
                        style: scheduleDate,
                      ),
                      events.getLength() > 0
                          ? Expanded(
                              child: SingleChildScrollView(
                                  child: MultiProvider(
                                providers: [
                                  Provider<DateTime>(
                                    create: (context) => widget._date,
                                  ),
                                  Provider<FlutterLocalNotificationsPlugin>(
                                    create: (context) => notificationsPlugin,
                                  )
                                ],
                                child: Column(children: events.getEvents()),
                              )),
                            )
                          : Expanded(
                              child: Container(
                              child: Center(
                                child: Text(
                                    widget._date.day == DateTime.now().day
                                        ? 'You have no events today'
                                        : 'No events planned',
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
      ),
    );
  }
}
