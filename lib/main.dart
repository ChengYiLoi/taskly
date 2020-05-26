import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/User.dart';
import 'package:taskly/constants.dart';
import 'screens/intro.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(create: (_) =>User()),
      ],
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'LilitaOne',
            primaryColor: lightYellow,
            accentColor: lightYellow,
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.transparent)),
        home: IntroPage(),
      ),
    );
  }
}
