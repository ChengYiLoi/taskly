import 'package:flutter/cupertino.dart';
import 'package:taskly/components/Event.dart';

class Events with ChangeNotifier{
  Map events = {};

  void add(eventDescription, time, notes){

    events[eventDescription] = Event(eventDescription, time, notes);
    notifyListeners();
  }
  void remove(eventDescription){
    

    events.remove(eventDescription);
    notifyListeners();
  }
}