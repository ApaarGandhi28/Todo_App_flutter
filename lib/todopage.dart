import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/info.dart';
import './listElement.dart';
import './addtask.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
   List<Info> userInfo = [
    Info(
      DateTime.now().toString(),
      'Coding',
      DateTime.now(),
      TimeOfDay.now(),
    ),
    Info(
      DateTime.now().toString(),
      'Reading Books ',
      DateTime.now(),
      TimeOfDay.now(),
    ),
  ];

  void _addTask(String id, String title, DateTime dd, TimeOfDay tt) {
    setState(() {
      userInfo.add(Info(id, title, dd, tt));
    });
  }

  void addButton(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: AddTask(_addTask),
            onTap: () {},
          );
        });
  }
   
   void editTask(String id,String text, DateTime date, TimeOfDay time){
     int idx = userInfo.indexWhere((element) => element.id == id);
     setState(() {
     userInfo.replaceRange(idx, idx+1,[ Info(id,text,date, time)]);  
     });
   }
   
   void deleteTask(String id){
     setState(() {
     userInfo.removeWhere((user) => user.id == id);  
     });
     
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' TODO List App'),
        // primary: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_box,
              color: Colors.black,
            ),
            onPressed: () {
              addButton(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.amber[100],
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return ListElement(
                  userInfo[index],editTask,deleteTask);
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
    );
  }
}
