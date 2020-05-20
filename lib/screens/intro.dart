import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/classes/Events.dart';
import 'package:taskly/constants.dart';
import 'package:taskly/screens/schedule.dart';

class IntroPage extends StatelessWidget {
  final String bottomIllustration = 'images/mainPageIllustration.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Life is a mess',
                      style: mainScreenTitleText,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Planning daily work has never been so easy',
                      style: descriptionText,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: lightYellow,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider<Events>(
                              create: (context) => Events(),
                              child: Schedule(),
                            )),
                          );
                        },
                        child: Text(
                          'Login',
                          style: mainActionButtonText,
                        ),
                      )),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image(
                    image: AssetImage('images/mainPageIllustration.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
