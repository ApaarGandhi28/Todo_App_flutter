import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './todopage.dart';
import './weekly_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.red[600],
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                fontFamily: 'Voltaire',
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
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
      routes: {
        'weekly_screen': (ctx) => WeeklyScreen(),
      },
    );
  }
}
// Add Splash Screen , Launch Icons and Notifications Icons --> Done
// Swipe Left To Mark a Task Completed --> Dissmissible Added
// Notifications and Alarms --> Local Notifications Added.
// Sort the List on each event. --> List Sorted on basis of DateTime.
// Shared Prefrences --> Finally Added
// Image if List is Empty --> Added
// Weekly Screen --> Added
