import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/ThemeChanger.dart';
import 'package:taskly/constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched;

  @override
  void initState() {
    isSwitched = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger =
        Provider.of<ThemeChanger>(context, listen: false);
    void toggleTheme(value) {
      setState(() {
     
      
        if ( value) {
          themeChanger.setTheme(Brightness.dark);
         
          isSwitched = !isSwitched;
        } else {
          themeChanger.setTheme(Brightness.light);
        
          isSwitched = !isSwitched;
          
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Toggle theme'),
                  Switch(value: isSwitched, 
              onChanged: (value) => toggleTheme(value),
              inactiveThumbColor: lightYellow,
              activeColor: darkGrey,
              )
              ],),
             SizedBox(height: 50,),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              )
             
            ],
          )),
        ),
      ),
    );
  }
}
