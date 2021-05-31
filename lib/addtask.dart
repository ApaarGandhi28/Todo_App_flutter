import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  final Function ff;
  final Function notify;
  AddTask(this.ff,this.notify);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleController = TextEditingController();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  bool timeVal;
  bool dateVal;
  void datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: 30,
        ),
      ),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        print(_selectedDate);
        dateVal = true;
      });
    });
  }

   TimeOfDay fromString1(String str){
   str = str.substring(0,str.length-1);
   int i=0;
   while(str.codeUnitAt(i) < 48 || str.codeUnitAt(i) > 57){
    i++;
   }
   str = str.substring(i,str.length);
   return TimeOfDay(hour:int.parse(str.split(":")[0]),minute: int.parse(str.split(":")[1]));
   }

  void timePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
        // print(_selectedTime.toString());
        // print(_selectedTime);
        print(fromString1(_selectedTime.toString()) );
        timeVal = true;
      });
    });
  }
  
  void _submitData(){
    if(titleController.text.isEmpty){
      return;
    }
    if(_selectedDate == null || _selectedTime == null){
      return;
    }
    widget.ff(
       DateTime.now().toString(),
              titleController.text,
              _selectedDate,
              _selectedTime,
    );
    widget.notify(0,'New Task Added Successfully' , titleController.text ,DateTime.now());
    DateTime finalDate = new DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    if(DateTime.now().isBefore(finalDate.subtract(Duration(hours: 24))))
    widget.notify(1,'Task Pending in Next 24 Hours' , titleController.text , finalDate.subtract(Duration(hours: 24)) );
    if(DateTime.now().isBefore(finalDate.subtract(Duration(hours: 1))))
    widget.notify(2,'Task Pending in Next 60 Minutes' , titleController.text , finalDate.subtract(Duration(hours: 1)) );
    if(DateTime.now().isBefore(finalDate.subtract(Duration(minutes: 10))))
    widget.notify(3,'Task Pending in Next 10 Minutes' , titleController.text , finalDate.subtract(Duration(minutes: 10)) );
    // print(finalDate.subtract(Duration(minutes: 10)) );
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: TextStyle(
                fontFamily: 'Voltaire',
                color: Colors.black,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontFamily: 'Voltaire',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton.icon(
                  onPressed: () {
                    datePicker(context);
                  },
                  icon: Icon(Icons.date_range),
                  label: Text('Enter Date'),
                ),
                FlatButton.icon(
                  onPressed: () {
                    timePicker(context);
                  },
                  icon: Icon(Icons.access_time),
                  label: Text('Enter Time'),
                ),
              ],
            ),
            if(dateVal == true || timeVal == true || titleController.text.isNotEmpty)
            SizedBox(
              height: 30,
            ),
            if(dateVal == true || timeVal == true || titleController.text.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Card(
                margin: EdgeInsets.all(5),
                elevation: 5,
                child: Column(
                  children: [
                    Text(
                      '${titleController.text}',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'CoveredByYourGrace',
                        color: Colors.black,
                      ),
                    ),
                    if (dateVal == true)
                      Text(
                        'Date :--  ${DateFormat.yMMMMd().format(_selectedDate)}',
                        style: TextStyle(
                          fontFamily: 'Voltaire',
                          fontSize: 20,
                        ),
                      ),
                    if (timeVal == true)
                      Text(
                        'Time :--  ${_selectedTime.format(context)}',
                        style: TextStyle(
                          fontFamily: 'Voltaire',
                          fontSize: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              color: Colors.cyan[100],
              child: Text(
                'Add Task',
                style: TextStyle(
                  fontFamily: 'Voltaire',
                  fontSize: 25,
                ),
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
