import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import './models/info.dart';

class AddTask extends StatefulWidget {
  final Function ff;
  AddTask(this.ff);

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
        dateVal = true;
      });
    });
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
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
