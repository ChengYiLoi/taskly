import 'package:flutter/material.dart';
import 'Events.dart';

class User with ChangeNotifier{
  Map <String, Events> datesWithEvents = {};

  void createFutureEvent(){
    Events futureEvent = Events();
    futureEvent.add('smoke weed', TimeOfDay.now(), ['smoke', 'weed']);
    datesWithEvents['2952020'] = futureEvent;
    print('created future event');
  }

  Map getDatesWithEvents(){
    return datesWithEvents;
  }

  bool scheduleExist(currentDate){
    if(datesWithEvents.keys.contains(currentDate)){
      return true;
    }
    return false;


  }
  void createSchedule(date){
    datesWithEvents[date] = Events();
    notifyListeners();
  }

  Events getSchedule(date) {
    
    return datesWithEvents[date];
  }


}