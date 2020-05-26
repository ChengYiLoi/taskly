import 'package:flutter/material.dart';
import 'Events.dart';

class User with ChangeNotifier {
  Map<String, Events> datesWithEvents = {};

  void createFutureEvent() {
    Events futureEvent = Events(DateTime.now().add(Duration(days: 2)));
    futureEvent.add('smoke weed', TimeOfDay.now(), ['smoke', 'weed']);
    DateTime date = futureEvent.getInitializedDate();
    datesWithEvents[date.day.toString() +
        date.month.toString() +
        date.year.toString()] = futureEvent;
    print('created future event');
  }

  Map getDatesWithEvents() {
    return datesWithEvents;
  }

  bool scheduleExist(DateTime date) {
    // currentDate is in DDMMYYYY format
     String dateString = date.day.toString() + date.month.toString() + date.year.toString(); 
    if (datesWithEvents.keys.contains(dateString)) {
      return true;
    }
    return false;
  }

  void createSchedule(DateTime date, Events events) {
     String dateString = date.day.toString() + date.month.toString() + date.year.toString(); 
    datesWithEvents[dateString] = events;
    notifyListeners();
  }

  Events getSchedule(DateTime date) {
     String dateString = date.day.toString() + date.month.toString() + date.year.toString(); 
    return datesWithEvents[dateString];
  }

  void removeSchedule(DateTime date) {
    String dateString = date.day.toString() + date.month.toString() + date.year.toString(); 
    print(datesWithEvents);
    datesWithEvents.remove(dateString);
    print(datesWithEvents);
    notifyListeners();
  }
}
