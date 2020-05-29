import 'package:flutter/material.dart';

class Reminder extends StatelessWidget {
  final String _description;
  Reminder(this._description);
  String getDescription() => _description;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
       Navigator.pop(context, _description);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(child: Text(_description)),
        ),
      ),
    );
  }
}
