import 'package:flutter/material.dart';
import 'dart:convert';

class Info {
  String id;
  String title;
  DateTime date;
  TimeOfDay time;
  Info({
    this.id,
    this.title,
    this.date,
    this.time,
  });

  

   factory Info.fromJson(Map<String, dynamic> jsonData) {
   TimeOfDay fromString1(String str){
   str = str.substring(0,str.length-1);
   int i=0;
   while(str.codeUnitAt(i) < 48 || str.codeUnitAt(i) > 57){
    i++;
   }
   str = str.substring(i,str.length);
   return TimeOfDay(hour:int.parse(str.split(":")[0]),minute: int.parse(str.split(":")[1]));
   }

    return Info(
      id: jsonData['id'],
      date: DateTime.parse(jsonData['date']),
      time : fromString1(jsonData['time']),
      title: jsonData['title'],
    );
  }

  static Map<String, dynamic> toMap(Info info) => {
        'id': info.id,
        'title' : info.title,
        'date' : info.date.toIso8601String(),
        'time' : info.time.toString(),
      };
}