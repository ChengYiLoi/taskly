import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
import 'package:taskly/constants.dart';
import 'dart:async';
import 'dart:math';

class Event extends StatefulWidget {
  Event(this._eventDescription, this._time, this._notes);
  final String _eventDescription;
  final String _time;
  final List _notes;

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> with TickerProviderStateMixin {
  AnimationController eventOptionsAnimationController;
  Animation rotateAnimation;
  Duration animationDuration = Duration(milliseconds: 200);
  bool _displayEventOption;

  @override
  void initState() {
    super.initState();
    eventOptionsAnimationController =
        AnimationController(duration: animationDuration, vsync: this);
    rotateAnimation = Tween<double>(begin: 0.25, end: 0.0).animate(
        CurvedAnimation(
            parent: eventOptionsAnimationController, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    _displayEventOption = false;
      
  }

  Widget build(BuildContext context) {
    void flipAnimation() {
      if (!_displayEventOption) {
        eventOptionsAnimationController.forward();
        setState(() {
          _displayEventOption = !_displayEventOption;
        });
      } else {
        eventOptionsAnimationController.reverse();
        Timer(animationDuration, () {
          setState(() {
            _displayEventOption = !_displayEventOption;
          });
        });
      }
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
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          flipAnimation();
        },
        child: Container(
          decoration: eventContainer,
          child: IntrinsicHeight(
            child: Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Expanded(
                            child: Text(widget._eventDescription,
                                style: eventTitle),
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
                      Column(
                        children: textNotes,
                      )
                    ],
                  ),
                ),
              ),

              _displayEventOption
                  ? Transform(
                      alignment: FractionalOffset.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.006)
                        ..rotateX(2 * pi * rotateAnimation.value),
                      child: Container(
                          decoration: BoxDecoration(
                              color: lightYellow,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    print(_displayEventOption);
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.edit,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Consumer<Events>(
                                  builder: (_, events, __) => IconButton(
                                      icon: FaIcon(
                                        FontAwesomeIcons.trash,
                                        color: Colors.redAccent[200],
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        events.remove(widget._eventDescription);
                                      }),
                                ),
                              )
                            ],
                          )),
                    )
                  : SizedBox()

              // : SizedBox()
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    eventOptionsAnimationController.dispose();
    super.dispose();
  }
}
