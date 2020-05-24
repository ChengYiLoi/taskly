import 'package:flutter/material.dart';
import 'package:taskly/components/Event.dart';
import 'package:taskly/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskly/components/EventInput.dart';
import 'package:taskly/components/EventNotes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventBottomSheet extends StatefulWidget {
  EventBottomSheet(
      {@required this.mainFunction, @required this.type, this.event});
  final Function mainFunction;
  final String type;
  final Event event;
  final Widget clock = SvgPicture.asset('images/clock.svg');
  final Widget pencil = SvgPicture.asset('images/pencil.svg');

  @override
  _EventBottomSheetState createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends State<EventBottomSheet> {
  var eventDescription = 'What is the event?';
  ScrollController _scrollController;
  List notes;
  final TextEditingController eventDescriptionController =
      TextEditingController();
  
  TimeOfDay time;
  double topValue;
  BorderRadius buttonRadius;
  @override
  void initState() {
    super.initState();
    topValue = 30;
    buttonRadius = BorderRadius.all(Radius.circular(50));
    _scrollController = ScrollController()..addListener(updateSelector);
    notes =  widget.type == 'create' ? [] : widget.event.getNotes();
    if (widget.type == 'update') {
      eventDescriptionController..text = widget.event.getDescription();
    }
    time = widget.type == 'create' ? TimeOfDay.now() : widget.event.getTime();
  }

  updateSelector() {
    var scrollValue = _scrollController.offset.round();
    print(scrollValue);
 
      if (scrollValue >= 25) {
        topValue = 50;
        buttonRadius = BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
      } else {
        topValue = 30;
        buttonRadius = BorderRadius.all(Radius.circular(50));
      }
  
  }

  @override
  void dispose() {
    eventDescriptionController.dispose();

    super.dispose();
  }
  
  Widget build(BuildContext context) {
    
    void onButtonPressed() {
      if (widget.type == 'create') {
        widget.mainFunction(eventDescriptionController.text, time, notes);
      } else {
        Navigator.pop(context);
        String currentDescription = widget.event.getDescription();
        widget.mainFunction(
            currentDescription, eventDescriptionController.text, time, notes);
      }
    }
    void updateNotes(index){
      setState(() {
            notes.removeAt(index);
      });
  
    }

    void setTime() async {
      //updates the selected time
      var result =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      setState(() {
        if (result != null) {
          time = result;
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
                      setState(() {
                        notes.add(noteController.text.toString());
                      });

                      Navigator.pop(context);
                    },
                    child: Text('Add')),
              ],
            );
          });
    }

    return Container(
      height: MediaQuery.of(context).size.height *
          0.55, // obtains the device height and sets the container height to be 55% of the device height
      child: Stack(children: <Widget>[
        Positioned(
          child: AnimatedPadding(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            padding: EdgeInsets.only(top: topValue),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                color: Colors.white,
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: eventDescriptionController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'What is the event?'),
                        ),
                      ),
                    ),
                    //time selector
                    EventInput(widget.clock, 'Set a time', time.format(context),
                        setTime), //icon , inputDisplay, function
                    EventInput(
                        widget.pencil, 'Add notes', 'Add +', displayAlertBox),
                    widget.type == 'create'
                        ? (notes.length > 0 ? EventNotes(notes, updateNotes) : SizedBox())
                        : EventNotes(widget.event.getNotes(),updateNotes),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 40),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: lightYellow,
                        onPressed: () => onButtonPressed(),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.type == 'create'
                                ? 'Create event'
                                : 'Update event',
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
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(horizontal: 180),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: buttonRadius,
                
                color: lightYellow,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
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
  }
}
