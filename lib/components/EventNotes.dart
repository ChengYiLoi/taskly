import 'package:flutter/material.dart';
import 'package:taskly/constants.dart';

class EventNotes extends StatelessWidget {
  EventNotes(this.notes);

  final List notes;

  @override
  Widget build(BuildContext context) {
    List<Widget> notesList = notes
        .map(
          (note) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                bullet,
                SizedBox(width: 6,),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      note,
                      style: noteText,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
        .toList();
    return Padding(
      padding: eventInputPadding,
      child: Container(
          decoration: BoxDecoration(
              color: grey, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: notesList,
          )),
    );
  }
}

// ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: notes.length,
//           itemBuilder: (BuildContext context, int index) {
//             return IntrinsicHeight(
//               child: SizedBox(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,

//                   children: <Widget>[
//                     bullet,
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                                               child: Text(
//                           notes[index],
//                           style: noteText,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
