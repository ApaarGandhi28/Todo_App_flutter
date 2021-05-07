import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/info.dart';
import './providers/task.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeeklyScreen extends StatefulWidget {
  @override
  _WeeklyScreenState createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  @override
  bool _selected = false;
  int i = 0;

  List<Info> list(DateTime d) {
    List<Info> myList =
        userInfo.where((element) => element.date.day == d.day).toList();
    return myList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text(
          'Weekly Tasks',
          style: TextStyle(
            fontFamily: 'Voltaire',
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (ctx, index) => Column(
            children: [
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    '${DateFormat.MMMEd().format(DateTime.now().add(Duration(days: index)))}',
                    style: TextStyle(
                      fontFamily: 'Voltaire',
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  subtitle: Text(
                      '${list(DateTime.now().add(Duration(days: index))).length} Tasks Placed'),
                  hoverColor: Colors.green[700],
                  onTap: () {
                    setState(() {
                      _selected = !_selected;
                      i = index;
                    });
                  },
                ),
              ),
              if (_selected &&
                  list(DateTime.now().add(Duration(days: index))).isNotEmpty &&
                  i == index)
                Container(
                  decoration: BoxDecoration(
                    color:  Colors.yellow[100],
                    border: Border.all(
                      color: Colors.brown,
                      width: 2,
                    ),
                  ),
                  // color: Colors.yellow[100],
                  //   duration: Duration(
                  //     seconds: 5,
                  //   ),
                  //   curve: Curves.easeInBack,
                  height: 75,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount:
                        list(DateTime.now().add(Duration(days: index))).length,
                    itemBuilder: (context, i) => Row(
                      children: [
                        CircleAvatar(
                          radius: 4.5,
                          backgroundColor: Colors.black,
                        ),
                        Text(
                          '      ${list(DateTime.now().add(Duration(days: index))).elementAt(i).title}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
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
