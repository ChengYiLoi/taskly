import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
import 'package:taskly/constants.dart';
import 'eventDeleteButton.dart';
import 'eventEditButton.dart';

class Event extends StatefulWidget {
  final String _eventDescription;
  final String _time;
  final List _notes;
  Event(this._eventDescription, this._time, this._notes)
      : super(key: ValueKey(_eventDescription));

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  Color myColor;
  Events events;

  @override
  Widget build(BuildContext context) {
    events = Provider.of<Events>(context);
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
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Slidable(
        actionExtentRatio: 0.15,
        actionPane: SlidableBehindActionPane(),
        actions: <Widget>[eventEditButton()],
        secondaryActions: <Widget>[
          GestureDetector(
              onTap: () {
                events.remove(widget._eventDescription);
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
                            widget._time,
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
