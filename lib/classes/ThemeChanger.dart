import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
  Brightness _themeData;
  ThemeChanger(this._themeData);

  getTheme() {
    print(_themeData.toString());
    return _themeData;
  }

  setTheme(Brightness theme){
    _themeData = theme;
     notifyListeners();
  }
 
}