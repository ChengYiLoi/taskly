import 'package:flutter/material.dart';

class EventReminder extends StatelessWidget {
  // EventReminder(this._event );
  // final Event _event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('event Reminder'),
          ),
        ),
      ),
    );
  }
}
