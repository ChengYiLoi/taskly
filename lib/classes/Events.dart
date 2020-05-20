import 'package:flutter/material.dart';
import 'package:taskly/components/Event.dart';

class Events with ChangeNotifier{
  // Map<String, Widget> events = {
  //   'first': StatelessColorfulTile(UniqueKey()),
  //  'second' : StatelessColorfulTile(UniqueKey())
  // };
  Map<String, Widget> events = {};
  // List<Widget> events= [StatelessColorfulTile(UniqueKey()),StatelessColorfulTile(UniqueKey())];

  void add(eventDescription, time, notes) {
    events[eventDescription] = Event(eventDescription, time, notes);
    notifyListeners();
  }

  List<Widget> getEvents() {
    // List<Widget> eventList = [];
    // events.forEach((key, value) => eventList.add(value));
    // return eventList;
    List<Widget> eventList = events.values.toList();

    return eventList;
    
  }

  void remove(eventDescription) {
    // events.insert(1, events.removeAt(0));
    // var placeholder;
    // var placeholder = events['first'];
    // events['first'] = events['second'];
    // events['second'] = placeholder;
    events.remove(eventDescription);
    notifyListeners();
  }
}
