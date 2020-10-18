import 'package:flutter/material.dart';

import './todopage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        accentColor: Colors.red[600],
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle( 
               fontFamily : 'Voltaire',
               fontSize: 20,
               fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TodoPage(),
    );
  }
}
// Swipe Left To Mark a Task Completed
//Pop Up Screen on Delete press
//Sort the List on each event.
//Notifications and Alarms
// Shared Prefrences
// Image if List is Empty