import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Container(
          child: RaisedButton(onPressed: (){
            Navigator.pop(context);
          },child: Text('Settings'),),
        ),
      ),
    );
  }
}
