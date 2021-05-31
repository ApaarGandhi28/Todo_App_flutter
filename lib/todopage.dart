import 'package:TODO/weekly_screen.dart';
import 'package:flutter/material.dart';
import './models/info.dart';
import './listElement.dart';
import './addtask.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './newScreen.dart';
import './providers/task.dart';
import './no_elements.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return WeeklyScreen();
    }));
  }

  Future<void> scheduleNotification(
      int i, String boldMsg, String msg, DateTime date) async {
    var scheduledNotificationDateTime = date;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      priority: Priority.High,
      importance: Importance.Max,
      color: Colors.blue,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(i, boldMsg, msg,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  showNotification(String boldMsg, String msg) async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.High, importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, boldMsg, msg, platform,
        payload: 'Welcome to the Local Notification demo');
  }

  void initState() {
    super.initState();
    _getSavedList();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  static String encode(List<Info> musics) => jsonEncode(
        musics.map<Map<String, dynamic>>((music) => Info.toMap(music)).toList(),
      );

  static List<Info> decode(String musics) =>
      (jsonDecode(musics) as List<dynamic>)
          .map<Info>((item) => Info.fromJson(item))
          .toList();

  _saveList(List<Info> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    String list = encode(userInfo);
    prefs.setString('key', list);
  }

  _getSavedList() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("key") != null) {
      userInfo = decode(prefs.getString('key'));
    }
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  _saveList(userInfo);
                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _addTask(String id, String title, DateTime dd, TimeOfDay tt) {
    setState(() {
      userInfo.add(Info(id: id, title: title, date: dd, time: tt));
      userInfo.sort((a, b) => a.date
          .add(Duration(hours: a.time.hour, minutes: a.time.minute))
          .compareTo(b.date
              .add(Duration(hours: b.time.hour, minutes: b.time.minute))));
    });
    _saveList(userInfo);
  }

  void addButton(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: AddTask(_addTask, scheduleNotification),
            onTap: () {},
          );
        });
  }

  void editTask(String id, String text, DateTime date, TimeOfDay time) {
    int idx = userInfo.indexWhere((element) => element.id == id);
    setState(() {
      userInfo.replaceRange(
          idx, idx + 1, [Info(id: id, title: text, date: date, time: time)]);
      userInfo.sort((a, b) => a.date
          .add(Duration(hours: a.time.hour, minutes: a.time.minute))
          .compareTo(b.date
              .add(Duration(hours: b.time.hour, minutes: b.time.minute))));
    });
    _saveList(userInfo);
  }

  void deleteTask(String id) {
    setState(() {
      userInfo.removeWhere((user) => user.id == id);
      userInfo.sort((a, b) => a.date
          .add(Duration(hours: a.time.hour, minutes: a.time.minute))
          .compareTo(b.date
              .add(Duration(hours: b.time.hour, minutes: b.time.minute))));
    });
    _saveList(userInfo);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(' To-Do List App'),
          // primary: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.view_day,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('weekly_screen');
              },
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple[50],
        body: userInfo.isEmpty
            ? NoElements()
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return ListElement(userInfo[index], editTask, deleteTask);
                    },
                    itemCount: userInfo.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            addButton(context);
          },
          elevation: 10,
        ),
      ),
    );
  }
}
