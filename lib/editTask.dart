import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './todopage.dart';
import './models/info.dart';
class EditTask extends StatefulWidget {
   final Info user;
   final Function ff;
   EditTask(this.user,this.ff);

   @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
   TextEditingController titleController ;
  @override
  void initState() {
    titleController = TextEditingController(text: '${widget.user.title}');
    super.initState();
  }
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  bool timeVal;
  bool dateVal;
  void datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: widget.user.date,
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
      initialTime: widget.user.time,
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
  
  void _editData(Info user){
    if(titleController.text.isEmpty){
      return;
    }
    if(_selectedDate == null || _selectedTime == null){
      _selectedDate = user.date;
      _selectedTime = user.time;
    }
    
    setState(() {
      widget.user.title = titleController.text;
      widget.user.date = _selectedDate;
      widget.user.time = _selectedTime;
      
      widget.ff(
        widget.user.id,
        widget.user.title,
        widget.user.date,
        widget.user.time,
      );
    });
      
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
                label: Text('Edit Date'),
              ),
              FlatButton.icon(
                onPressed: () {
                  timePicker(context);
                },
                icon: Icon(Icons.access_time),
                label: Text('Edit Time'),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
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
            color: Colors.amber[300],
            child: Text(
              'Edit Task',
              style: TextStyle(
                fontFamily: 'Voltaire',
                fontSize: 25,
              ),
            ),
            onPressed: () =>_editData(widget.user),
          ),
        ],
      ),
    );
  }
}