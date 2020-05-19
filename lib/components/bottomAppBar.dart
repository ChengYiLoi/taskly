import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly/screens/calender.dart';

class BuildBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Color(0xFFB1BCC7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Calender()));
              },
              icon: FaIcon(FontAwesomeIcons.calendarAlt), // calender
            ),
            IconButton(
              onPressed: () {},
              icon: FaIcon(FontAwesomeIcons.clock), // clock
            )
          ],
        ),
      ),
    );
  }
}