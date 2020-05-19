import 'package:flutter/material.dart';
import 'package:taskly/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskly/components/EventInput.dart';
import 'package:taskly/components/EventNotes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


var eventDescription = 'What is the event?';

class EventBottomSheet extends StatefulWidget {
  EventBottomSheet(this.createEvent);
  final Function createEvent;
  

  @override
  _EventBottomSheetState createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends State<EventBottomSheet> {
  final Widget clock = SvgPicture.asset('images/clock.svg');

  final Widget pencil = SvgPicture.asset('images/pencil.svg');

  final TextEditingController eventDescriptionController =
      TextEditingController();
  List notes = [];

  @override
  void dispose(){
    eventDescriptionController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
   
    var time = TimeOfDay.now().format(context);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      void setTime() async {
        //updates the selected time
        var result = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        setModalState(() {
          if (result != null) {
            time = result.format(context);
          }
        });
      }

      void displayAlertBox() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController noteController = TextEditingController();
              return AlertDialog(
                title: Center(
                  child: Text('Note'),
                ),
                content: TextField(
                  controller: noteController,
                  autofocus: true,
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  FlatButton(
                      onPressed: () {
                        setModalState(() {
                          notes.add(noteController.text.toString());
                          print(notes);
                        });

                        Navigator.pop(context);
                      },
                      child: Text('Add')),
                ],
              );
            });
      }

      return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Stack(children: <Widget>[
          Positioned.fill(
            top: 35,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    //emoji selector
                  

                    //event text
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {},
                          child: TextField(
                            controller: eventDescriptionController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'What is the event?'),
                          ),
                        ),
                      ),
                    ),
                    //time selector
                    EventInput(clock, 'Set a time', time,
                        setTime), //icon , inputDisplay, function
                    EventInput(pencil, 'Add notes', 'Add +', displayAlertBox),
                    notes.length > 0
                        ? EventNotes(notes)
                        : SizedBox(),

                    // note adder

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 40),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: lightYellow,
                        onPressed: () => widget.createEvent(
                            eventDescriptionController.text, time, notes),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Create event',
                            style: mainActionButtonText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  shape: CircleBorder(),
                  color: lightYellow,
                  onPressed: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      FontAwesomeIcons.times,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
