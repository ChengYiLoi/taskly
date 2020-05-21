import 'package:flutter/material.dart';
import 'package:taskly/components/Event.dart';

class Events with ChangeNotifier {
  Map<String, Widget> events = {};

  List bubbleSort(List events){
   if(events.length > 1){
      for(var i = 0; i < events.length-1; i++){
      for(var j = 0; j < events.length-i-1; j++){
        TimeOfDay time1 = events[j].getTime();
        TimeOfDay time2 = events[j+1].getTime();
        if(time1.hour > time2.hour){
         
          Event placeholder = events[j+1];
          events[j+1] = events[j];
          events[j] = placeholder;
         

        }
      }
    }
   }
    return events;
  }
  
  void add(eventDescription, time, notes) {
    Key key = UniqueKey();
    events[key.toString()] = Event(eventDescription, time, notes, key);
    notifyListeners();
  }
  void update(currentKey,newDescription ,newEvent){
    events[currentKey.toString()] = newEvent;
    notifyListeners();
  }

  List<Widget> getEvents() {
    List<Widget> eventList = events.values.toList();
    List<Widget>sortList = bubbleSort(eventList);

    return sortList;
  }

  void remove(eventDescription) {
    events.remove(eventDescription);
    notifyListeners();
  }
}
