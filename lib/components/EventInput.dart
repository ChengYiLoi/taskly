import 'package:flutter/material.dart';
import 'package:taskly/constants.dart';

class EventInput extends StatelessWidget {
  EventInput(
      this.icon, this.description, this.inputDisplay, this.inputFunction);
  final Widget icon;
  final String description;
  final String inputDisplay;
  final Function inputFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        inputFunction();
      },
      child: Padding(
        padding: eventInputPadding,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: lightYellow,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(child: icon), // emoji image
                description != '' ? Expanded(
                  flex: 4,
                  child: Center(
                    child: Text(
                      description,
                      style: inputDescription,
                    ),
                  ),
                ) : SizedBox(),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        inputDisplay,
                        style: inputDescription,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
