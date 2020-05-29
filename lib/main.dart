import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/User.dart';
import 'package:taskly/constants.dart';
import 'classes/ThemeChanger.dart';
import 'screens/intro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(create: (_) => User()),
        ChangeNotifierProvider<ThemeChanger>(
            create: (_) => ThemeChanger(Brightness.light))
      ],
      child: Consumer<ThemeChanger>(
        builder: (context, themeChanger, child){
          return  MaterialApp(
          theme: ThemeData(
              fontFamily: 'LilitaOne',
              brightness: themeChanger.getTheme(),
              primaryColor: lightYellow,
              accentColor: lightYellow,
              bottomSheetTheme:
                  BottomSheetThemeData(modalBackgroundColor: Colors.transparent)),
          home: Intro(),
        );
        },
      ),
    );
  }
}

//  fontFamily: 'LilitaOne',

//             brightness: Brightness.dark,
//             primaryColor: lightYellow,
//             accentColor: lightYellow,
//             bottomSheetTheme: BottomSheetThemeData(
//               modalBackgroundColor: Colors.transparent,
