import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
import 'package:taskly/constants.dart';
import 'eventDeleteButton.dart';
import 'eventEditButton.dart';
import 'modalBottomSheet.dart';

class Event extends StatefulWidget {
  final String _eventDescription;
  final TimeOfDay _time;
  final List _notes;
  final Key _key;
  Event(this._eventDescription, this._time, this._notes, this._key)
      : super(key: _key);

  String getDescription() => _eventDescription;
  TimeOfDay getTime() => _time;
  List getNotes() => _notes;
  Key getKey() => _key;

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  Events events;

  @override
  Widget build(BuildContext context) {
    Events events = Provider.of<Events>(context, listen: false);
    void updateEvent(currentDescription, newDescription, time, notes) {
      Key key = widget._key;
      events.update(key,newDescription ,Event(newDescription, time, notes, key));
    
    }

    List<Widget> textNotes = widget._notes
        .map((note) => SizedBox(
            height: 20,
            child: Row(children: <Widget>[
              SizedBox(
                width: 20,
                child: bullet,
              ),
              Expanded(child: Text(note))
            ])))
        .toList(); // maps through the notes array to return a list of row widgets

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Slidable(
        actionExtentRatio: 0.15,
        actionPane: SlidableBehindActionPane(),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      Event currentEvent = events.events[widget._key.toString()];

                      return EventBottomSheet(
                          mainFunction: updateEvent,
                          type: 'update',
                          event: currentEvent
                         );
                    });
              },
              child: eventEditButton())
        ],
        secondaryActions: <Widget>[
          GestureDetector(// removes the selected event
              onTap: () {
                events.remove(widget._key.toString());
              },
              child: eventDeleteButton())
        ],
        child: Container(
          decoration: eventContainer,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Expanded(
                        child:
                            Text(widget._eventDescription, style: eventTitle),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            widget._time.format(context),
                            style: eventTime,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  widget._notes.length > 0
                      ? Column(
                          children: textNotes,
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// void flipAnimation() {
//   if (!_displayEventOption) {
//     eventOptionsAnimationController.forward();
//     setState(() {
//       _displayEventOption = !_displayEventOption;
//     });
//   } else {
//     eventOptionsAnimationController.reverse();
//     Timer(animationDuration, () {
//       setState(() {
//         _displayEventOption = !_displayEventOption;
//       });
//     });
//   }
// }
