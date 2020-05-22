import 'package:flutter/material.dart';
import 'package:taskly/components/Event.dart';

class Events with ChangeNotifier {
  Map<String, Widget> events = {};

  List bubbleSort(List events) {
    int convertTime(time){
      dynamic result;
       String hour = time.substring(10, 12);
      String minute = time.substring(13,15);
      result = int.parse((hour+minute));
      
      return result;
    }
    if (events.length > 1) {
      for (var i = 0; i < events.length - 1; i++) {
        for (var j = 0; j < events.length - i - 1; j++) {
          int time1 = convertTime(events[j].getTime().toString());
         int time2 = convertTime(events[j + 1].getTime().toString()); 
          // print(time1.toString());
          // print(time2.toString());       
          if (time1 >= time2){
            
              Event placeholder = events[j + 1];
              events[j + 1] = events[j];
              events[j] = placeholder;
           
          }
        }
      }
    }
    // for(var i = 0; i < events.length; i ++){
    //   dynamic time = events[i].getTime().toString();
    //   String hour = time.substring(9, 12);
    //   String minute = time.substring(13,16);
    //   time = hour + minute;
    //   print(time);
    // }
    return events;
  }

  void add(eventDescription, time, notes) {
    Key key = UniqueKey();
    events[key.toString()] = Event(eventDescription, time, notes, key);
    notifyListeners();
  }

  void update(currentKey, newDescription, newEvent) {
    events[currentKey.toString()] = newEvent;
    notifyListeners();
  }

  List<Widget> getEvents() {
    List<Widget> eventList = events.values.toList();

    List<Widget> sortList = bubbleSort(eventList);

    return sortList;
  }

  void remove(key) {
    events.remove(key);
    notifyListeners();
  }
}
